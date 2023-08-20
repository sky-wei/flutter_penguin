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
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MessageUtil {

  MessageUtil._();

  static void showMessage(BuildContext context, String msg) {
    // final margin = PlatformUtil.isMobile() ? null : REdgeInsets.fromLTRB(300, 10, 300, 10);
    // final padding = PlatformUtil.isMobile() ? REdgeInsets.only(left: 15, top: 5, bottom: 5) : EdgeInsets.all(20.r);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     backgroundColor: Theme.of(context).xColor.surface,
    //     content: AppText(
    //       msg,
    //       fontSize: 16.sp,
    //       color: Theme.of(context).mainTextColor,
    //     ),
    //     behavior: SnackBarBehavior.floating,
    //     margin: margin,
    //     padding: padding,
    //     action: SnackBarAction(
    //       label: S.of(context).close,
    //       onPressed: () { },
    //     ),
    //   )
    // );

    EasyLoading.showToast(
      msg,
      toastPosition: EasyLoadingToastPosition.center,
    );

    // FlutterToastr.show(msg, context);
  }

  static void showMessage2(String msg) {
    EasyLoading.showToast(
      msg,
      toastPosition: EasyLoadingToastPosition.center,
    );
  }
}

