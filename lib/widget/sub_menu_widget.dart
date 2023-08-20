

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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_penguin/theme/color.dart';
import 'package:flutter_penguin/theme/theme.dart';
import 'package:flutter_penguin/util/size_box_util.dart';
import 'package:flutter_svg/svg.dart';

enum BorderType {
  top,
  center,
  bottom,
  topBottom,
}

class SubMenuWidget extends StatelessWidget {

  final String? iconName;
  final String title;
  final String? desc;
  final String? value;
  final String? moreIconName;
  final EdgeInsetsGeometry? padding;
  final GestureTapCallback? onTap;
  final bool choose;
  final BorderType borderType;
  final Color? iconColor;
  final Color? moreIconColor;
  final bool? switchValue;
  final ValueChanged<bool>? onChanged;

  const SubMenuWidget({
    Key? key,
    this.iconName,
    required this.title,
    this.desc,
    this.value,
    this.moreIconName,
    this.padding,
    this.onTap,
    this.choose = false,
    this.borderType = BorderType.topBottom,
    this.iconColor,
    this.moreIconColor,
    this.switchValue,
    this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final borderRadius = BorderType.top == borderType
        ? BorderRadius.vertical(top: Radius.circular(6.r))
        : BorderType.bottom == borderType
        ? BorderRadius.vertical(bottom: Radius.circular(6.r))
        : BorderType.center == borderType
        ? const BorderRadius.all(Radius.zero)
        : BorderRadius.all(Radius.circular(6.r));

    return Material(
      color: choose ? Theme.of(context).themeColor : Theme.of(context).xColor.surface,
      borderRadius: borderRadius,
      child: Ink(
        width: double.infinity,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: padding ?? REdgeInsets.all(15),
            child: Row(
              children: [
                if (iconName != null)
                  SvgPicture.asset(
                    'assets/svg/$iconName',
                    width: 22.r,
                    color: choose ? XColor.white : iconColor ?? Theme.of(context).iconColor,
                  ),
                if (iconName != null)
                  XBox.horizontal15,
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: choose ? XColor.white : Theme.of(context).mainTextColor
                        ),
                        maxLines: 1,
                      ),
                      if (desc != null)
                        Text(
                          desc!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: choose ? Theme.of(context).listChooseColor : Theme.of(context).hintColor
                          ),
                          maxLines: 1,
                        ),
                    ],
                  ),
                ),
                if (value != null)
                  Text(
                    value!,
                    style: TextStyle(
                      color: choose ? Theme.of(context).listChooseColor : Theme.of(context).hintColor,
                      fontSize: 16.sp,
                    ),
                    maxLines: 1,
                  ),
                if (value != null)
                  XBox.horizontal5,
                if (moreIconName != null)
                  SvgPicture.asset(
                    'assets/svg/$moreIconName',
                    width: 22.r,
                    color: choose ? XColor.white : moreIconColor ?? Theme.of(context).iconTheme.color,
                  ),
                if (switchValue != null)
                  SizedBox(
                    height: 22.r,
                    child: CupertinoSwitch(
                      value: switchValue!,
                      onChanged: onChanged
                    ),
                  ),
              ],
            ),
          )
        ),
      ),
    );
  }
}