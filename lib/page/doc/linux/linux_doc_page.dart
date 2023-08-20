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
import 'package:flutter_penguin/util/list_controller.dart';
import 'package:flutter_penguin/util/size_box_util.dart';
import 'package:flutter_penguin/widget/color_box_widget.dart';
import 'package:flutter_penguin/widget/expand_box_widget.dart';
import 'package:flutter_penguin/widget/sub_scaffold.dart';

import 'doc_details_page.dart';
import 'doc_list_page.dart';

class LinuxDocPage extends StatefulWidget {

  final bool inline;

  const LinuxDocPage({
    Key? key,
    this.inline = false
  }) : super(key: key);

  @override
  State<LinuxDocPage> createState() => _LinuxDocPageState();
}

class _LinuxDocPageState extends State<LinuxDocPage> {

  final ListController _listController = ListController(initIndex: -1);

  @override
  Widget build(BuildContext context) {
    return SubScaffold(
      inline: widget.inline,
      body: _buildBodyWidget(),
    );
  }

  /// 创建内容控件
  Widget _buildBodyWidget() {
    return Row(
      children: [
        ExpandBoxWidget(
          flex: 3,
          child: DocListPage(
            inline: widget.inline,
            listController: _listController,
          ),
        ),
        XBox.horizontal8,
        ExpandBoxWidget(
          flex: 7,
          child: DocDetailsPage(
            inline: widget.inline,
            listController: _listController,
          ),
        ),
      ],
    );
  }
}

/// 空控件
class EmptyDocWidget extends StatelessWidget {

  final double? width;
  final String? message;

  const EmptyDocWidget({
    Key? key,
    this.width,
    this.message
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(
          //   'assets/avatar/Delivery boy.png',
          //   width: width ?? 300.w,
          // ),
          // XBox.vertical20,
          Text(
            message ?? '',
            style: TextStyle(
              color: Theme.of(context).hintColor,
            ),
          )
        ],
      ),
    );
  }
}

