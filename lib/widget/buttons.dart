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

import 'app_text.dart';

enum ButtonType {
  elevated, outlined, text, icon
}

class ToolboxButton extends StatelessWidget {

  final ButtonType type;
  final String? text;
  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;
  final double? textSize;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final VoidCallback? onPressed;

  const ToolboxButton({
    Key? key,
    this.type = ButtonType.elevated,
    this.text,
    this.icon,
    this.color,
    this.backgroundColor,
    this.textSize,
    this.fontSize,
    this.padding,
    this.minimumSize,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final style = ButtonStyle(
      padding: MaterialStateProperty.all(
        padding ?? REdgeInsets.symmetric(vertical: 15, horizontal: 15)
      ),
      minimumSize: MaterialStateProperty.all(
        minimumSize ?? Size(50.w, 20.h)
      ),
      backgroundColor: MaterialStateProperty.all(
        backgroundColor ?? Theme.of(context).themeColor
      )
    );

    final Widget child;

    switch(type) {
      case ButtonType.icon:
        child = IconButton(
            style: style,
            onPressed: onPressed,
            icon: Icon(
              icon,
              size: 16.r,
            )
        );
        break;
      case ButtonType.elevated:
        child = ElevatedButton(
            style: style,
            onPressed: onPressed,
            child: _buildAppText(text!)
        );
        break;
      case ButtonType.outlined:
        child = OutlinedButton(
            // style: style,
            onPressed: onPressed,
            child: _buildAppText(text!)
        );
        break;
      case ButtonType.text:
        child = TextButton(
            style: style,
            onPressed: onPressed,
            child: _buildAppText(text!)
        );
        break;
    }
    return child;
  }

  /// 创建文字控件
  Widget _buildAppText(String text) {
    return AppText(
      text,
      fontSize: textSize ?? 14.sp,
      color: color
    );
  }
}

class AppOutlinedButton extends StatelessWidget {

  final String text;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final Color? color;
  final Size? minimumSize;
  final VoidCallback? onPressed;

  const AppOutlinedButton({
    Key? key,
    required this.text,
    this.padding,
    this.fontSize,
    this.color,
    this.minimumSize,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          padding ?? REdgeInsets.symmetric(vertical: 14, horizontal: 8)
        ),
        minimumSize: MaterialStateProperty.all(
          minimumSize ?? Size(50.w, 20.h)
        )
      ),
      onPressed: onPressed,
      child: AppText(
        text,
        fontSize: fontSize ?? 14.sp,
        color: color ?? Theme.of(context).mainTextColor,
      )
    );
  }
}
