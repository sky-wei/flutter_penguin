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
import 'package:flutter_penguin/core/context.dart';
import 'package:flutter_penguin/data/item/cmd_doc_item.dart';
import 'package:flutter_penguin/util/list_controller.dart';
import 'package:provider/provider.dart';

import 'cmd_doc_model.dart';
import 'doc_details_page.dart';

class DocDetailsView extends StatefulWidget {

  final bool inline;
  final ListController? listController;
  final CmdDocItem? docItem;

  const DocDetailsView({
    Key? key,
    this.inline = false,
    this.listController,
    this.docItem
  }) : super(key: key);

  @override
  State<DocDetailsView> createState() => _DocDetailsViewState();
}

class _DocDetailsViewState extends State<DocDetailsView> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CmdDocModel(context.read<AppContext>()),
        ),
      ],
      child: DocDetailsPage(docItem: widget.docItem),
    );
  }
}
