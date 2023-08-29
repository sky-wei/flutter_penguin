
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
import 'package:flutter_penguin/data/item/side_item.dart';
import 'package:flutter_penguin/generated/l10n.dart';
import 'package:flutter_penguin/theme/color.dart';
import 'package:flutter_penguin/theme/theme.dart';
import 'package:flutter_penguin/util/border_util.dart';
import 'package:flutter_penguin/util/size_box_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DesktopSideBarView extends StatefulWidget {

  final PageController controller;
  final List<SideItem> sideItems;
  final InterceptCallback<SideItem>? intercept;

  const DesktopSideBarView({
    required this.controller,
    required this.sideItems,
    this.intercept,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DesktopSideBarViewState();
}

class _DesktopSideBarViewState extends State<DesktopSideBarView> {

  int _currentIndex = 0;

  List<SideItem> get _sideItems => widget.sideItems;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.controller.initialPage;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ListView(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              for (var index = 0; index < _sideItems.length - 2; index++)
                _buildSideWidget(index, _sideItems[index]),
            ],
          ),
        ),
        XBox.vertical20,
        for (var index = _sideItems.length - 2; index < _sideItems.length; index++)
          _buildSideWidget(index, _sideItems[index]),
      ],
    );
  }

  Widget _buildSideWidget(int index, SideItem side) {
    return _buildSideItemWidget(
      side: side,
      choose: _currentIndex == index,
      onTap: () => _onInterceptAction(
        side: side,
        callback: () => _setCurrentIndex(index)
      )
    );
  }

  Widget _buildSideItemWidget({
    required SideItem side,
    required bool choose,
    GestureTapCallback? onTap,
  }) {

    final Widget child = _buildMeWidget(
        side: side, choose: choose
    );

    return _buildChooseWidget(
      side: side,
      choose: choose,
      onTap: onTap,
      child: child
    );
  }

  Widget _buildMeWidget({
    required SideItem side,
    required bool choose,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          side.icon ?? 'assets/svg/ic_user.svg',
          width: 24.r,
          color: choose ? Theme.of(context).themeColor : Theme.of(context).mainTextColor,
        ),
        XBox.vertical5,
        Text(
          side.name ?? '',
          style: TextStyle(
            fontSize: 16.sp,
            color: choose ? Theme.of(context).themeColor : Theme.of(context).mainTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildChooseWidget({
    required SideItem side,
    required bool choose,
    required Widget child,
    GestureTapCallback? onTap,
  }) {
    return Material(
      color: XColor.transparent,
      child: Ink(
        height: 80.h,
        decoration: BoxDecoration(
            color: choose ? Theme.of(context).highlightColor : XColor.transparent,
            borderRadius: XBorder.borderRadius6
        ),
        child: Stack(
          children: [
            InkWell(
                borderRadius: XBorder.borderRadius6,
                onTap: onTap,
                child: Center(
                  child: child
                )
            ),
            if (choose)
              _sideTagWidget(),
          ],
        ),
      ),
    );
  }

  Widget _sideTagWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 4.r,
        height: 40.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Theme.of(context).themeColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(3.r),
                  bottomRight: Radius.circular(3.r)
              )
          ),
        ),
      ),
    );
  }

  void _onInterceptAction({
    required SideItem side,
    required VoidCallback callback
  }) {
    final intercept = widget.intercept;

    if (intercept == null || !intercept(side)) {
      callback();
    }
  }

  /// 切换界面
  void _setCurrentIndex(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
        widget.controller.jumpToPage(index);
      });
    }
  }
}



class MobileSideBarView extends StatefulWidget {

  final PageController? controller;
  final List<SideItem> sideItems;
  final InterceptCallback<SideItem>? intercept;

  const MobileSideBarView({
    this.controller,
    required this.sideItems,
    this.intercept,
    Key? key,
  }) : super(key: key);

  @override
  State<MobileSideBarView> createState() => _MobileSideBarViewState();
}

class _MobileSideBarViewState extends State<MobileSideBarView> {

  int _currentIndex = 0;

  List<SideItem> get _sideItems => widget.sideItems;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.controller?.initialPage ?? 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildDrawerHeader(),
                  )
                ],
              ),
              for (var index = 0; index < _sideItems.length - 2; index++)
                _buildSideWidget(index, _sideItems[index]),
              const Divider(),
              for (var index = _sideItems.length - 2; index < _sideItems.length; index++)
                _buildSideWidget(index, _sideItems[index]),
            ]
        ),
      ),
    );
  }

  /// 创建 DrawerHeader
  DrawerHeader _buildDrawerHeader() {
    return DrawerHeader(
      // decoration: const BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage('assets/image/ic_head_background.jpeg'),
      //       fit: BoxFit.cover
      //     )
      // ),
      child: Column(
        children: [
          XBox.vertical20,
          SvgPicture.asset(
            'assets/svg/ic_linux.svg',
            width: 50.r,
            color: Theme.of(context).themeColor,
          ),
          XBox.vertical20,
          Text(
            S.current.appName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.sp,
              color: Theme.of(context).mainTextColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSideWidget(int index, SideItem side) {
    return _buildListTile(
        icon: side.icon ?? 'assets/svg/ic_user.svg',
        title: side.name ?? '',
        onTap: () {
          Scaffold.of(context).closeDrawer();
          _onInterceptAction(
            side: side,
            callback: () => _setCurrentIndex(index)
          );
        },
        selected: _currentIndex == index
    );
  }

  /// 创建 ListTile
  ListTile _buildListTile({
    required String icon,
    Color? iconColor,
    required String title,
    Color? titleColor,
    GestureTapCallback? onTap,
    bool selected = false
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width: 22.r,
        color: iconColor ?? (selected ? Theme.of(context).themeColor : Theme.of(context).iconTheme.color),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: titleColor ?? (selected ? Theme.of(context).themeColor : Theme.of(context).mainTextColor)
        ),
      ),
      onTap: onTap,
      selected: selected,
    );
  }

  void _onInterceptAction({
    required SideItem side,
    required VoidCallback callback
  }) {
    final intercept = widget.intercept;

    if (intercept == null || !intercept(side)) {
      callback();
    }
  }

  /// 切换界面
  void _setCurrentIndex(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
        widget.controller?.jumpToPage(index);
      });
    }
  }
}
