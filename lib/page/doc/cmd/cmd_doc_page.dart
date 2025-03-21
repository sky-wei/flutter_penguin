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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sky_library/flutter_sky_library.dart';
import 'package:flutter_sky_library/util/list_controller.dart';
import 'package:flutter_sky_library/util/platform_util.dart';
import 'package:flutter_sky_library/util/size_box_util.dart';
import 'package:flutter_sky_library/widget/expand_box_widget.dart';
import 'package:flutter_sky_library/widget/sub_scaffold.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'cmd_list_page.dart';
import 'doc_details_page.dart';

class CmdDocPage extends StatefulWidget {

  final bool inline;
  final Widget? leading;
  final ListType listType;

  const CmdDocPage({
    super.key,
    this.inline = false,
    this.leading,
    this.listType = ListType.all
  });

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
          borderRadius: BorderRadius.horizontal(left: Radius.circular(6.r)),
          child: CmdListPage(
            inline: widget.inline,
            listController: _listController,
            listType: widget.listType,
          ),
        ),
        XBox.horizontal(2),
        ExpandBoxWidget(
          flex: 8,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(6.r)),
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
    super.key,
    this.width,
    this.message
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'ic_head_logo.svg'.toAssetsSvg(),
            width: width ?? 46.r,
            colorFilter: ColorFilter.mode(Theme.of(context).highlightColor, BlendMode.srcIn),
          ),
          XBox.vertical20,
          Text(
            message ?? '',
            style: TextStyle(
              color: Theme.of(context).highlightColor,
            ),
          )
        ],
      ),
    );
  }
}

