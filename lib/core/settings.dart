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

import 'package:flutter/material.dart';
import 'package:flutter_penguin/constant.dart';
import 'package:flutter_penguin/core/preferences.dart';

abstract class XSettings {

  int getDarkMode(int defaultValue);

  Future<bool> setDarkMode(int mode);

  Locale? getLocale();

  Future<bool> setLocale(Locale? locale);

  bool isTabletMode();

  Future<bool> setTabletMode(bool enable);

  double getDisplaySize();

  Future<bool> setDisplaySize(double size);

  double getFontSize();

  Future<bool> setFontSize(double size);

  bool isOfflineMode();

  Future<bool> setOfflineMode(bool enable);
}


class AppSettings implements XSettings {

  final XPreferences _preferences;

  AppSettings(this._preferences);

  /// 获取主题模式
  @override
  int getDarkMode(int defaultValue) {
    return _preferences.getInt('dark_mode', defaultValue);
  }

  /// 设置主题模式
  @override
  Future<bool> setDarkMode(int mode) {
    return _preferences.setInt('dark_mode', mode);
  }

  /// 获取Locale
  @override
  Locale? getLocale() {
    final language = _preferences.getString('language');
    if (language.isNotEmpty) {
      final values = language.split('_');
      if (values.length == 2 && values[0].isNotEmpty) {
        final languageCode = values[0];
        final countryCode = values[1].isNotEmpty ? values[1] : null;
        return Locale.fromSubtags(
            languageCode: languageCode, countryCode: countryCode
        );
      }
    }
    return null;
  }

  /// 设置Locale
  @override
  Future<bool> setLocale(Locale? locale) {
    if (locale == null) {
      return _preferences.setString('language', '');
    }
    return _preferences.setString(
        'language', '${locale.languageCode}_${locale.countryCode ?? ''}'
    );
  }

  /// 是否是平板模式
  @override
  bool isTabletMode() {
    return _preferences.getBool('tablet_mode', XConstant.defaultTabletMode);
  }

  /// 设置平板模式
  @override
  Future<bool> setTabletMode(bool enable) {
    return _preferences.setBool('tablet_mode', enable);
  }

  /// 获取显示大小
  @override
  double getDisplaySize() {
    return _preferences.getDouble('display_size', 1.0);
  }

  /// 设置显示大小
  @override
  Future<bool> setDisplaySize(double size) {
    return _preferences.setDouble('display_size', size);
  }

  /// 获取字体大小
  @override
  double getFontSize() {
    return _preferences.getDouble('font_size', 1.0);
  }

  /// 设置字体大小
  @override
  Future<bool> setFontSize(double size) {
    return _preferences.setDouble('font_size', size);
  }

  @override
  bool isOfflineMode() {
    return _preferences.getBool('offline_mode', XConstant.defaultTabletMode);
  }

  @override
  Future<bool> setOfflineMode(bool enable) {
    return _preferences.setBool('offline_mode', enable);
  }
}

