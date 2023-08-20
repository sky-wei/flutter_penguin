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

class XColor {

  final Color bottom;
  final Color background;
  final Color surface;

  final Color mainText;

  final Color icon;
  final Color secondaryIcon;

  final Color hint;
  final Color divider;

  XColor({
    required this.bottom,
    required this.background,
    required this.surface,
    required this.mainText,
    required this.icon,
    required this.secondaryIcon,
    required this.hint,
    required this.divider
  });


  static const Color white = Color(0xFFFFFFFF);

  static const Color transparent = Color(0x00000000);

  static const Color black = Color(0xFF000000);

  static const Color hintColor = Color(0xFF959595);

  static const Color backgroundColor = Color(0xFFF7F7F7);

  static const Color sideColor = Color(0xFF222530);

  static const Color sideTextColor = Color(0xFFC9CFD7);

  static const Color sideChooseColor = Color(0xFF414B5E);

  static const Color listChooseColor = Color(0xFFE7ECF3);

  static const Color listColor = Color(0xFFF5F8FB);

  static const Color deleteColor = Color(0xFFF63061);

  static const Color logoTextColor = Color(0xFFC1CAD7);

  static const Color favoriteColor = Color(0xFFFFB806);

  static const Color themeColor = Color(_redPrimaryValue);

  static XColor light = XColor(
    bottom: const Color(0xFFE5E5E5),
    background: const Color(0xFFF6F6F6),
    surface: white,
    mainText: const Color(0xFF212121),
    icon: const Color(0xFF707070),
    secondaryIcon: const Color(0xFF707070),
    hint: const Color(0xFF909090),
    divider: const Color(0xFFE9E9E9),
  );

  static XColor dark = XColor(
    bottom: const Color(0xFF161616),
    background: const Color(0xFF262626),
    surface: const Color(0xFF363636),
    mainText: const Color(0xFFF0F0F0),
    icon: const Color(0xFFE0E0E0),
    secondaryIcon: const Color(0xFFE0E0E0),
    hint: const Color(0xFFB5B5B5),
    divider: const Color(0xFF505050),
  );


  static const MaterialColor blue = MaterialColor(
    _redPrimaryValue,
    <int, Color>{
      50: Color(0xFFebf5fb),
      100: Color(0xFFd6eaf8),
      200: Color(0xFFaed6f1),
      300: Color(0xFF85c1e9),
      400: Color(0xFF5cade2),
      500: Color(_redPrimaryValue),
      600: Color(0xFF2f86c1),
      700: Color(0xFF2874a6),
      800: Color(0xFF21618c),
      900: Color(0xFF1c4f72),
    },
  );

  static const int _redPrimaryValue = 0xFF3398da;
}
