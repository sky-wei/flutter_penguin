
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
import 'package:flutter_penguin/util/list_controller.dart';
import 'package:flutter_penguin/util/size_box_util.dart';

import 'list_menu_widget.dart';
import 'sub_scaffold.dart';

class SubGroupWidget extends StatelessWidget {

  final ListController? controller;
  final ValueChanged<int>? onItemTap;
  final String? title;
  final List<SubGroupItem> groupItems;
  final InterceptCallback<SubMenuItem>? intercept;

  bool get inline => controller != null;

  const SubGroupWidget({
    Key? key,
    this.controller,
    this.onItemTap,
    this.title,
    required this.groupItems,
    this.intercept
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubScaffold(
      inline: inline,
      title: title,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: REdgeInsets.fromLTRB(15, 15, 15, 30),
      itemBuilder: (context, index) {
        return _buildItemWidget(groupItems[index]);
      },
      separatorBuilder: (context, index) {
        return _buildLienWidget();
      },
      itemCount: groupItems.length,
    );
  }

  Widget _buildItemWidget(SubGroupItem group) {
    final onItemTap = !inline ? this.onItemTap : null;
    return ListMenuWidget(
      controller: controller,
      onItemTap: onItemTap,
      title: group.title,
      menuItems: group.menuItems,
      intercept: intercept,
    );
  }

  Widget _buildLienWidget() {
    return XBox.vertical20;
  }
}

