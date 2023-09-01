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
import 'package:flutter_penguin/data/item/cmd_doc_item.dart';
import 'package:flutter_penguin/page/doc/cmd/cmd_doc_model.dart';
import 'package:flutter_penguin/page/doc/cmd/filter_page.dart';
import 'package:flutter_penguin/theme/theme.dart';
import 'package:flutter_penguin/util/app_extension.dart';
import 'package:flutter_penguin/util/app_navigator.dart';
import 'package:flutter_penguin/util/error_util.dart';
import 'package:flutter_penguin/util/list_controller.dart';
import 'package:flutter_penguin/util/log_util.dart';
import 'package:flutter_penguin/util/message_util.dart';
import 'package:flutter_penguin/util/platform_util.dart';
import 'package:flutter_penguin/util/size_box_util.dart';
import 'package:flutter_penguin/widget/action_menu_widget.dart';
import 'package:flutter_penguin/widget/app_icon_button.dart';
import 'package:flutter_penguin/widget/app_text.dart';
import 'package:flutter_penguin/widget/frame_widget.dart';
import 'package:flutter_penguin/widget/inner_loading_widget.dart';
import 'package:flutter_penguin/widget/sub_item_line.dart';
import 'package:flutter_penguin/widget/sub_scaffold.dart';
import 'package:flutter_penguin/widget/text_field_widget.dart';
import 'package:flutter_penguin/widget/title_widget.dart';
import 'package:flutter_penguin/widget/widget_factory.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'cmd_doc_page.dart';
import 'doc_details_view.dart';

class CmdListPage extends StatefulWidget {

  final bool inline;
  final ListController? listController;
  final Widget? leading;
  final ListType listType;

  const CmdListPage({
    Key? key,
    this.inline = false,
    this.listController,
    this.leading,
    this.listType = ListType.all
  }) : super(key: key);

  @override
  State<CmdListPage> createState() => _CmdListPageState();
}

class _CmdListPageState extends State<CmdListPage> {

  final GlobalKey<InnerLoadingWidgetState> _loadingKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  late CmdDocModel _cmdDocModel;

  bool get inline => widget.inline;
  int get _currentIndex => widget.listController?.value ?? -1;
  List<CmdDocItem> get cmdDocItems => _cmdDocModel.cmdDocItems;

  @override
  void initState() {
    super.initState();
    _cmdDocModel = context.read<CmdDocModel>();
    _cmdDocModel.addListener(_infoChange);
    _scrollController.addListener(_handlerLoadMore);
    refreshDocList(delayedTime: 50);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cmdDocModel.removeListener(_infoChange);
    super.dispose();
  }

  void _handlerLoadMore() {

    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      XLog.d('>>>>>>>>>>>>>>>>>>>> yyyyyy');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformUtil.isTabletMode()
        ? _buildDesktopBody() : _buildMobileBody();
  }

  Widget _buildDesktopBody() {
    return SubScaffold(
      title: '命令列表',
      inline: widget.inline,
      actions: [_buildFilterWidget()],
      body: _buildFrameWidget(),
    );
  }

  Widget _buildMobileBody() {
    return Scaffold(
      appBar: AppBar(
        leading: widget.leading,
        title: const PageTitleWidget(
          title: '命令列表',
        ),
        centerTitle: true,
        elevation: 0,
        actions: [_buildFilterWidget()],
      ),
      body: _buildFrameWidget(),
    );
  }

  Widget _buildFrameWidget() {
    return Flex(
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
    return Padding(
      padding: REdgeInsets.fromLTRB(0, 0, 22, 0),
      child: ActionMenuWidget(
        iconSize: 18.r,
        iconName: 'ic_filter.svg',
        tooltip: '筛选',
        onPressed: () => _showFilterPage(context),
      ),
    );
  }

  /// 创建内容体
  Widget _buildBodyWidget() {
    if (_loadingKey.currentState != null && cmdDocItems.isEmpty) {
      return EmptyDocWidget(
        width: 240.w,
        message: '还没有命令～',
      );
    }
    return _buildListWidget();
  }

  /// 创建列表控件
  Widget _buildListWidget() {

    final listWidget = ListView.separated(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final item = cmdDocItems[index];
        return ListItemWidget(
          item: item,
          onChoose: (item) => _currentIndex == index,
          onPressed: (item) => _chooseListItem(index),
          onFavorite: (item) => _favoriteListItem(index)
        );
      },
      separatorBuilder: (context, index) {
        return WidgetFactory.buildLeft15Line();
      },
      itemCount: cmdDocItems.length
    );

    if (!PlatformUtil.isTabletMode()) {
      return SlidableAutoCloseBehavior(
        child: listWidget,
      );
    }
    return listWidget;
  }

