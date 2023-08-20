
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
import 'package:flutter_penguin/theme/color.dart';

import 'action_widget.dart';
import 'title_widget.dart';

class SubScaffold extends StatelessWidget {

  final bool inline;
  final Widget? leading;
  final String? title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Widget? body;
  final EdgeInsetsGeometry? padding;

  const SubScaffold({
    Key? key,
    this.inline = false,
    this.leading,
    this.title,
    this.backgroundColor,
    this.actions,
    this.body,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget? title;

    if (this.title != null) {
      title = PageTitleWidget(
        title: this.title!,
      );
    }

    final backgroundColor = inline
        ? XColor.transparent
        : this.backgroundColor ?? Theme.of(context).backgroundColor;

    return Scaffold(
      appBar: title != null || leading != null ? AppBar(
        leadingWidth: 55.r,
        leading: leading ?? (!inline ? BackActionWidget(
          iconSize: 20.r,
          onPressed: () => Navigator.pop(context),
        ) : const Center()),
        centerTitle: true,
        title: title,
        actions: actions,
        elevation: 0,
        primary: inline ? false : true,
        backgroundColor: backgroundColor,
      ) : null,
      primary: inline ? false : true,
      body: padding != null ? Padding(padding: padding!, child: body) : body,
      backgroundColor: backgroundColor,
    );
  }
}
