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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_penguin/theme/theme.dart';
import 'package:flutter_penguin/util/size_box_util.dart';
import 'package:flutter_penguin/widget/sub_item_line.dart';

import 'app_text.dart';

class SegmentPageView extends StatefulWidget {

  final EdgeInsetsGeometry? padding;
  final int initialPage;
  final List<SegmentItem> segmentItems;

  const SegmentPageView({
    Key? key,
    this.padding,
    this.initialPage = 0,
    required this.segmentItems,
  }) : super(key: key);

  @override
  State<SegmentPageView> createState() => _SegmentPageViewState();
}

class _SegmentPageViewState extends State<SegmentPageView> {

  late int _currentIndex;
  late PageController _pageController;
  
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPage;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        _buildSegmentWidget(),
        XBox.vertical15,
        Expanded(
          child: _buildPageViewWidget(),
        ),
      ],
    );
  }
  
  Widget _buildSegmentWidget() {
    return CupertinoSlidingSegmentedControl (
      children: _buildTitleWidget(),
      groupValue: _currentIndex,
      padding: REdgeInsets.symmetric(vertical: 3, horizontal: 4),
      thumbColor: Theme.of(context).xColor.background,
      backgroundColor: Theme.of(context).xColor.bottom,
      onValueChanged: (int? index) {
        _setCurrentIndex(index!);
      },
    );
  }

  Widget _buildPageViewWidget() {

    final children = widget.segmentItems.map((e) => e.child).toList();

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: PageView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: children,
      ),
    );
  }

  Map<int, Widget> _buildTitleWidget() {

    Map<int, Widget> children = {};
    final items = widget.segmentItems;

    for (int i = 0; i < items.length; i++) {
      children[i] = AppText(items[i].title);
    }
    return children;
  }

  void _setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }
}


class SegmentItem {
  
  final String title;
  final Widget child;

  SegmentItem(this.title, this.child);
}


