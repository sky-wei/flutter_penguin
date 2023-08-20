
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
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color.dart';

class LoadingUtil {

  static void initialize(BuildContext context) {
    EasyLoading.instance.indicatorSize = 40.0.r;
    EasyLoading.instance.radius = 6.r;
    EasyLoading.instance.fontSize = 15.sp;
    EasyLoading.instance.progressWidth = 2.r;
    EasyLoading.instance.lineWidth = 4.r;
    EasyLoading.instance.contentPadding = REdgeInsets.symmetric(
      vertical: 15.0,
      horizontal: 20.0,
    );
  }
}