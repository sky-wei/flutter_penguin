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
import 'package:flutter_penguin/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sky_library/data/item/option_item.dart';
import 'package:flutter_sky_library/theme/theme.dart';
import 'package:flutter_sky_library/util/platform_util.dart';
import 'package:flutter_sky_library/widget/app_text.dart';
import 'package:flutter_sky_library/widget/big_button_widget.dart';
import 'package:flutter_sky_library/widget/sub_scaffold.dart';
import 'package:flutter_sky_library/widget/sub_scroll_widget.dart';

class FilterPage extends StatefulWidget {

  final FilterItem filter;

  const FilterPage({
    super.key,
    required this.filter
  });

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  final List<OptionItem<int>> categoryItems = [
    OptionItem(S.current.all, -1),
    OptionItem(S.current.other, 0),
    OptionItem(S.current.textProcessing, 1),
    OptionItem(S.current.systemAdministration, 2),
    OptionItem(S.current.diskMaintenance, 3),
    OptionItem(S.current.systemConfiguration, 4),
    OptionItem(S.current.emailNewsgroups, 5),
    OptionItem(S.current.fileManagement, 6),
    OptionItem(S.current.fileTransfer, 7),
    OptionItem(S.current.diskManagement, 8),
    OptionItem(S.current.networkCommunication, 9),
    OptionItem(S.current.backupCompression, 10),
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
      title: S.current.filter,
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
          runSpacing: PlatformUtil.isTabletMode() ? 10.r : 0,
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
        fontSize: 14.sp,
        color: selected ? Theme.of(context).themeColor : Theme.of(context).mainTextColor,
      ),
      selectedColor: Theme.of(context).themeColor.withAlpha(50),
      backgroundColor: Theme.of(context).highlightColor.withAlpha(50),
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


