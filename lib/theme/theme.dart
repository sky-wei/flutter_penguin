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
import 'package:flutter_penguin/util/border_util.dart';
import 'package:flutter_penguin/util/platform_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color.dart';


class XTheme {

  static const int system = 0;
  static const int light = 1;
  static const int dark = 2;

  XTheme._();

  static ThemeData lightTheme(BuildContext context) {
    final isTabletMode = PlatformUtil.isTabletMode();
    return ThemeData(
      fontFamily: 'MiSans',
      primarySwatch: XColor.blue,
      backgroundColor: XColor.light.background,
      iconTheme: IconThemeData(color: XColor.light.icon),
      primaryIconTheme: IconThemeData(color: XColor.light.icon),
      hintColor: XColor.light.hint,
      dividerColor: XColor.light.divider,
      dividerTheme: DividerThemeData(color: XColor.light.divider),
      cardColor: XColor.light.surface,
      dialogBackgroundColor: XColor.light.surface,
      scaffoldBackgroundColor: XColor.light.background,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: XBorder.borderRadius6
            )
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: isTabletMode ? 10.r : 5.r, horizontal: 10.r)
          ),
          minimumSize: MaterialStateProperty.all(const Size(0, 0)),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: XColor.light.mainText,
              fontFamily: 'MiSans',
            )
          ),
          overlayColor: MaterialStateProperty.all(const Color(0x88C5C5C5)),
        )
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 16.sp,
          color: XColor.light.mainText,
          fontFamily: 'MiSans',
        ),
        bodyText2: TextStyle(
          fontSize: 16.sp,
          color: XColor.light.mainText,
          fontFamily: 'MiSans',
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: XColor.light.background,
        toolbarHeight: kToolbarHeight.h,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: XBorder.borderRadius6
            )
          ),
          elevation: MaterialStateProperty.all(0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'MiSans',
            )
          )
        )
      )
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    final isTabletMode = PlatformUtil.isTabletMode();
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'MiSans',
      primarySwatch: XColor.blue,
      backgroundColor: XColor.dark.background,
      iconTheme: IconThemeData(color: XColor.dark.icon),
      primaryIconTheme: IconThemeData(color: XColor.dark.icon),
      hintColor: XColor.dark.hint,
      dividerColor: XColor.dark.divider,
      dividerTheme: DividerThemeData(color: XColor.dark.divider),
      cardColor: XColor.dark.surface,
      dialogBackgroundColor: XColor.dark.surface,
      scaffoldBackgroundColor: XColor.dark.background,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: XBorder.borderRadius6
            )
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: isTabletMode ? 10.r : 5.r, horizontal: 10.r)
          ),
          minimumSize: MaterialStateProperty.all(const Size(0, 0)),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              fontFamily: 'MiSans',
            )
          ),
          overlayColor: MaterialStateProperty.all(const Color(0x88606060)),
        )
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 16.sp,
          color: XColor.dark.mainText,
          fontFamily: 'MiSans',
        ),
        bodyText2: TextStyle(
          fontSize: 16.sp,
          color: XColor.dark.mainText,
          fontFamily: 'MiSans',
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: XColor.dark.background,
        toolbarHeight: kToolbarHeight.h,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: XBorder.borderRadius6
            )
          ),
          elevation: MaterialStateProperty.all(0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'MiSans',
            )
          )
        )
      ),
    );
  }
}

extension XThemeData on ThemeData {

  Color get themeColor => XColor.themeColor;

  Color get deleteColor => XColor.deleteColor;

  Color get favoriteColor => XColor.favoriteColor;

  Color get listChooseColor => isLight ? XColor.listChooseColor : const Color(0xFF505050);

  Color get mainTextColor => isLight ? XColor.light.mainText : XColor.dark.mainText;

  XColor get xColor => isLight ? XColor.light : XColor.dark;

  bool get isLight => brightness == Brightness.light;

  bool get isDark => brightness == Brightness.dark;
}