  /// 选择列表
  void _chooseListItem(int index) {

    final listController = widget.listController;

    if (listController != null) {
      setState(() => listController.setValue(index, cmdDocItems[index]));
      return;
    }

    AppNavigator.start(
      context: context,
      child: DocDetailsView(docItem: cmdDocItems[index])
    );
  }

  void _favoriteListItem(int index) {

    final item = cmdDocItems[index];

    _cmdDocModel.favoriteCmdDoc(
      widget.listType, item
    ).catchError((error, stackTrace) {
      MessageUtil.showMessage(context, ErrorUtil.getMessage(context, error));
    });
  }

  /// 搜索
  void _onSearch(String keyword) {
    refreshDocList(keyword: keyword);
    _focusNode.requestFocus();
  }

  /// 刷新命令列表
  void refreshDocList({
    String? keyword,
    int? category,
    int? delayedTime,
  }) {
    _showLoading();
    _cmdDocModel.refreshDocList(
      keyword: keyword,
      category: category,
      delayedTime: delayedTime,
      listType: widget.listType,
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
        child: FilterPage(filter: FilterItem(_cmdDocModel.queryDoc.category))
    );

    if (value != null) {
      _cmdDocModel.refreshDocList(
        category: value.category,
        listType: widget.listType,
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

    if (!cmdDocItems.isSafeRange(index)) {
      // 超出重置选择
      listController.setValue(-1);
      return;
    }

    // 获取选择订单
    final order = cmdDocItems[_currentIndex];

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


class ListItemWidget extends StatefulWidget {

  final CmdDocItem item;
  final ChooseItem<CmdDocItem> onChoose;
  final ValueChanged<CmdDocItem> onPressed;
  final ValueChanged<CmdDocItem> onFavorite;

  const ListItemWidget({
    super.key,
    required this.item,
    required this.onChoose,
    required this.onPressed,
    required this.onFavorite,
  });

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {

  bool _favoriteState = false;

  bool get favorite => widget.item.favorite;
  bool get unFavorite => _favoriteState && !widget.item.favorite;

  @override
  Widget build(BuildContext context) {

    final choose = widget.onChoose(widget.item);

    final frameWidget = ChooseFrameWidget(
      choose: choose,
      chooseColor: Theme.of(context).highlightColor.withOpacity(0.2),
      onTap: () { widget.onPressed(widget.item); },
      child: MouseRegion(
        onEnter: (event) { _setFavorite(true); },
        onExit: (event) { _setFavorite(false); },
        child: Stack(
          children: [
            _buildInfoWidget(widget.item),
            if (favorite)
              _buildFavorite(
                  icon: 'assets/svg/ic_favorite.svg',
                  color: Theme.of(context).favoriteColor,
                  onPressed: _handlerFavorite
              ),
            if (unFavorite)
              _buildFavorite(
                  icon: 'assets/svg/ic_un_favorite.svg',
                  color: Theme.of(context).hintColor,
                  onPressed: _handlerFavorite
              ),
          ],
        ),
      )
    );

    if (!PlatformUtil.isTabletMode()) {
      return Slidable(
        groupTag: '0',
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            _buildFavoriteAction(
              favorite: favorite,
              onPressed: (context) {
                _handlerFavorite();
              }
            ),
          ]
        ),
        child: frameWidget,
      );
    }

    return frameWidget;
  }

  /// 创建信息控件
  Widget _buildInfoWidget(CmdDocItem item) {
    return SizedBox(
      width: double.infinity,
      child: Column(
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
      ),
    );
  }

  /// 创建收藏控件
  Widget _buildFavorite({
    required String icon,
    required Color color,
    VoidCallback? onPressed
  }) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: REdgeInsets.only(top: 3.r, right: 3.r),
        child: AppIconButton(
          iconSize: 18.r,
          splashRadius: 24.r,
          padding: const EdgeInsets.all(0),
          constraints: BoxConstraints(
              maxWidth: 18.r
          ),
          onPressed: onPressed,
          icon: SvgPicture.asset(
            icon,
            color: color,
            width: 18.r,
          )
        ),
      ),
    );
  }

  /// 创建收藏控件
  SlidableAction _buildFavoriteAction({
    required bool favorite,
    required SlidableActionCallback onPressed
  }) {
    return SlidableAction(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).favoriteColor,
      foregroundColor: Colors.white,
      icon: !favorite ? Icons.star_border_outlined : Icons.star,
      label: !favorite ? '收藏' : '取消',
      borderRadius: const BorderRadius.all(Radius.circular(6)),
    );
  }

  /// 处理收藏事件
  void _handlerFavorite() {
    widget.onFavorite(widget.item);
  }

  /// 设置收藏状态
  void _setFavorite(bool show) {
    setState(() {
      _favoriteState = show;
    });
  }
}

