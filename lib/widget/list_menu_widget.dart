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
import 'package:flutter_penguin/constant.dart';
import 'package:flutter_penguin/data/item/sub_menu_item.dart';
import 'package:flutter_penguin/theme/theme.dart';
import 'package:flutter_penguin/util/border_util.dart';
import 'package:flutter_penguin/util/list_controller.dart';
import 'package:flutter_penguin/util/size_box_util.dart';

import 'sub_item_line.dart';
import 'sub_menu_widget.dart';
import 'sub_title_widget.dart';

class ListMenuWidget extends StatefulWidget {

  final ListController? controller;
  final ValueChanged<int>? onItemTap;
  final String? title;
  final List<SubMenuItem> menuItems;
  final InterceptCallback<SubMenuItem>? intercept;

  const ListMenuWidget({
    Key? key,
    this.controller,
    this.onItemTap,
    this.title,
    this.menuItems = const <SubMenuItem>[],
    this.intercept
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListMenuWidgetState();
}

class _ListMenuWidgetState extends State<ListMenuWidget> {

  String? get title => widget.title;
  List<SubMenuItem> get menuItems => widget.menuItems;
  ListController? get controller => widget.controller;

  int _lastIndex = -1;

  @override
  void initState() {
    super.initState();
    final index = controller?.value ?? -1;
    if (index != -1) {
      for (var menu in menuItems) {
        if (menu.id == index) {
          _lastIndex = index;
        }
      }
    }
    controller?.addListener(_onValueChange);
  }

  @override
  void dispose() {
    controller?.removeListener(_onValueChange);
    super.dispose();
  }

  void _onValueChange() {

    if (_lastIndex < 0) {
      // 不需要处理
      return;
    }

    if (_lastIndex != controller?.value) {
      setState(() {
        _lastIndex = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) SubTitleWidget(title: title!),
        if (title != null) XBox.vertical15,
        Material(
          color: Theme.of(context).xColor.surface,
          borderRadius: XBorder.borderRadius6,
          child: ListView.separated(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return _buildMenuWidget(index);
            },
            separatorBuilder: (context, index) {
              return _buildLineWidget(index);
            },
            itemCount: menuItems.length
          )
        )
      ],
    );
  }

  /// 创建菜单
  Widget _buildMenuWidget(int index) {

    final menu = menuItems[index];
    final length = menuItems.length;

    if (menu.type == MenuType.xSwitch) {
      return SubMenuWidget(
        iconName: menu.iconName,
        title: menu.title,
        desc: menu.desc,
        value: menu.value,
        moreIconName: menu.moreIconName,
        moreIconColor: menu.type == MenuType.check ? Theme.of(context).themeColor : null,
        borderType: length == 1 ? BorderType.topBottom : index == 0 ? BorderType.top : length == index + 1 ? BorderType.bottom : BorderType.center,
        switchValue: menu.data,
        onChanged: (value) => _onClickEvent(menu),
      );
    }

    return SubMenuWidget(
      iconName: menu.iconName,
      title: menu.title,
      desc: menu.desc,
      value: menu.value,
      moreIconName: menu.moreIconName,
      choose: controller?.value == menu.id,
      moreIconColor: menu.type == MenuType.check ? Theme.of(context).themeColor : null,
      borderType: length == 1 ? BorderType.topBottom : index == 0 ? BorderType.top : length == index + 1 ? BorderType.bottom : BorderType.center,
      onTap: () => _onClickEvent(menu),
    );
  }

  void _onClickEvent(SubMenuItem menu) {

    final onItemTap = widget.onItemTap;

    _onInterceptAction(
      menu: menu,
      callback: () {
        if (onItemTap != null) {
          onItemTap(menu.id);
        } else if (controller != null) {
          setState(() {
            _lastIndex = menu.id;
            controller!.value = menu.id;
          });
        }
      }
    );
  }

  void _onInterceptAction({
    required SubMenuItem menu,
    required VoidCallback callback
  }) {
    final intercept = widget.intercept;
    if (intercept == null || !intercept(menu)) {
      callback();
    }
  }

  /// 创建分割线
  Widget _buildLineWidget(int index) {
    final menu = menuItems[index];
    return menu.iconName != null
        ? SubItemLine(padding: REdgeInsets.only(left: 50))
        : SubItemLine(padding: REdgeInsets.only(left: 15));
  }
}

