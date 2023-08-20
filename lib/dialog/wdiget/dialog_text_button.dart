
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
import 'package:flutter_penguin/widget/app_text.dart';

class DialogTextButton extends StatelessWidget {

  final String text;
  final double? height;
  final Color? textColor;
  final VoidCallback? onPressed;

  const DialogTextButton({
    Key? key,
    required this.text,
    this.height,
    this.textColor,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double xHeight = height ?? (PlatformUtil.isMobile() ? 16.r : 26.r);
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.fromLTRB(20.r, xHeight, 20.r, xHeight)
        ),
        // minimumSize: MaterialStateProperty.all(Size.fromHeight(55.h)),
        overlayColor: MaterialStateProperty.all(
          Theme.of(context).highlightColor.withOpacity(0.2)
        ),
      ),
      child: AppText(
        text,
        fontWeight: FontWeight.normal,
        color: textColor
      ),
    );
  }
}
