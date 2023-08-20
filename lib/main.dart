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

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_penguin/constant.dart';
import 'package:flutter_penguin/core/context.dart';
import 'package:flutter_penguin/doc_app.dart';
import 'package:flutter_penguin/util/logger.dart';
import 'package:flutter_penguin/util/platform_util.dart';
import 'package:flutter_penguin/widget/restart_widget.dart';

void main() {
  initLogger(() async {
    final baseContext = BaseContext();
    await baseContext.initialize();
    runApp(
        RestartWidget(
            child: DocApp(baseContext: baseContext)
        )
    );
  });
  if (PlatformUtil.isPC()) {
    doWhenWindowReady(() {
      final win = appWindow;
      win.minSize = const Size(1100, 800);
      win.size = const Size(XConstant.defaultWidget, XConstant.defaultHeight);
      win.alignment = Alignment.center;
      win.title = 'LinuxDoc';
      win.show();
    });
  }
}
