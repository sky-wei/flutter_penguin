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
import 'package:flutter_penguin/util/platform_util.dart';

class BigButtonWidget extends StatelessWidget {

  final VoidCallback? onPressed;
  final String text;
  final TextStyle? textStyle;
  final Size? size;
  final Radius? radius;

  const BigButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.size,
    this.radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = this.size ?? (PlatformUtil.isMobile() ? Size(double.infinity, 46.h) : Size(double.infinity, 55.h));
    final textStyle = this.textStyle ?? TextStyle(
      // fontFamily: 'hwxw',
      fontSize: 16.sp,
      fontWeight: FontWeight.normal
    );
    final radius = this.radius ?? Radius.circular(6.r);

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(size),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(radius)
          )
        ),
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
