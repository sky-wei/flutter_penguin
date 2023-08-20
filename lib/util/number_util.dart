
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

import 'package:intl/intl.dart';

class NumberUtil {

  static final NumberFormat _numberFormat = NumberFormat("##0.00");

  /// 格式化价格
  static String formatPrice(int value) {
    return _numberFormat.format(value / 100);
  }

  /// 格式化价格
  static String format(number) {
    return _numberFormat.format(number);
  }
}