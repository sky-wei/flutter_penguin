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

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_penguin/generated/l10n.dart';
import 'package:flutter_penguin/util/error_util.dart';
import 'package:flutter_penguin/util/export_util.dart';
import 'package:flutter_penguin/util/message_util.dart';
import 'package:flutter_penguin/util/time_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sky_library/flutter_sky_library.dart';
import 'package:path_provider/path_provider.dart';

class FeedbackPage extends StatefulWidget {

  final bool inline;

  const FeedbackPage({
    super.key,
    this.inline = false
  });

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

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
    return SubScaffold(
      inline: widget.inline,
      title: S.current.feedback,
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return PlatformUtil.isTabletMode()
        ? _buildDesktopBody() : _buildMobileBody();
  }

  Widget _buildDesktopBody() {
    return Center(
      child: _buildFeedbackWidget(),
    );
  }

  Widget _buildMobileBody() {
    return Center(
      child: _buildFeedbackWidget(),
    );
  }

  Widget _buildFeedbackWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        XBox.vertical70,
        _buildQrCodeWidget(),
        Spacer(flex: 1),
        _buildSaveWidget(onPressed: () => _saveImage()),
        Spacer(flex: 2),
      ],
    );
  }

  Widget _buildQrCodeWidget() {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).xColor.surface,
        borderRadius: XBorder.borderRadius6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          XBox.vertical5,
          _buildSearchWidget(),
          XBox.vertical10,
          Image.asset(
            'qrcode_for_gh.jpg'.toAssetsImage(),
            width: 210,
            height: 210,
          ),
          XBox.vertical10,
          Text(
            S.current.scanQrcodeFeedbackTips,
            style: TextStyle(
              fontSize: 13.sp,
              color: Theme.of(context).highlightColor.withAlpha(150)
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).themeColor,
        borderRadius: XBorder.borderRadius6,
      ),
      padding: REdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          XBox.horizontal5,
          Text(
            '微信搜一搜',
            style: TextStyle(
              fontSize: 13.sp,
              color: XColor.white
            ),
          ),
          XBox.horizontal5,
          Container(
            padding: REdgeInsets.symmetric(vertical: 2, horizontal: 15),
            decoration: BoxDecoration(
              color: XColor.white,
              borderRadius: XBorder.borderRadius6
            ),
            child: Text(
              '星空下的风',
              style: TextStyle(
                fontSize: 15.sp,
                color: XColor.black
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 保存控件
  Widget _buildSaveWidget({
    VoidCallback? onPressed
  }) {
    return TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: REdgeInsets.fromLTRB(8, 6, 8, 6),
          child: Text(
            S.current.saveImage,
            style: TextStyle(
              fontSize: 15.sp,
              color: Theme.of(context).themeColor
            ),
          ),
        )
    );
  }

  /// 保存图片
  void _saveImage() {
    _saveImageToPath().then((value) {
      if (value != null) {
        MessageUtil.showMessage(S.current.saveTo(value));
      }
    }).onError((error, stackTrace) {
      MessageUtil.showMessage(ErrorUtil.getMessage(error));
    });
  }

  /// 保存图片
  Future<String?> _saveImageToPath() async {

    final byteData = await rootBundle.load('qrcode_for_gh.jpg'.toAssetsImage());

    if (PlatformUtil.isMobile()) {
      final saveName = '${TimeUtil.getCurTime()}.jpg';
      return await ExportUtil.saverGallery(byteData, saveName);
    }

    final directory = await getApplicationDocumentsDirectory();
    final savePath = await getSaveLocation(
      acceptedTypeGroups: [XTypeGroup(label: 'jpg', extensions: ['jpg'])],
      initialDirectory: directory.path,
      suggestedName: 'feedback_qr_image.jpg',
      confirmButtonText: S.current.ok
    );

    if (savePath == null) {
      return null;
    }
    return ExportUtil.saveByteData(savePath.path, byteData);
  }
}
