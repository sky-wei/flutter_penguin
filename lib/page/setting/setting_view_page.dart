
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
import 'package:flutter_penguin/page/setting/font_size_page.dart';
import 'package:flutter_sky_library/util/list_controller.dart';
import 'package:flutter_sky_library/util/size_box_util.dart';
import 'package:flutter_sky_library/widget/expand_box_widget.dart';
import 'package:flutter_sky_library/widget/sub_page_widget.dart';

import 'about_page.dart';
import 'display_page.dart';
import 'language_page.dart';
import 'permissions_page.dart';
import 'setting_page.dart';
import 'storage_page.dart';
import 'tablet_page.dart';
import 'theme_page.dart';
import 'update_page.dart';

class SettingViewPage extends StatefulWidget {

  const SettingViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingViewPageState();

}

class _SettingViewPageState extends State<SettingViewPage> {

  final ListController _menuController = ListController(initIndex: 0);

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        ExpandBoxWidget(
          flex: 3,
          child: SettingPage(
            controller: _menuController
          ),
        ),
        XBox.horizontal8,
        ExpandBoxWidget(
          flex: 7,
          child: SubPageWidget(
            controller: _menuController,
            pages: const [
              ThemePage(inline: true),
              LanguagePage(inline: true),
              PermissionsPage(inline: true),
              StoragePage(inline: true),
              UpdatePage(inline: true),
              AboutPage(inline: true),
              TabletPage(inline: true),
              DisplayPage(inline: true),
              FontSizePage(inline: true),
            ],
          ),
        ),
      ],
    );
  }
}


