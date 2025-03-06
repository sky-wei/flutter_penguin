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
import 'package:flutter_penguin/constant.dart';
import 'package:flutter_penguin/core/context.dart';
import 'package:provider/provider.dart';

import 'cmd_doc_model.dart';
import 'cmd_doc_page.dart';


class CmdDocView extends StatefulWidget {

  final bool inline;
  final Widget? leading;
  final ListType listType;

  const CmdDocView({
    super.key,
    this.inline = false,
    this.leading,
    this.listType = ListType.all
  });

  @override
  State<CmdDocView> createState() => _CmdDocViewState();
}

class _CmdDocViewState extends State<CmdDocView> {

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }

  /// 创建内容控件
  Widget _buildBodyWidget() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CmdDocModel(context.read<AppContext>()),
        ),
      ],
      child: CmdDocPage(
        inline: widget.inline,
        leading: widget.leading,
        listType: widget.listType,
      ),
    );
  }
}
