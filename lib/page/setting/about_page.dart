
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_penguin/constant.dart';
import 'package:flutter_penguin/generated/l10n.dart';
import 'package:flutter_penguin/util/launch_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sky_library/theme/theme.dart';
import 'package:flutter_sky_library/util/app_extension.dart';
import 'package:flutter_sky_library/util/platform_util.dart';
import 'package:flutter_sky_library/util/size_box_util.dart';
import 'package:flutter_sky_library/widget/color_box_widget.dart';
import 'package:flutter_sky_library/widget/sub_scaffold.dart';
import 'package:flutter_svg/svg.dart';

class AboutPage extends StatefulWidget {

  final bool inline;

  const AboutPage({
    Key? key,
    this.inline = false
  }) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = _handlePress;
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SubScaffold(
      inline: widget.inline,
      title: S.of(context).about,
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {

    final child = PlatformUtil.isTabletMode()
        ? _buildDesktopBody() : _buildMobileBody();

    return Padding(
      padding: REdgeInsets.all(15),
      child: child,
    );
  }

  Widget _buildDesktopBody() {
    return ColorBoxWidget(
      child: Center(
        child: _buildAboutWidget(),
      ),
    );
  }

  Widget _buildMobileBody() {
    return _buildAboutWidget();
  }

  Widget _buildAboutWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          XBox.vertical30,
          SvgPicture.asset(
            'ic_head_logo.svg'.toAssetsSvg(),
            width: 50.r,
            color: Theme.of(context).themeColor,
          ),
          XBox.vertical20,
          Text(
            S.of(context).appName,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold
            ),
          ),
          XBox.vertical5,
          Text(
            S.of(context).versionX(XConstant.versionName),
            style: TextStyle(
              fontSize: 12.sp,
            ),
          ),
          XBox.vertical40,
          SelectableText(S.of(context).mailX(XConstant.mail)),
          XBox.vertical10,
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: S.of(context).sourceX('')),
                TextSpan(
                  text: XConstant.source,
                  style: TextStyle(
                    color: Theme.of(context).themeColor
                  ),
                  recognizer: _tapGestureRecognizer
                )
              ]
            )
          ),
          XBox.vertical60,
          Material(
            color: PlatformUtil.isTabletMode()
                ? Theme.of(context).xColor.background
                : Theme.of(context).xColor.surface,
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SelectableText(S.of(context).license),
            ),
          ),
        ],
      ),
    );
  }

  /// 处理点击事件
  void _handlePress() {
    LaunchUtil.launch(XConstant.source);
  }
}
