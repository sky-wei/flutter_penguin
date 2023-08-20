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
import 'package:flutter_penguin/data/item/option_item.dart';
import 'package:flutter_penguin/theme/color.dart';
import 'package:flutter_penguin/theme/theme.dart';
import 'package:flutter_penguin/widget/app_text.dart';
import 'package:flutter_penguin/widget/big_button_widget.dart';
import 'package:flutter_penguin/widget/sub_scaffold.dart';
import 'package:flutter_penguin/widget/sub_scroll_widget.dart';

class FilterPage extends StatefulWidget {

  final FilterItem filter;

  const FilterPage({
    Key? key,
    required this.filter
  }) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  final List<OptionItem<int>> categoryItems = [
    OptionItem('所有', -1),
    OptionItem('其他', 0),
    OptionItem('文本处理', 1),
    OptionItem('系统管理', 2),
    OptionItem('磁盘维护', 3),
    OptionItem('系统设置', 4),
    OptionItem('电子邮件与新闻组', 5),
    OptionItem('文件管理', 6),
    OptionItem('文件传输', 7),
    OptionItem('磁盘管理', 8),
    OptionItem('网络通讯', 9),
    OptionItem('备份压缩', 10),
  ];

  late FilterItem _filterItem;

  @override
  void initState() {
    super.initState();
    _filterItem = widget.filter.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return SubScaffold(
      title: '筛选',
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return SubScrollWidget(
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: REdgeInsets.all(30),
      children: [
        // XBox.vertical15,
        Wrap(
          // alignment: WrapAlignment.center,
          // runAlignment: WrapAlignment.center,
          // crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10.r,
          runSpacing: 10.r,
          children: _buildCategoryListWidget(),
        ),
        // XBox.vertical60,
        // Align(
        //   alignment: Alignment.center,
        //   child: BoxButtonWidget(
        //     onPressed: _ok,
        //     text: S.of(context).ok,
        //   ),
        // )
      ],
    );
  }

  List<Widget> _buildCategoryListWidget() {
    return categoryItems.map((item) {
      return _buildCategoryWidget(
        item: item,
        selected: item.value == _filterItem.category,
        onSelected: (value) {
          _onCategorySelected(item);
        }
      );
    }).toList();
  }

  Widget _buildCategoryWidget({
    required OptionItem<int> item,
    bool selected = false,
    ValueChanged<bool>? onSelected,
  }) {
    return ChoiceChip(
      padding: REdgeInsets.all(8),
      label: AppText(
        item.name,
        fontSize: 15.sp,
        color: selected ? XColor.white : Theme.of(context).mainTextColor,
      ),
      selectedColor: Theme.of(context).themeColor,
      disabledColor: Theme.of(context).highlightColor,
      elevation: 0,
      pressElevation: 0,
      selected: selected,
      onSelected: onSelected,
    );
  }

  void _onCategorySelected(OptionItem<int> item) {

    // setState(() {
    //   _filterItem.category = item.value;
    // });

    _filterItem.category = item.value;
    Navigator.pop(context, _filterItem);
  }

  void _ok() {

  }
}

class BoxButtonWidget extends StatelessWidget {

  final String text;
  final VoidCallback? onPressed;

  const BoxButtonWidget({
    Key? key,
    required this.text,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 380.w),
      child: BigButtonWidget(
        text: text,
        onPressed: onPressed,
      )
    );
  }
}

class FilterItem {

  int category;

  FilterItem copyWith({
    int? category
  }) {
    return FilterItem(
      category ?? this.category
    );
  }

  FilterItem(this.category);
}


