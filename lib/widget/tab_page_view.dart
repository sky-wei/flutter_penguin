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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_penguin/theme/theme.dart';
import 'package:flutter_penguin/util/border_util.dart';
import 'package:flutter_penguin/util/platform_util.dart';
import 'package:flutter_penguin/util/size_box_util.dart';

class TabPageView extends StatefulWidget {

  final EdgeInsetsGeometry? padding;
  final int initialPage;
  final List<TabItem> tabItems;

  const TabPageView({
    Key? key,
    this.padding,
    this.initialPage = 0,
    required this.tabItems,
  }) : super(key: key);

  @override
  State<TabPageView> createState() => _TabPageViewState();
}

class _TabPageViewState extends State<TabPageView> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: widget.initialPage, length: widget.tabItems.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabBarWidget(),
        XBox.vertical30,
        Expanded(
          child: _buildTabPageWidget(),
        ),
      ],
    );
  }

  /// 创建标题控件
  Widget _buildTabBarWidget() {
    return TabBar(
      isScrollable: true,
      labelColor: Theme.of(context).themeColor,
      labelStyle: TextStyle(
        color: Theme.of(context).themeColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500
      ),
      unselectedLabelColor: Theme.of(context).mainTextColor,
      unselectedLabelStyle: TextStyle(
        color: Theme.of(context).mainTextColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.normal
      ),
      indicatorColor: Theme.of(context).themeColor,
      splashBorderRadius: XBorder.borderRadius6,
      controller: _tabController,
      tabs: _buildTabWidgets()
    );
  }

  /// 创建标题控件
  List<Widget> _buildTabWidgets() {
    return <Tab>[
      for (var item in widget.tabItems)
        Tab(
          text: item.title,
          height: PlatformUtil.isTabletMode() ? 46.r : 40.r,
        ),
    ];
  }

  /// 创建内容控件
  Widget _buildTabPageWidget() {

    final children = widget.tabItems.map((e) => e.child).toList();

    return TabBarView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }
}

class TabItem {

  final String title;
  final Widget child;

  TabItem(this.title, this.child);
}


