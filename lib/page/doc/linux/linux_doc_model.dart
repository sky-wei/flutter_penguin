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
import 'package:flutter_penguin/data/item/linux_doc_item.dart';
import 'package:flutter_penguin/data/source/linux_doc_source.dart';
import 'package:flutter_penguin/generated/json/base/json_convert_content.dart';
import 'package:flutter_penguin/model/abstract_model.dart';
import 'package:flutter_penguin/util/easy_notifier.dart';
import 'package:flutter_penguin/util/log_util.dart';

class LinuxDocModel extends AbstractModel {

  final EasyNotifier detailsNotifier = EasyNotifier();

  final String _docName = 'assets/doc/linux/linux_doc.json';
  final QueryDoc _queryDoc = _createDefault();
  final List<LinuxDocItem> _linuxDocItems = [];

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

  LinuxDocItem? _linuxDocItem;

  XLinuxDocSource get linuxDocSource => repositoryFactory.createLinuxDocSource();

  List<LinuxDocItem> get linuxDocItems => _linuxDocItems;
  QueryDoc get queryDoc => _queryDoc;
  LinuxDocItem? get linuxDocItem => _linuxDocItem;

  LinuxDocModel(super.context);

  @override
  void dispose() {
    super.dispose();
    detailsNotifier.dispose();
  }

  /// 刷新列表
  Future<void> refreshDocList({
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
    await _refreshDocList();
  }

  /// 请求详情信息
  Future<void> requestDetail(LinuxDocItem item) async {

    final result = await linuxDocSource.getDetails(item.id);

    detailsNotifier.notify(() {
      // 详情结果
      _linuxDocItem = result;
    });
  }

  /// 重新请求命令信息
  Future<void> _refreshDocList() async {

    if (_isImportLinuxDoc()) {
      // 导入命令
      if (await _importLinuxDoc(_docName)) {
        // 保存版本信息
        _saveLinuxDocVersion();
      }
    }

    final result = await linuxDocSource.getDocList(
      QueryParam()
        ..category = queryDoc.category
        ..keyword = queryDoc.keyword
    );

    if (XLog.isDebug && result.isEmpty) {
      // 需要重置下(测试下会删除数据库)
      _saveLinuxDocVersion(-1);
    }

    for (var item in result) {
      item.category = categoryIndex[item.categoryId] ?? categoryIndex[0]!;
    }

    notify(() {
      _linuxDocItems.clear();
      _linuxDocItems.addAll(result);
    });
  }

  /// 是否需要导入命令
  bool _isImportLinuxDoc() {
    return XLinuxDoc.version != defaultPreferences.getInt('linux_doc_version');
  }

  /// 保存导入的版本
  void _saveLinuxDocVersion([int version = XLinuxDoc.version]) {
    defaultPreferences.setInt('linux_doc_version', version);
  }

  /// 导入文件
  Future<bool> _importLinuxDoc(String fileName) async {

    final data = await rootBundle.loadString(fileName);
    final items = JsonConvert.fromJsonAsT<List<LinuxDocItem>>(
        json.decode(data)
    );

    if (items == null) {
      // 没有数据导入
      return false;
    }

    XLog.d('导入数据 ${items.length} 条');

    // 导入数据
    return await linuxDocSource.importDoc(items);
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
