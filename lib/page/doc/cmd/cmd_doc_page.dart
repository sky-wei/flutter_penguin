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
import 'package:flutter_sky_library/util/list_controller.dart';
import 'package:flutter_sky_library/util/platform_util.dart';
import 'package:flutter_sky_library/util/size_box_util.dart';
import 'package:flutter_sky_library/widget/expand_box_widget.dart';
import 'package:flutter_sky_library/widget/sub_scaffold.dart';

import 'cmd_list_page.dart';
import 'doc_details_page.dart';

class CmdDocPage extends StatefulWidget {

  final bool inline;
  final Widget? leading;
  final ListType listType;

  const CmdDocPage({
    Key? key,
    this.inline = false,
    this.leading,
    this.listType = ListType.all
  }) : super(key: key);

  @override
  State<CmdDocPage> createState() => _CmdDocPageState();
}

class _CmdDocPageState extends State<CmdDocPage> {

  final ListController _listController = ListController(initIndex: -1);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _listController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final bodyWidget = PlatformUtil.isTabletMode()
        ? _buildDesktopBody() : _buildMobileBody();

    return SubScaffold(
      inline: widget.inline,
      body: bodyWidget,
    );
  }

  /// 创建内容控件
  Widget _buildMobileBody() {
    return CmdListPage(
      inline: widget.inline,
      leading: widget.leading,
      listType: widget.listType,
    );
  }

  /// 创建内容控件
  Widget _buildDesktopBody() {
    return Row(
      children: [
        ExpandBoxWidget(
          flex: 3,
          child: CmdListPage(
            inline: widget.inline,
            listController: _listController,
            listType: widget.listType,
          ),
        ),
        XBox.horizontal8,
        ExpandBoxWidget(
          flex: 8,
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

