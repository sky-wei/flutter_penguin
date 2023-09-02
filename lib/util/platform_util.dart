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
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_penguin/constant.dart';
import 'package:flutter_penguin/core/context.dart';
import 'package:flutter_penguin/core/settings.dart';
import 'package:flutter_penguin/theme/theme.dart';

import 'border_util.dart';
import 'size_box_util.dart';

class PlatformUtil {

  static bool _tabletMode = XConstant.defaultTabletMode;

  PlatformUtil._();

  /// 是否是手机端或平板
  static bool isMobile() {
    return Platform.isAndroid || Platform.isIOS;
  }

  /// 是否是PC
  static bool isPC() {
    return Platform.isLinux || Platform.isWindows || Platform.isMacOS;
  }

  /// 是不是mac
  static bool isMacOS() => Platform.isMacOS;

  /// 显示标题Logo
  static bool showHeadLogo() {
    return Platform.isLinux || Platform.isWindows;
  }

  /// 是否是平板模式
  static bool isTabletMode() => _tabletMode;

  /// 状态栏高度
  static double statusBarHeight() {
    return MediaQueryData.fromWindow(window).padding.top;
  }

  /// 是否是横屏
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// 是否是竖屏
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// 设置横屏还是竖屏
  static void setPreferredOrientations(
      BuildContext context, Orientation orientation
  ) {
    if (Orientation.landscape == orientation
        && PlatformUtil.isPortrait(context)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ]);
    } else if (Orientation.portrait == orientation
        && PlatformUtil.isLandscape(context)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]);
    }
  }

  static void setUIOverlayStyle(XContext context) {

    if (!PlatformUtil.isMobile()) {
      return;
    }

    final darkMode = context.appSetting.getDarkMode(XTheme.system);
    final navigationBarColor = XTheme.dark == darkMode
        ? const Color(0xFF363636) : Colors.transparent;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: navigationBarColor,
      ),
    );
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual, overlays: [SystemUiOverlay.top]
    // );
  }

  /// 初始化
  static void initialize(XSettings appSetting) {
    XBox.initialize();
    XBorder.initialize();
    _tabletMode = PlatformUtil.isPC() || appSetting.isTabletMode();
  }
}

