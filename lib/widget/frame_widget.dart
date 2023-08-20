
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
import 'package:flutter_penguin/theme/color.dart';

class ChooseFrameWidget extends StatelessWidget {

  final bool choose;
  final Widget child;
  final Color? chooseColor;
  final GestureTapCallback? onTap;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const ChooseFrameWidget({
    Key? key,
    this.choose = false,
    required this.child,
    this.chooseColor,
    this.onTap,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = chooseColor ?? Theme.of(context).highlightColor.withOpacity(0.3);
    return Material(
      color: XColor.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: choose ? color : null,
          borderRadius: borderRadius,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: padding ?? REdgeInsets.all(15),
            child: child
          ),
        ),
      ),
    );
  }
}
