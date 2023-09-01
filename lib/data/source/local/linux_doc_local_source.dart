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

import 'package:flutter_penguin/core/database.dart';
import 'package:flutter_penguin/data/data_exception.dart';
import 'package:flutter_penguin/data/entity/cmd_doc_entity.dart';
import 'package:flutter_penguin/data/entity/favorite_entity.dart';
import 'package:flutter_penguin/data/item/cmd_doc_item.dart';
import 'package:flutter_penguin/data/item/favorite_item.dart';
import 'package:flutter_penguin/data/mapper/cmd_doc_mapper.dart';
import 'package:flutter_penguin/data/mapper/favorite_mapper.dart';
import 'package:flutter_penguin/data/objectbox.g.dart';
import 'package:flutter_penguin/data/source/linux_doc_source.dart';

class LinuxDocLocalSource implements XLinuxDocSource {

  final XDataManager dataManage;

  Box<CmdDocEntity> get cmdDoc => dataManage.cmdDoc;
  Box<FavoriteEntity> get favorite => dataManage.favorite;

  LinuxDocLocalSource(this.dataManage);

  @override
  Future<CmdDocItem> getCmdDocDetails(int id) async {

    final entity = cmdDoc.get(id);

    if (entity == null) {
      throw DataException.message();
    }

    return CmdDocMapper.transformEntity(entity);
  }

  @override
  Future<List<CmdDocItem>> getCmdDocList(QueryCmdParam param) async {

    Condition<CmdDocEntity> qc = CmdDocEntity_.name.notNull();

    if (param.keyword.isNotEmpty) {
      qc = qc.and(CmdDocEntity_.name.contains(param.keyword, caseSensitive: false));
    }

    if (param.category >= 0) {
      qc = qc.and(CmdDocEntity_.categoryId.equals(param.category));
    }

    final query = cmdDoc.query(qc).build();

    final result = query.find();
    query.close();

    return CmdDocMapper.transformEntities(
      result,
      skipData: true
    );
  }

  @override
  Future<bool> importCmdDoc(List<CmdDocItem> items) async {
    
    cmdDoc.removeAll();
    
    return cmdDoc.putMany(
      CmdDocMapper.transformItems(items)
    ).isNotEmpty;
  }

  @override
  Future<FavoriteItem> addFavorite(FavoriteItem item) async {

    final id = favorite.put(
      FavoriteMapper.transformItem(item)
    );

    return item.copy(id: id);
  }

  @override
  Future<List<FavoriteItem>> getFavoriteList() async {
    return FavoriteMapper.transformEntities(favorite.getAll());
  }

  @override
  Future<FavoriteItem> removeFavorite(FavoriteItem item) async {

    favorite.remove(item.id);

    return item;
  }
}

