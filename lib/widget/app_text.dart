
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

class AppText extends StatelessWidget {

  final String data;
  final TextStyle? style;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool selectableText;

  const AppText(
    this.data, {
    Key? key,
    this.style,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.decoration,
    this.decorationStyle,
    this.overflow,
    this.textAlign,
    this.selectableText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selectableText ? _buildSelectableText() : _buildText();
  }

  Widget _buildSelectableText() {
    return SelectableText(
      data,
      textAlign: textAlign,
      style: style ?? TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationStyle: decorationStyle,
        overflow: overflow,
      ),
      maxLines: maxLines,
    );
  }

  Widget _buildText() {
    return Text(
      data,
      textAlign: textAlign,
      style: style ?? TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationStyle: decorationStyle,
        overflow: overflow,
      ),
      maxLines: maxLines,
    );
  }
}
