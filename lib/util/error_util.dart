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
import 'package:flutter_penguin/data/data_exception.dart';
import 'package:flutter_penguin/data/net_exception.dart';
import 'package:flutter_sky_library/util/log_util.dart';

class ErrorUtil {

  ErrorUtil._();

  static String getMessage(Object? error) {

    XLog.d('>>>>>>>>>>>>>>>> $error');

    if (error is DataException) {
      switch(error.type) {
        case ErrorType.nameOrPasswordError:
          return '用户名密码错误';
        case ErrorType.passwordError:
          return '密码错误';
        default :
          return error.message;
      }
    } else if (error is NetException) {
      return error.message;
    }
    return '处理异常: $error';
  }
}
