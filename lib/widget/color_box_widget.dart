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
import 'package:flutter_penguin/util/border_util.dart';

class ColorBoxWidget extends StatelessWidget {

  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const ColorBoxWidget({
    Key? key,
    this.color,
    this.borderRadius,
    this.border,
    this.padding,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Theme.of(context).xColor.surface,
      borderRadius: borderRadius ?? XBorder.borderRadius6,
      child: Padding(
          padding: padding ?? REdgeInsets.all(15),
          child: child
      ),
    );
  }
}

