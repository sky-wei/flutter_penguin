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

import 'package:flutter_penguin/util/log_util.dart';

import 'entity/cmd_doc_entity.dart';
import 'entity/favorite_entity.dart';
import 'objectbox.g.dart';

class ObjectBox {

  late final Store store;

  late final Box<CmdDocEntity> cmdDoc;
  late final Box<FavoriteEntity> favorite;

  ObjectBox._create(this.store) {
    cmdDoc = Box<CmdDocEntity>(store);
    favorite = Box<FavoriteEntity>(store);
  }

  /// 创建ObjectBox
  static Future<ObjectBox> create({
    String? directory
  }) async {
    XLog.d('>>>>>>>>>>>>>>> $directory');
    final store = await openStore(
        directory: directory,
        macosApplicationGroup: 'flutter.penguin'
    );
    return ObjectBox._create(store);
  }

  /// 释放资源
  void dispose() {
    if (!store.isClosed()) store.close();
  }
}