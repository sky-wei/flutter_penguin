
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
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_penguin/generated/l10n.dart';
import 'package:flutter_penguin/util/app_navigator.dart';
import 'package:flutter_penguin/util/error_util.dart';
import 'package:flutter_penguin/util/message_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sky_library/flutter_sky_library.dart';

class DocumentPage extends StatefulWidget {

  final bool inline;
  final String title;
  final String assetPath;

  const DocumentPage({
    super.key,
    this.inline = false,
    required this.title,
    required this.assetPath
  });

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {

  String? _htmlData;

  @override
  void initState() {
    super.initState();
    _loadDocData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SubScaffold(
      inline: widget.inline,
      title: widget.title,
      padding: REdgeInsets.all(0),
      actions: [
        if (widget.inline)
          _buildCloseWidget(),
      ],
      body: _buildBodyWidget(),
    );
  }

  Widget _buildCloseWidget() {
    return IconButton(
      splashRadius: 20,
      padding: REdgeInsets.all(15),
      onPressed: () { Navigator.pop(context); },
      icon: CloseIcon(color: Theme.of(context).xColor.icon)
    );
  }

  Widget _buildBodyWidget() {

    if (_htmlData == null) {
      return _buildLoadingWidget();
    }

    return SingleChildScrollView(
      padding: REdgeInsets.fromLTRB(15, 0, 15, 20),
      child: Html(
        data: _htmlData,
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Text(
        S.current.loading,
        style: TextStyle(
            color: Theme.of(context).highlightColor
        ),
      ),
    );
  }

  void _loadDocData() {
    _loadAssetData(
      widget.assetPath
    ).then((data) {
      setState(() {
        _htmlData = data;
      });
    }).onError((error, stackTrace) {
      MessageUtil.showMessage(ErrorUtil.getMessage(error));
    });
  }

  Future<String> _loadAssetData(
      String path, {int delay = 300}
      ) async {
    if (delay > 0) {
      await Future.delayed(Duration(milliseconds: delay));
    }
    return await rootBundle.loadString(path);
  }
}

void showDocument({
  required BuildContext context,
  required String title,
  required String assetPath
}) {

  final page = DocumentPage(
    inline: PlatformUtil.isTabletMode(),
    title: title,
    assetPath: assetPath
  );

  if (PlatformUtil.isTabletMode()) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: XBorder.borderRadius6
          ),
          child: SizedBox(
            width: 900,
            height: 650,
            child: page,
          ),
        );
      }
    );
    return;
  }

  AppNavigator.push(context, page);
}



