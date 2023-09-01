
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

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_penguin/constant.dart';
import 'package:flutter_penguin/data/item/side_item.dart';
import 'package:flutter_penguin/dialog/message_dialog.dart';
import 'package:flutter_penguin/generated/l10n.dart';
import 'package:flutter_penguin/page/doc/cmd/cmd_doc_view.dart';
import 'package:flutter_penguin/page/setting/setting_page.dart';
import 'package:flutter_penguin/page/setting/setting_view_page.dart';
import 'package:flutter_penguin/theme/theme.dart';
import 'package:flutter_penguin/util/app_navigator.dart';
import 'package:flutter_penguin/util/launch_util.dart';
import 'package:flutter_penguin/util/message_util.dart';
import 'package:flutter_penguin/util/platform_util.dart';
import 'package:flutter_penguin/util/size_box_util.dart';
import 'package:flutter_penguin/widget/head_logo_widget.dart';
import 'package:flutter_penguin/widget/window_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'empty_page.dart';
import 'side_bar_view.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<SideItem> _sideItems = [
    SideItem(type: SortType.terminal, icon: 'assets/svg/ic_terminal.svg', name: '命令'),
    SideItem(type: SortType.favorite, icon: 'assets/svg/ic_favorites.svg', name: '收藏'),
    SideItem(type: SortType.setting, icon: 'assets/svg/ic_settings.svg', name: '设置'),
    SideItem(type: SortType.help, icon: 'assets/svg/ic_help.svg', name: '帮助'),
  ];

  @override
  Widget build(BuildContext context) {
    return PlatformUtil.isTabletMode()
        ? _buildDesktopBody() : _buildMobileBody();
  }

  Widget _buildMobileBody() {
    return MobileHomePage(sideItems: _sideItems);
  }

  Widget _buildDesktopBody() {
    return DesktopHomePage(sideItems: _sideItems);
  }
}

class DesktopHomePage extends StatefulWidget {

  final List<SideItem> sideItems;

  const DesktopHomePage({
    Key? key,
    required this.sideItems,
  }) : super(key: key);

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {

  final List<Widget> _children = const [
    CmdDocView(inline: true),
    CmdDocView(inline: true, listType: ListType.favorite),
    SettingViewPage(),
    EmptyPage(),
    EmptyPage(),
    EmptyPage(),
    EmptyPage(),
    EmptyPage(),
    EmptyPage(),
  ];

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (PlatformUtil.isMobile()) {
      final top = PlatformUtil.statusBarHeight();
      return Scaffold(
        backgroundColor: Theme.of(context).xColor.bottom,
        body: _buildBodyWidget(
            padding: EdgeInsets.fromLTRB(8.r, top, 8.r, 8.r)
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).xColor.bottom,
      body: Column(
        children: [
          _buildWindowTitleWidget(),
          Expanded(
            child: _buildBodyWidget(),
          )
        ],
      ),
    );
  }

  /// 窗口标题控件
  Widget _buildWindowTitleWidget() {

    final mainAxisAlignment = PlatformUtil.isMacOS()
        ? MainAxisAlignment.center : MainAxisAlignment.start;

    return Stack(
      children: [
        if (PlatformUtil.isPC())
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              HeadLogoWidget(
                logo: PlatformUtil.isMacOS() ? null : 'assets/svg/ic_head_logo.svg',
                title: S.of(context).appName,
                logoColor: Theme.of(context).themeColor,
                titleColor: Theme.of(context).mainTextColor,
              ),
            ],
          ),
        if (PlatformUtil.isPC())
          _buildWindowTitleBar()
      ],
    );
  }

  /// 创建内容控件
  Widget _buildBodyWidget({
    EdgeInsetsGeometry? padding
  }) {
    return Padding(
      padding: padding ?? REdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
            width: 80.r,
            child: DesktopSideBarView(
              controller: _pageController,
              sideItems: widget.sideItems,
              intercept: (item) => onIntercept(item),
            ),
          ),
          XBox.horizontal8,
          Expanded(
            child: PageView(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _children,
            ),
          ),
        ],
      ),
    );
  }

  /// 创建Bar
  Widget _buildWindowTitleBar() {
    return WindowTitleBarBox(
      child: Row(
        children: [
          Expanded(child: MoveWindow()),
          WindowButtons(onCloseWindow: _exitApp)
        ],
      ),
    );
  }

  /// 事件拦截
  bool onIntercept(SideItem item) {
    if (item.type == SortType.help) {
      // 帮助
      LaunchUtil.launch(XConstant.source);
      return true;
    }
    return false;
  }

  /// 退出应用
  void _exitApp() {
    showMessageDialog(
        context: context,
        title: '提示',
        message: '您确定要关闭当前应用？'
    ).then((value) {
      if (value == 1) appWindow.close();
    });
  }
}


class MobileHomePage extends StatefulWidget {

  final List<SideItem> sideItems;

  const MobileHomePage({
    Key? key,
    required this.sideItems,
  }) : super(key: key);

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {

  DateTime? _lastPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: CmdDocView(
        inline: true,
        drawer: MobileSideBarView(
          sideItems: widget.sideItems,
          intercept: (item) => onIntercept(item),
        ),
      ),
    );
  }

  /// 事件处理
  /// 事件拦截
  bool onIntercept(SideItem item) {
    if (item.type == SortType.favorite) {
      // 收藏
      AppNavigator.push(
        context,
        CmdDocView(inline: true, listType: ListType.favorite)
      );
      return true;
    } else if (item.type == SortType.setting) {
       // 设置
       AppNavigator.push(context, const SettingPage());
       return true;
     } else if (item.type == SortType.help) {
      // 帮助
      LaunchUtil.launch(XConstant.source);
      return true;
    }
    return false;
  }

  /// 返回事件处理
  Future<bool> _onWillPop() {

    if (_lastPressTime == null ||
        DateTime.now().difference(_lastPressTime!) > const Duration(seconds: 3)
    ) {
      _lastPressTime = DateTime.now();
      MessageUtil.showMessage(context, S.of(context).exitTips);
      return Future.value(false);
    }
    return Future.value(true);
  }
}

