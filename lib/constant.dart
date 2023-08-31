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

typedef ChooseItem<T> = bool Function(T value);

typedef IsLoginCallback = bool Function();

typedef PasswordCallback = Future<String?> Function();

typedef CompleteCallback = void Function();

typedef InterceptCallback<T> = bool Function(T value);

typedef ResultCallback<T> = void Function(T value);

enum ListType {
  all,
  favorite
}

class XConstant {

  static const String projectName = 'flutter_penguin';

  static const String versionName = '0.0.1';

  static const String mail = 'jingcai.wei@163.com';

  static const String source = 'https://github.com/sky-wei/flutter_penguin';

  /// 默认平板模式(关闭)
  static const bool defaultTabletMode = false;

  static const double defaultWidget = 1400;

  static const double defaultHeight = 950;
}

class XLinuxDoc {

  static const int version = 1;   // 数据版本
}
