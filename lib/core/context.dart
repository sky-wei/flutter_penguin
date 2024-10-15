
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

import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_penguin/constant.dart';
import 'package:flutter_penguin/core/preferences.dart';
import 'package:flutter_penguin/core/settings.dart';
import 'package:flutter_penguin/data/objectbox.dart';
import 'package:flutter_penguin/data/source/repository.dart';
import 'package:flutter_sky_library/flutter_sky_library.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart';
import 'encrypt.dart';


class BaseContext extends XContext {

  @override
  final XVersion appVersion = AppVersion(XConstant.versionName, 1);

  @override
  late Directory appDirectory;

  @override
  late XSettings appSetting;

  late SharedPreferences sharedPreferences;

  Future<void> initialize() async {
    appDirectory = await _getAppDirectory();
    sharedPreferences = await SharedPreferences.getInstance();
    appSetting = AppSettings(
      AppPreferences(
        name: 'settings',
        preferences: sharedPreferences
      )
    );
  }

  /// 获取App目录
  Future<Directory> _getAppDirectory() async {

    if (!kDebugMode) {
      return await getApplicationSupportDirectory();
    }

    final rootDirectory = await getTemporaryDirectory();
    final tempDirectory = Directory('${rootDirectory.path}/${XConstant.projectName}');

    if (!(await tempDirectory.exists())) {
      // 创建目录
      await tempDirectory.create(recursive: true);
    }
    return tempDirectory;
  }

  @override
  XComponentManager get componentManager => throw UnimplementedError();

  @override
  T getComponent<T extends XComponent>(String name) => throw UnimplementedError();

  @override
  XPreferences getPreferencesByName(String name) => throw UnimplementedError();
}


class AppContext extends EasyNotifier implements ComponentManager, XContext {

  final BaseContext _baseContext;
  final Map<String, XPreferences> _preferencesCache = HashMap();

  bool _init = false;

  @override
  late ComponentManager componentManager;

  @override
  XVersion get appVersion => _baseContext.appVersion;

  @override
  Directory get appDirectory => _baseContext.appDirectory;

  @override
  XSettings get appSetting => _baseContext.appSetting;

  AppContext({
    required BaseContext baseContext,
    ComponentManager? componentManager
  }) : _baseContext = baseContext, componentManager = componentManager ?? ComponentManager();

  @override
  /// 初始化
  Future<void> initialize() async {
    if (!_init) {
      _init = true;
      await Future.delayed(
          const Duration(milliseconds: 300)
      );
      componentManager.initialize();
      final objectBox = await ObjectBox.create(
          directory: appDirectory.path
      );
      componentManager.registerComponent(
          name: XDataManager.componentName,
          component: DataManager(this, objectBox)
      );
      onInitialize();
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  /// 初始化
  void onInitialize() {
    componentManager.registerLazyComponent(
        name: XEncrypt.componentName,
        builder: (componentManager) => EncryptStore()
    );
    // componentManager.registerLazyComponent(
    //     name: XNetService.componentName,
    //     builder: (componentManager) => NetService(this)
    // );
    componentManager.registerLazyComponent(
        name: XRepositoryFactory.componentName,
        builder: (componentManager) => RepositoryFactory(this)
    );
  }

  @override
  void dispose() {
    componentManager.dispose();
    super.dispose();
  }

  @override
  T getComponent<T extends XComponent>(String name) {
    return componentManager.getComponent(name);
  }

  @override
  bool hasComponent(String name) {
    return componentManager.hasComponent(name);
  }

  @override
  bool isDispose() {
    return componentManager.isDispose();
  }

  @override
  void registerComponent({required String name, required XComponent component}) {
    componentManager.registerComponent(name: name, component: component);
  }

  @override
  void registerLazyComponent({required String name, required BuildComponent builder}) {
    componentManager.registerLazyComponent(name: name, builder: builder);
  }

  @override
  void unregisterComponent(String name) {
    componentManager.unregisterComponent(name);
  }

  @override
  XPreferences getPreferencesByName(String name) {

    if (name.isEmpty) {
      throw Exception('名称不能为空！');
    }

    final preferences = _preferencesCache[name];

    if (preferences != null) {
      return preferences;
    }

    final appPreferences = AppPreferences(
        name: name,
        preferences: _baseContext.sharedPreferences
    );
    _preferencesCache[name] = appPreferences;

    return appPreferences;
  }
}


extension XContextExtension on XContext {

  XDataManager get dataManager => XDataManager.getDataManager(this);

  XRepositoryFactory get repositoryFactory => XRepositoryFactory.getRepositoryFactory(this);

  XPreferences get defaultPreferences => getPreferencesByName('penguin_default');

  // XNetService get netService => XNetService.getNetService(this);

  XEncrypt get encrypt => XEncrypt.getEncrypt(this);
}