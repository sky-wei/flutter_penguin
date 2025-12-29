
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
import 'package:flutter_penguin/page/setting/about_page.dart';
import 'package:flutter_penguin/page/setting/feedback_page.dart';
import 'package:flutter_penguin/page/setting/language_page.dart';
import 'package:flutter_penguin/page/setting/permissions_page.dart';
import 'package:flutter_penguin/page/setting/storage_page.dart';
import 'package:flutter_penguin/page/setting/tablet_page.dart';
import 'package:flutter_penguin/page/setting/theme_page.dart';
import 'package:flutter_penguin/page/setting/update_page.dart';
import 'package:flutter_penguin/util/app_navigator.dart';
import 'package:flutter_sky_library/data/item/sub_menu_item.dart';
import 'package:flutter_sky_library/util/list_controller.dart';
import 'package:flutter_sky_library/util/platform_util.dart';
import 'package:flutter_sky_library/widget/sub_group_widget.dart';

import 'display_page.dart';
import 'font_size_page.dart';

class SettingPage extends StatefulWidget {

  final Widget? leading;
  final bool basic;
  final ListController? controller;
  
  const SettingPage({
    super.key,
    this.leading,
    this.basic = false,
    this.controller
  });

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool get basic => widget.basic;
  bool get inline => widget.controller != null;

  final List<Widget> _pages = const <Widget>[
    ThemePage(),
    LanguagePage(),
    PermissionsPage(),
    StoragePage(),
    UpdatePage(),
    AboutPage(),
    TabletPage(),
    DisplayPage(),
    FontSizePage(),
    FeedbackPage()
  ];

  @override
  Widget build(BuildContext context) {

    final groupItems = _loadGroupItems();

    return SubGroupWidget(
      leading: widget.leading,
      controller: widget.controller,
      onItemTap: _onValueChange,
      title: S.of(context).setting,
      groupItems: groupItems,
    );
  }

  void _onValueChange(int index) {
    AppNavigator.push(context, _pages[index]);
  }

  List<SubGroupItem> _loadGroupItems() {
    return [
      SubGroupItem(
        menuItems: [
          SubMenuItem.more(
            id: 0,
            iconName: 'ic_all_items.svg',
            title: S.of(context).theme,
          ),
          SubMenuItem.more(
            id: 1,
            iconName: 'ic_language.svg',
            title: S.of(context).language,
          ),
        ],
      ),
      SubGroupItem(
        menuItems: [
          SubMenuItem.more(
            id: 7,
            iconName: 'ic_display.svg',
            title: S.current.displaySize,
          ),
          SubMenuItem.more(
            id: 8,
            iconName: 'ic_font_size.svg',
            title: S.current.fontSize,
          ),
          if (PlatformUtil.isMobile())
            SubMenuItem.more(
              id: 6,
              iconName: 'ic_tablet.svg',
              title: S.current.tabletMode,
            ),
        ],
      ),
      if (!basic)
        SubGroupItem(
          menuItems: [
            // SubMenuItem.more(
            //   id: 2,
            //   iconName: 'ic_security.svg',
            //   title: S.of(context).permissions,
            // ),
            SubMenuItem.more(
              id: 3,
              iconName: 'ic_storage.svg',
              title: S.of(context).storage,
            ),
          ],
        ),
      // if (!basic)
      //   SubGroupItem(
      //     menuItems: [
      //       SubMenuItem.more(
      //         id: 4,
      //         iconName: 'ic_update.svg',
      //         title: S.of(context).update,
      //       ),
      //     ],
      //   ),
      SubGroupItem(
        title: S.current.more,
        menuItems: [
          SubMenuItem.more(
            id: 9,
            iconName: 'ic_feedback.svg',
            title: S.current.feedback,
          ),
        ],
      ),
      if (!basic)
        SubGroupItem(
          menuItems: [
            SubMenuItem.more(
              id: 5,
              iconName: 'ic_about.svg',
              title: S.of(context).about,
            ),
          ],
        ),
    ];
  }
}