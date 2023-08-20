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
import 'package:flutter_penguin/data/item/linux_doc_item.dart';
import 'package:flutter_penguin/data/item/option_item.dart';
import 'package:flutter_penguin/page/doc/linux/filter_page.dart';
import 'package:flutter_penguin/page/doc/linux/linux_doc_model.dart';
import 'package:flutter_penguin/theme/theme.dart';
import 'package:flutter_penguin/util/app_extension.dart';
import 'package:flutter_penguin/util/app_navigator.dart';
import 'package:flutter_penguin/util/error_util.dart';
import 'package:flutter_penguin/util/list_controller.dart';
import 'package:flutter_penguin/util/log_util.dart';
import 'package:flutter_penguin/util/message_util.dart';
import 'package:flutter_penguin/util/size_box_util.dart';
import 'package:flutter_penguin/widget/app_icon_button.dart';
import 'package:flutter_penguin/widget/app_text.dart';
import 'package:flutter_penguin/widget/frame_widget.dart';
import 'package:flutter_penguin/widget/inner_loading_widget.dart';
import 'package:flutter_penguin/widget/sub_item_line.dart';
import 'package:flutter_penguin/widget/sub_scaffold.dart';
import 'package:flutter_penguin/widget/text_field_widget.dart';
import 'package:flutter_penguin/widget/widget_factory.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'linux_doc_page.dart';

class DocListPage extends StatefulWidget {

  final bool inline;
  final ListController? listController;

  const DocListPage({
    Key? key,
    this.inline = false,
    this.listController,
  }) : super(key: key);

  @override
  State<DocListPage> createState() => _DocListPageState();
}

class _DocListPageState extends State<DocListPage> {

  final GlobalKey<InnerLoadingWidgetState> _loadingKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  final List<OptionItem<int>> _optionItems = [
    OptionItem('全部', -1)
  ];
  late LinuxDocModel _linuxDocModel;

  bool get inline => widget.inline;
  int get _currentIndex => widget.listController?.value ?? -1;
  List<LinuxDocItem> get linuxDocItems => _linuxDocModel.linuxDocItems;

  @override
  void initState() {
    super.initState();
    _linuxDocModel = context.read<LinuxDocModel>();
    _linuxDocModel.addListener(_infoChange);
    _scrollController.addListener(_handlerLoadMore);
    refreshDocList(delayedTime: 50);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _linuxDocModel.removeListener(_infoChange);
    super.dispose();
  }

