
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
import 'package:flutter_penguin/theme/theme.dart';
import 'package:flutter_penguin/util/border_util.dart';

class DesktopDialogFrame extends StatelessWidget {

  final double? width;
  final Widget? child;

  const DesktopDialogFrame({
    Key? key,
    this.width,
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: XBorder.borderRadius6
      ),
      child: SizedBox(
        width: width ?? 400.w,
        child: child
      ),
    );
  }
}


class MobileDialogFrame extends StatelessWidget {

  final Widget? child;

  const MobileDialogFrame({
    Key? key,
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 150),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).xColor.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          )
        ),
        child: child
      )
    );
  }
}


Future<T?> showAppDialog<T>({
  required BuildContext context,
  double? width,
  required WidgetBuilder builder,
}) {
  return showDialog<T>(
    context: context,
    builder: (context) {
      return DesktopDialogFrame(
        width: width,
        child: builder(context),
      );
    }
  );
}


Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: XColor.transparent,
    builder: (context) {
      return MobileDialogFrame(
        child: builder(context),
      );
    }
  );
}

