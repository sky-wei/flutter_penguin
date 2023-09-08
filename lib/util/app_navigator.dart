
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
import 'package:flutter_sky_library/route/mobile_page_route.dart';
import 'package:flutter_sky_library/theme/theme.dart';
import 'package:flutter_sky_library/util/platform_util.dart';
import 'package:flutter_sky_library/widget/right_sheet.dart';

class AppNavigator {

  static Future<T?> push<T extends Object?>(BuildContext context, Widget child) {
    return Navigator.push<T?>(context, MobilePageRoute<T?>(child: child));
  }

  static Future<T?> start<T extends Object?>({
    required BuildContext context,
    BoxConstraints? constraints,
    Color? backgroundColor,
    bool isScrollControlled = false,
    required Widget child
  }) {

    if (PlatformUtil.isTabletMode()) {
      return showModalRightSheet<T?>(
          context: context,
          backgroundColor: backgroundColor ?? Theme.of(context).xColor.surface,
          constraints: constraints ?? BoxConstraints(maxWidth: 430.w),
          isScrollControlled: isScrollControlled,
          builder: (context) => child
      );
    }
    return AppNavigator.push(context, child);
  }
}