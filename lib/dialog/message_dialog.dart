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
import 'package:flutter_penguin/generated/l10n.dart';
import 'package:flutter_penguin/util/platform_util.dart';
import 'package:flutter_penguin/util/size_box_util.dart';

import 'app_dialog.dart';
import 'wdiget/dialog_divider.dart';
import 'wdiget/dialog_text_button.dart';
import 'wdiget/dialog_title.dart';
import 'wdiget/dialog_vertical_divider.dart';


class MessageDialog extends StatefulWidget {

  final String title;
  final String message;
  final String? positive;
  final String? negative;

  const MessageDialog({
    Key? key,
    required this.title,
    required this.message,
    this.positive,
    this.negative
  }) : super(key: key);

  @override
  State<MessageDialog> createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {

  @override
  Widget build(BuildContext context) {
    return PlatformUtil.isTabletMode()
        ? _buildDesktopWidget()
        : _buildMobileWidget();
  }

  Widget _buildDesktopWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        XBox.vertical30,
        DialogTitle(title: widget.title),
        XBox.vertical10,
        _buildMessageWidget(),
        XBox.vertical5,
        const DialogDivider(),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(child: _buildNegativeWidget()),
            const DialogVerticalDivider(),
            Expanded(child: _buildPositiveWidget())
          ],
        ),
      ],
    );
  }

  Widget _buildMobileWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        XBox.vertical30,
        DialogTitle(title: widget.title),
        XBox.vertical10,
        _buildMessageWidget(),
        Row(
          children: [
            Expanded(child: _buildPositiveWidget()),
          ],
        ),
        const DialogDivider(),
        Row(
          children: [
            Expanded(child: _buildNegativeWidget()),
          ],
        ),
        XBox.vertical10,
      ],
    );
  }

  Widget _buildMessageWidget() {
    return Padding(
      padding: REdgeInsets.fromLTRB(20, 20, 20, 30),
      child: Text(
        widget.message,
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
    );
  }
  
  Widget _buildPositiveWidget() {
   return DialogTextButton(
     text: widget.positive ?? S.of(context).ok,
     onPressed: _ok
   ); 
  }
  
  Widget _buildNegativeWidget() {
    return DialogTextButton(
      text: widget.negative ?? S.of(context).cancel,
      textColor: Theme.of(context).hintColor,
      onPressed: _cancel
    );
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _ok() {
    Navigator.pop(context, 1);
  }
}


Future<int?> showMessageDialog({
  required BuildContext context,
  required String title,
  required String message,
  String? positive,
  String? negative,
}) {

  final dialog = MessageDialog(
    title: title,
    message: message,
    positive: positive,
    negative: negative,
  );

  if (PlatformUtil.isTabletMode()) {
    return showAppDialog<int>(
      context: context,
      builder: (context) {
        return dialog;
      }
    );
  }

  return showAppModalBottomSheet<int>(
    context: context,
    builder: (context) {
      return dialog;
    }
  );
}

