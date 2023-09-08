

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

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sky_library/widget/restart_widget.dart';

import 'abstract_model.dart';

class AppModel extends AbstractModel {

  AppModel(super.context);

  /// 重启应用
  void restartApp(BuildContext context) {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss(animation: false);
    }
    RestartWidget.restartApp(context);
  }

  /// 删除公共数据库
  Future<bool> deletePublicDatabase() async {
    return await deleteDatabaseBy(context.appDirectory);
  }

  /// 删除数据库文件
  Future<bool> deleteDatabaseBy(Directory directory) async {

    final Directory dataPath = Directory('${directory.path}/data.mdb');
    final Directory lockPath = Directory('${directory.path}/lock.mdb');

    if (dataPath.existsSync()) {
      dataPath.deleteSync();
    }

    if (lockPath.existsSync()) {
      lockPath.deleteSync();
    }
    return true;
  }
}