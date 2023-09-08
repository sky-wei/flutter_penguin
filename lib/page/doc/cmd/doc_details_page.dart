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
import 'package:flutter_penguin/data/item/cmd_doc_item.dart';
import 'package:flutter_penguin/page/doc/cmd/cmd_doc_model.dart';
import 'package:flutter_penguin/page/doc/cmd/cmd_doc_page.dart';
import 'package:flutter_penguin/util/error_util.dart';
import 'package:flutter_penguin/util/message_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sky_library/flutter_sky_library.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:provider/provider.dart';

class DocDetailsPage extends StatefulWidget {

  final bool inline;
  final ListController? listController;
  final CmdDocItem? docItem;

  const DocDetailsPage({
    Key? key,
    this.inline = false,
    this.listController,
    this.docItem
  }) : super(key: key);

  @override
  State<DocDetailsPage> createState() => _DocDetailsPageState();
}

class _DocDetailsPageState extends State<DocDetailsPage> {

  final GlobalKey<InnerLoadingWidgetState> _loadingKey = GlobalKey();

  late CmdDocModel _listDocModel;

  bool get inline => widget.inline;
  ListController? get listController => widget.listController;
  int get _currentIndex => widget.listController?.value ?? -1;
  CmdDocItem? get docDetails => _listDocModel.cmdDocItem;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _listDocModel = context.read<CmdDocModel>();
    _listDocModel.detailsNotifier.addListener(_infoChange);
    listController?.addListener(_chooseChange);

    if (widget.docItem != null) {
      _requestDocDetail(widget.docItem);
    }
  }

  @override
  void dispose() {
    _listDocModel.clearCmdDocItem();
    _listDocModel.detailsNotifier.removeListener(_infoChange);
    listController?.removeListener(_chooseChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SubScaffold(
      inline: inline,
      title: '命令说明',
      body: _buildBodyWidget(),
      padding: REdgeInsets.fromLTRB(15, 0, 15, 15),
    );
  }

  /// 创建内容控件
  Widget _buildBodyWidget() {
    return Stack(
      children: [
        _buildBody2Widget(),
        InnerLoadingWidget(
          key: _loadingKey,
          loading: !inline,
        ),
      ],
    );
  }

  /// 创建内容控件
  Widget _buildBody2Widget() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return docDetails != null ? MarkdownWidget(
      data: docDetails!.data,
      physics: const BouncingScrollPhysics(),
      config: isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig,
    ) : !_loading ? const EmptyDocWidget(
      message: '没有命令说明～',
    ) : const Center();
  }

  /// 选择修改
  void _chooseChange() {
    _requestDocDetail(_getCurrentDoc());
  }

  /// 请求详情信息
  void _requestDocDetail(CmdDocItem? item) {

    if (item == null) {
      // 异常情况不需要处理
      return;
    }

    _showLoading();
    _listDocModel.requestDetail(
      item, 500
    ).then((value) {
      _cancelLoading();
    }).onError((error, stackTrace) {
      _cancelLoading();
      MessageUtil.showMessage(context, ErrorUtil.getMessage(context, error));
    });
  }

  /// 获取当前的命令
  CmdDocItem? _getCurrentDoc() {
    final docItems = _listDocModel.cmdDocItems;
    if (docItems.isSafeRange(_currentIndex)) {
      return docItems[_currentIndex];
    }
    return null;
  }

  /// 显示加载
  void _showLoading() {
    _loading = true;
    _loadingKey.currentState?.setLoading(true);
  }

  /// 取消加载
  void _cancelLoading() {
    _loading = false;
    _loadingKey.currentState?.setLoading(false);
  }

  /// 修改修改
  void _infoChange() {
    setState(() {

    });
  }
}

