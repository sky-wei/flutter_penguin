
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
import 'package:flutter_penguin/util/list_controller.dart';

class SubPageWidget extends StatefulWidget {

  final ListController controller;
  final List<Widget> pages;

  const SubPageWidget({
    Key? key,
    required this.controller,
    required this.pages
  }) : super(key: key);

  @override
  State<SubPageWidget> createState() => _SubPageWidgetState();
}

class _SubPageWidgetState extends State<SubPageWidget> {

  late PageController _pageController;

  ListController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: controller.value);
    controller.addListener(_onValueChange);
  }

  @override
  void dispose() {
    controller.removeListener(_onValueChange);
    _pageController.dispose();
    super.dispose();
  }

  void _onValueChange() {
    // _pageController.animateToPage(
    //     controller.value,
    //     duration: const Duration(milliseconds: 300),
    //     curve: Curves.ease
    // );
    _pageController.jumpToPage(controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      children: widget.pages,
    );
  }
}