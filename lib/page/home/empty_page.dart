
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
import 'package:flutter_penguin/widget/app_text.dart';
import 'package:flutter_penguin/widget/color_box_widget.dart';
import 'package:flutter_penguin/widget/expand_box_widget.dart';

class EmptyPage extends StatefulWidget {

  final String? value;

  const EmptyPage({
    Key? key,
    this.value
  }) : super(key: key);

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return ColorBoxWidget(
      child: Center(
        child: AppText('空空的什么也没有! ${widget.value}'),
      ),
    );
  }
}
