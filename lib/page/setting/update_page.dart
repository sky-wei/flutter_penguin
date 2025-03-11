
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
import 'package:flutter_penguin/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sky_library/flutter_sky_library.dart';
import 'package:flutter_svg/svg.dart';

class UpdatePage extends StatefulWidget {

  final bool inline;

  const UpdatePage({
    super.key,
    this.inline = false
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  @override
  Widget build(BuildContext context) {
    return SubScaffold(
      inline: widget.inline,
      title: S.of(context).update,
      backgroundColor: !PlatformUtil.isTabletMode() ? Theme.of(context).xColor.surface : null,
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Padding(
      padding: REdgeInsets.all(15),
      child: ColorBoxWidget(
        child: Center(
          child: _buildVersionWidget(),
        ),
      ),
    );
  }

  Widget _buildVersionWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'ic_head_logo.svg'.toAssetsSvg(),
          width: 50.r,
          color: Theme.of(context).themeColor,
        ),
        XBox.vertical20,
        Text(
          '当前已是最新版本',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500
          ),
        ),
        XBox.vertical10,
        Text(
          'v${XConstant.versionName}',
          style: TextStyle(
            color: Theme.of(context).hintColor,
            fontSize: 14.sp
          ),
        )
      ],
    );
  }
}
