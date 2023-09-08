/*
 * Copyright (c) 2023 The sky Authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_penguin/constant.dart';
import 'package:flutter_penguin/data/item/cmd_doc_item.dart';
import 'package:flutter_penguin/data/item/favorite_item.dart';
import 'package:flutter_penguin/data/source/linux_doc_source.dart';
import 'package:flutter_penguin/generated/json/base/json_convert_content.dart';
import 'package:flutter_penguin/model/abstract_model.dart';
import 'package:flutter_sky_library/flutter_sky_library.dart';

class CmdDocModel extends AbstractModel {

  final EasyNotifier detailsNotifier = EasyNotifier();

  final String _docName = 'assets/doc/linux/cmd_doc.json';
  final QueryDoc _queryDoc = _createDefault();
  final List<CmdDocItem> _cmdDocItems = [];
  final Map<String, FavoriteItem> _favoriteMap = { };

  final Map<int, String> categoryIndex = {
    0: "其他",
    1: "文本处理",
    2: "系统管理",
    3: "磁盘维护",
    4: "系统设置",
    5: "电子邮件与新闻组",
    6: "文件管理",
    7: "文件传输",
    8: "磁盘管理",
    9: "网络通讯",
    10: "备份压缩"
  };

  CmdDocItem? _cmdDocItem;

  XLinuxDocSource get linuxDocSource => repositoryFactory.createLinuxDocSource();

  List<CmdDocItem> get cmdDocItems => _cmdDocItems;
  QueryDoc get queryDoc => _queryDoc;
  CmdDocItem? get cmdDocItem => _cmdDocItem;

  CmdDocModel(super.context);

  void clearCmdDocItem() {
    _cmdDocItem = null;
  }

  @override
  void dispose() {
    super.dispose();
    detailsNotifier.dispose();
  }

  /// 刷新列表
  Future<void> refreshDocList({
    required ListType listType,
    String? keyword,
    int? category,
    int? delayedTime,
  }) async {

    if (keyword != null) {
      queryDoc.keyword = keyword;
    }

    if (category != null) {
      queryDoc.category = category;
    }

    if (delayedTime != null) {
      await Future.delayed(
          Duration(milliseconds: delayedTime)
      );
    }

    /// 刷新订单
    await _refreshDocList(listType);
  }

  /// 请求详情信息
  Future<void> requestDetail(CmdDocItem item, [int? delayed]) async {

    final result = await linuxDocSource.getCmdDocDetails(item.id);

    if (delayed != null && delayed > 0) {
      await Future.delayed(Duration(milliseconds: delayed));
    }

    detailsNotifier.notify(() {
      // 详情结果
      _cmdDocItem = result;
    });
  }

  /// 添加收藏
  Future<void> favoriteCmdDoc(ListType listType, CmdDocItem item) async {

    if (item.favorite) {
      // 删除收藏
      item.favorite = false;
      final favorite = _favoriteMap.remove(item.name);
      if (favorite != null) {
        await linuxDocSource.removeFavorite(favorite);
      }
      if (ListType.favorite == listType) {
        _cmdDocItems.remove(item);
      }
    } else {
      // 添加收藏
      item.favorite = true;
      final favorite = await linuxDocSource.addFavorite(
          FavoriteItem.cmd(item.name)
      );
      _favoriteMap.putIfAbsent(favorite.key, () => favorite);
    }
    notify();
  }

  /// 重新请求命令信息
  Future<void> _refreshDocList(ListType listType) async {

    if (_isImportCmdDoc()) {
      // 导入命令
      if (await _importCmdDoc(_docName)) {
        // 保存版本信息
        _saveCmdDocVersion();
      }
    }

    // 加载收藏列表
    await _loadFavoriteList();

    final result = await linuxDocSource.getCmdDocList(
      QueryCmdParam()
        ..category = queryDoc.category
        ..keyword = queryDoc.keyword
    );

    if (XLog.isDebug && result.isEmpty) {
      // 需要重置下(测试下会删除数据库)
      _saveCmdDocVersion(-1);
    }

    for (var item in result) {
      item.category = categoryIndex[item.categoryId] ?? categoryIndex[0]!;
      item.favorite = _favoriteMap.containsKey(item.name);
    }

    final newResult = <CmdDocItem>[];

    if (ListType.favorite == listType) {
      for (var item in result) {
        if (item.favorite) {
          newResult.add(item);
        }
      }
    } else {
      newResult.addAll(result);
    }

    notify(() {
      _cmdDocItems.clear();
      _cmdDocItems.addAll(newResult);
    });
  }

  /// 加载收藏列表
  Future<void> _loadFavoriteList() async {

    final list = await linuxDocSource.getFavoriteList();

    _favoriteMap.clear();

    list.forEachX((e) {
      _favoriteMap.putIfAbsent(e.key, () => e);
    });
  }

  /// 是否需要导入命令
  bool _isImportCmdDoc() {
    return XCmdDoc.version != defaultPreferences.getInt('cmd_doc_version');
  }

  /// 保存导入的版本
  void _saveCmdDocVersion([int version = XCmdDoc.version]) {
    defaultPreferences.setInt('cmd_doc_version', version);
  }

  /// 导入文件
  Future<bool> _importCmdDoc(String fileName) async {

    final data = await rootBundle.loadString(fileName);
    final items = JsonConvert.fromJsonAsT<List<CmdDocItem>>(
        json.decode(data)
    );

    if (items == null) {
      // 没有数据导入
      return false;
    }

    XLog.d('导入数据 ${items.length} 条');

    // 导入数据
    return await linuxDocSource.importCmdDoc(items);
  }

  /// 创建默认查询条件
  static QueryDoc _createDefault() {
    return QueryDoc();
  }
}


class QueryDoc {

  String keyword = '';
  int category = -1;
  int page = 0;
  int pageSize = 20;
}
