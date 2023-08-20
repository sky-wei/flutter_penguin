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

import 'dart:io';

import 'package:flutter_penguin/data/data_exception.dart';
import 'package:flutter_penguin/data/entity/linux_doc_entity.dart';
import 'package:flutter_penguin/data/objectbox.dart';
import 'package:objectbox/objectbox.dart';

import 'component.dart';
import 'context.dart';

abstract class XDataManager implements XComponent {

  static const String componentName = 'dataManager';

  static XDataManager getDataManager(XContext context) {
    return context.getComponent(componentName);
  }

  Box<LinuxDocEntity> get linuxDoc;

  /// 创建指定用户的数据库
  Future<bool> create(int userId);
}


class DataManager extends AbstractComponent implements XDataManager {

  final XContext _context;
  final ObjectBox _publicObjectBox;

  ObjectBox? _userObjectBox;

  @override
  Box<LinuxDocEntity> get linuxDoc => _publicObjectBox.linuxDoc;

  DataManager(this._context, this._publicObjectBox);

  @override
  Future<bool> create(int userId) async {

    if (_userObjectBox != null) {
      throw DataException.message('数据库重复创建！');
    }

    final rootPath = _context.appDirectory.path;
    final dataPath = Directory('$rootPath/$userId');
    if (!dataPath.existsSync()) {
      dataPath.createSync(recursive: true);
    }

    _userObjectBox = await ObjectBox.create(
        directory: dataPath.path
    );

    return _userObjectBox != null;
  }

  @override
  void dispose() {
    _userObjectBox?.dispose();
    _publicObjectBox.dispose();
    super.dispose();
  }
}