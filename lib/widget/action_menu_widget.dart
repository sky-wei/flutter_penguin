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
import 'package:flutter_svg/svg.dart';

import 'app_icon_button.dart';

class ActionMenuWidget extends StatelessWidget {

  final EdgeInsetsGeometry? padding;
  final double? splashRadius;
  final String iconName;
  final Color? iconColor;
  final double? iconSize;
  final String? tooltip;
  final VoidCallback? onPressed;

  const ActionMenuWidget({
    Key? key,
    this.padding,
    this.splashRadius,
    required this.iconName,
    this.iconColor,
    this.iconSize,
    this.tooltip,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      padding: padding ?? EdgeInsets.zero,
      splashRadius: splashRadius ?? 30.r,
      onPressed: onPressed,
      icon: SvgPicture.asset(
        'assets/svg/$iconName',
        width: iconSize ?? 22.r,
        color: iconColor ?? Theme.of(context).iconColor,
      ),
      tooltip: tooltip
    );
  }
}

