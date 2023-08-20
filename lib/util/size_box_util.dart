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

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class XBox {

  static SizedBox get vertical5 => _xBox!._vertical5;
  static SizedBox get vertical8 => _xBox!._vertical8;
  static SizedBox get vertical10 => _xBox!._vertical10;
  static SizedBox get vertical15 => _xBox!._vertical15;
  static SizedBox get vertical20 => _xBox!._vertical20;
  static SizedBox get vertical30 => _xBox!._vertical30;
  static SizedBox get vertical36 => _xBox!._vertical36;
  static SizedBox get vertical40 => _xBox!._vertical40;
  static SizedBox get vertical50 => _xBox!._vertical50;
  static SizedBox get vertical60 => _xBox!._vertical60;
  static SizedBox get vertical70 => _xBox!._vertical70;
  static SizedBox get vertical80 => _xBox!._vertical80;

  static SizedBox get horizontal5 => _xBox!._horizontal5;
  static SizedBox get horizontal8 => _xBox!._horizontal8;
  static SizedBox get horizontal10 => _xBox!._horizontal10;
  static SizedBox get horizontal15 => _xBox!._horizontal15;
  static SizedBox get horizontal20 => _xBox!._horizontal20;
  static SizedBox get horizontal30 => _xBox!._horizontal30;
  static SizedBox get horizontal40 => _xBox!._horizontal40;
  static SizedBox get horizontal60 => _xBox!._horizontal60;
  static SizedBox get horizontal80 => _xBox!._horizontal80;

  final SizedBox _vertical5 = _vertical(5.r);
  final SizedBox _vertical8 = _vertical(8.r);
  final SizedBox _vertical10 = _vertical(10.r);
  final SizedBox _vertical15 = _vertical(15.r);
  final SizedBox _vertical20 = _vertical(20.r);
  final SizedBox _vertical30 = _vertical(30.r);
  final SizedBox _vertical36 = _vertical(36.r);
  final SizedBox _vertical40 = _vertical(40.r);
  final SizedBox _vertical50 = _vertical(50.r);
  final SizedBox _vertical60 = _vertical(60.r);
  final SizedBox _vertical70 = _vertical(70.r);
  final SizedBox _vertical80 = _vertical(80.r);

  final SizedBox _horizontal5 = _horizontal(5.r);
  final SizedBox _horizontal8 = _horizontal(8.r);
  final SizedBox _horizontal10 = _horizontal(10.r);
  final SizedBox _horizontal15 = _horizontal(15.r);
  final SizedBox _horizontal20 = _horizontal(20.r);
  final SizedBox _horizontal30 = _horizontal(30.r);
  final SizedBox _horizontal40 = _horizontal(40.r);
  final SizedBox _horizontal60 = _horizontal(60.r);
  final SizedBox _horizontal80 = _horizontal(80.r);

  static XBox? _xBox;

  static void initialize() {
    _xBox = XBox();
  }

  static SizedBox _vertical(double value) {
    return SizedBox(width: 0, height: value);
  }

  static SizedBox _horizontal(double value) {
    return SizedBox(width: value, height: 0);
  }
}
