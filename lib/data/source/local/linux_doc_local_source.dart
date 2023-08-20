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
import 'package:flutter_penguin/data/entity/linux_doc_entity.dart';
import 'package:flutter_penguin/data/item/linux_doc_item.dart';
import 'package:flutter_penguin/data/mapper/linux_doc_mapper.dart';
import 'package:flutter_penguin/data/objectbox.g.dart';
import 'package:flutter_penguin/data/source/linux_doc_source.dart';

class LinuxDocLocalSource implements XLinuxDocSource {

  final XDataManager dataManage;

  Box<LinuxDocEntity> get linuxDoc => dataManage.linuxDoc;

  LinuxDocLocalSource(this.dataManage);

  @override
  Future<LinuxDocItem> getDetails(int id) async {

    final entity = linuxDoc.get(id);

    if (entity == null) {
      throw DataException.message();
    }

    return LinuxDocMapper.transformEntity(entity);
  }

  @override
  Future<List<LinuxDocItem>> getDocList(QueryParam param) async {

    Condition<LinuxDocEntity> qc = LinuxDocEntity_.name.notNull();

    if (param.keyword.isNotEmpty) {
      qc = qc.and(LinuxDocEntity_.name.contains(param.keyword, caseSensitive: false));
    }

    if (param.category >= 0) {
      qc = qc.and(LinuxDocEntity_.categoryId.equals(param.category));
    }

    final query = linuxDoc.query(qc).build();

    final result = query.find();
    query.close();

    return LinuxDocMapper.transformEntities(
      result,
      skipData: true
    );
  }

  @override
  Future<bool> importDoc(List<LinuxDocItem> items) async {
    
    linuxDoc.removeAll();
    
    return linuxDoc.putMany(
      LinuxDocMapper.transformItems(items)
    ).isNotEmpty;
  }
}