  void _handlerLoadMore() {

    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      XLog.d('>>>>>>>>>>>>>>>>>>>> yyyyyy');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SubScaffold(
      title: '命令列表',
      inline: widget.inline,
      actions: [_buildFilterWidget()],
      body: Flex(
        direction: Axis.vertical,
        children: [
          _buildSearchWidget(),
          XBox.vertical15,
          // _buildFilterWidget(),
          // XBox.vertical15,
          const SubItemLine(),
          // XBox.vertical5,
          Expanded(
            child: Stack(
              children: [
                _buildBodyWidget(),
                InnerLoadingWidget(
                  key: _loadingKey,
                  loading: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 创建搜索控件
  Widget _buildSearchWidget() {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 15),
      child: TextFieldWidget(
        iconName: 'ic_search.svg',
        hintText: '搜索命令',
        fillColor: !inline ? Theme.of(context).xColor.background : null,
        focusNode: _focusNode,
        height: 46.r,
        maxLength: 50,
        onChanged: (value) => _onSearch(value),
        // onSubmitted: (value) => _onSearch(value),
      ),
    );
  }


  /// 创建过虑的控件
  Widget _buildFilterWidget() {
    // return LayoutBuilder(builder: (context, type) {
    //   return ;
    // });

    return Padding(
      padding: REdgeInsets.fromLTRB(0, 0, 25, 0),
      child: AppIconButton(
        iconSize: 18.r,
        splashRadius: 26.r,
        icon: SvgPicture.asset(
          'assets/svg/ic_filter.svg',
          color: Theme.of(context).iconTheme.color,
          width: 18.r,
        ),
        tooltip: '筛选',
        onPressed: () => _showFilterPage(context),
      ),
    );

    // return Padding(
    //   padding: REdgeInsets.symmetric(horizontal: 15),
    //   child: Row(
    //     children: [
    //       AppText(
    //         '总数: ${_linuxDocModel.linuxDocItems.length}',
    //         fontSize: 15.sp,
    //         color: Theme.of(context).hintColor,
    //       ),
    //       const Spacer(),
    //       // SimpleDropdownButton<int>(
    //       //   buttonWidth: 130.w,
    //       //   buttonHeight: 36.h,
    //       //   // buttonDecoration: BoxDecoration(
    //       //   //   color: Theme.of(context).highlightColor,
    //       //   //   borderRadius: BorderRadius.circular(6),
    //       //   //   // border: Border.symmetric(),
    //       //   // ),
    //       //   buttonPadding: REdgeInsets.only(left: 10, right: 5),
    //       //   dropdownItems: _optionItems,
    //       //   value: _getCurOption(),
    //       //   onChanged: (value) => _setOption(value!),
    //       // ),
    //       AppIconButton(
    //         iconSize: 16.r,
    //         splashRadius: 24.r,
    //         icon: SvgPicture.asset(
    //           'assets/svg/ic_filter.svg',
    //           color: Theme.of(context).iconTheme.color,
    //           width: 18.r,
    //         ),
    //         tooltip: '过滤',
    //         onPressed: () {
    //
    //         },
    //       ),
    //       XBox.horizontal5,
    //     ],
    //   ),
    // );
  }

  /// 创建内容体
  Widget _buildBodyWidget() {
    if (_loadingKey.currentState != null && linuxDocItems.isEmpty) {
      return EmptyDocWidget(
        width: 240.w,
        message: '还没有命令～',
      );
    }
    return _buildListWidget();
  }

  /// 创建列表控件
  Widget _buildListWidget() {
    return ListView.separated(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildItemWidget(
          index: index,
          choose: _currentIndex == index,
          onTap: () => _chooseListItem(index)
        );
      },
      separatorBuilder: (context, index) {
        return WidgetFactory.buildLeft15Line();
      },
      itemCount: linuxDocItems.length
    );
  }

  /// 创建列表项控件
  Widget _buildItemWidget({
    required int index,
    required bool choose,
    GestureTapCallback? onTap,
  }) {
    final item = linuxDocItems[index];

    return ChooseFrameWidget(
      choose: choose,
      chooseColor: Theme.of(context).highlightColor.withOpacity(0.2),
      onTap: onTap,
      child: _buildInfoWidget(item)
    );
  }

  /// 创建信息控件
  Widget _buildInfoWidget(LinuxDocItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          item.name,
          overflow: TextOverflow.ellipsis,
          color: Theme.of(context).mainTextColor,
          fontSize: 18.sp,
        ),
        XBox.vertical5,
        AppText(
          item.category,
          overflow: TextOverflow.ellipsis,
          color: Theme.of(context).hintColor,
        ),
      ],
    );
  }

  /// 选择列表
  void _chooseListItem(int index) {
    setState(() => widget.listController?.setValue(index, linuxDocItems[index]));
  }

  /// 搜索
  void _onSearch(String keyword) {
    refreshDocList(keyword: keyword);
    _focusNode.requestFocus();
  }

  /// 刷新命令列表
  refreshDocList({
    String? keyword,
    int? category,
    int? delayedTime,
  }) {
    _showLoading();
    _linuxDocModel.refreshDocList(
      keyword: keyword,
      category: category,
      delayedTime: delayedTime,
    ).then((value) {
      _cancelLoading();
    }).onError((error, stackTrace) {
      _cancelLoading();
      MessageUtil.showMessage(context, ErrorUtil.getMessage(context, error));
    });
  }

  /// 显示过滤界面
  Future<void> _showFilterPage(BuildContext context) async {

    final value = await AppNavigator.start<FilterItem>(
      context: context,
      // constraints: BoxConstraints(maxWidth: 490.w),
      child: FilterPage(filter: FilterItem(_linuxDocModel.queryDoc.category))
    );

    // showBottomSheet(
    //   context: context,
    //   builder: (context) {
    //     return FilterPage(filter: FilterItem(_linuxDocModel.queryDoc.category));
    //   },
    // );

    if (value != null) {
      _linuxDocModel.refreshDocList(
        category: value.category
      ).onError((error, stackTrace) {
        MessageUtil.showMessage(context, ErrorUtil.getMessage(context, error));
      });
    }
  }

  /// 订单修改
  void _infoChange() {
    setState(() => _notifyListController());
  }

  /// 通知列表修改
  void _notifyListController() {

    final index = _currentIndex;
    final listController = widget.listController;

    if (listController == null || index < 0) {
      return;
    }

    if (!linuxDocItems.isSafeRange(index)) {
      // 超出重置选择
      listController.setValue(-1);
      return;
    }

    // 获取选择订单
    final order = linuxDocItems[_currentIndex];

    if (listController.data != order) {
      // 索引相同订单信息不同
      listController.setValue(-1);
    }
  }

  /// 显示加载
  void _showLoading() {
    _loadingKey.currentState?.setLoading(true);
  }

  /// 取消加载
  void _cancelLoading() {
    _loadingKey.currentState?.setLoading(false);
  }
}
