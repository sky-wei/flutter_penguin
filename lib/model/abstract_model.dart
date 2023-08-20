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


import 'package:flutter_penguin/core/context.dart';
import 'package:flutter_penguin/core/database.dart';
import 'package:flutter_penguin/core/encrypt.dart';
import 'package:flutter_penguin/core/preferences.dart';
import 'package:flutter_penguin/core/settings.dart';
import 'package:flutter_penguin/data/source/repository.dart';
import 'package:flutter_penguin/util/easy_notifier.dart';
import 'package:flutter_penguin/util/message_util.dart';

class AbstractModel extends EasyNotifier {

  final XContext context;

  AbstractModel(this.context);

  XSettings get appSetting => context.appSetting;

  XPreferences get defaultPreferences => context.defaultPreferences;

  XDataManager get dataManager => context.dataManager;

  XEncrypt get encrypt => context.encrypt;

  XRepositoryFactory get repositoryFactory => context.repositoryFactory;

  // XUserManager get userManager => context.userManager;

  void showMessage(String msg) {
    MessageUtil.showMessage2(msg);
  }
}
