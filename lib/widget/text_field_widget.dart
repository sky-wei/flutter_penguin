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
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_penguin/theme/color.dart';
import 'package:flutter_penguin/theme/theme.dart';
import 'package:flutter_penguin/util/border_util.dart';
import 'package:flutter_penguin/util/platform_util.dart';
import 'package:flutter_svg/svg.dart';

import 'app_icon_button.dart';

class TextFieldWidget extends StatefulWidget {

  final String? iconName;
  final String? initText;
  final String? hintText;
  final int? maxLength;
  final Color? fillColor;
  final bool autofocus;
  final double? width;
  final double? height;
  final double? fontSize;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const TextFieldWidget({
    Key? key,
    this.iconName,
    this.initText,
    this.hintText,
    this.maxLength,
    this.fillColor,
    this.autofocus = false,
    this.width,
    this.height,
    this.fontSize,
    this.focusNode,
    this.onChanged,
    this.onSubmitted
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {

  bool _enableActionView = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initText);
    _controller.addListener(_refreshViewState);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller.removeListener(_refreshViewState);
  }

  @override
  Widget build(BuildContext context) {

    final iconPadding = PlatformUtil.isMobile()
        ? REdgeInsets.fromLTRB(14, 0, 14, 0)
        : REdgeInsets.fromLTRB(10, 0, 10, 0);

    return SizedBox(
      width: widget.width,
      height: widget.height ?? (PlatformUtil.isTabletMode() ? 48.r : 48.r),
      child: TextField(
        controller: _controller,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        style: TextStyle(
            fontSize: widget.fontSize ?? 16.sp
        ),
        inputFormatters: widget.maxLength != null ? <TextInputFormatter>[
          LengthLimitingTextInputFormatter(widget.maxLength)
        ] : null,
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(),
          prefixIcon: widget.iconName != null ? Padding(
            padding: iconPadding,
            child: SvgPicture.asset(
              'assets/svg/${widget.iconName}',
              color: Theme.of(context).iconTheme.color,
              width: 20.r,
            ),
          ) : null,
          suffixIcon: _enableActionView ? Material(
            color: XColor.transparent,
            child: AppIconButton(
              splashRadius: 20.r,
              padding: iconPadding,
              onPressed: _clear,
              icon: SvgPicture.asset(
                'assets/svg/ic_close.svg',
                color: Theme.of(context).iconTheme.color,
                width: 22.r,
              ),
              tooltip: '清除内容',
            ),
          ) : null,
          hintStyle: TextStyle(
              fontSize: widget.fontSize ?? 16.sp
          ),
          hintText: widget.hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: XBorder.borderRadius6
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: XBorder.borderRadius6
          ),
          hoverColor: XColor.transparent,
          filled: true,
          fillColor: widget.fillColor ?? Theme.of(context).xColor.surface,
        ),
        maxLines: 1,
        textInputAction: TextInputAction.done,
        textAlignVertical: TextAlignVertical.bottom,
        keyboardType: TextInputType.text,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
      ),
    );
  }

  /// 刷新状态
  void _refreshViewState() {
    _setViewState(_controller.text.isNotEmpty);
  }

  /// 设置状态
  void _setViewState(bool enable) {
    if (_enableActionView != enable) {
      setState(() { _enableActionView = enable; });
    }
  }

  /// 清除文字
  void _clear() {
    if (widget.onChanged != null) {
      widget.onChanged!('');
    }
    _controller.clear();
  }
}
