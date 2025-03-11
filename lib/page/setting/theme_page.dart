
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
import 'package:flutter_penguin/model/app_model.dart';
import 'package:flutter_sky_library/flutter_sky_library.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatefulWidget {

  final bool inline;

  const ThemePage({
    super.key,
    this.inline = false
  });

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {

  final List<OptionItem<int>> _themeItems = [
    OptionItem(S.current.followSystem, XTheme.system),
    OptionItem(S.current.lightMode, XTheme.light),
    OptionItem(S.current.darkMode, XTheme.dark),
  ];

  late AppModel _appModel;
  late XSettings _appSetting;

  @override
  void initState() {
    _appModel = context.read<AppModel>();
    _appSetting = _appModel.appSetting;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SubScaffold(
      inline: widget.inline,
      title: S.of(context).theme,
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return SubScrollWidget(
      children: [
        ListMenuWidget(
          menuItems: _loadThemeItems(),
          intercept: _onThemeAction,
        )
      ],
    );
  }

  List<SubMenuItem> _loadThemeItems() {

    final curTheme = _getCurTheme();

    return _themeItems.map((item) {
      return SubMenuItem.check(
        title: item.name,
        moreIconName: item.value == curTheme.value ? 'ic_check.svg' : null,
        data: item
      );
    }).toList();
  }

  bool _onThemeAction(SubMenuItem menu) {

    final OptionItem<int> theme = menu.data;

    if (theme == _getCurTheme()) {
      return true;
    }

    setState(() {
      _appSetting.setDarkMode(theme.value);
    });

    showMessageDialog(
      context: context,
      title: S.of(context).hint,
      message: '更换主题需要重启才能生效！',
      positive: S.of(context).reboot,
      negative: S.of(context).later
    ).then((value) {
      if (value == 1) {
        _appModel.restartApp(context);
      }
    });
    return true;
  }

  OptionItem<int> _getCurTheme() {
    final mode = _appSetting.getDarkMode(XTheme.system);
    return _themeItems.firstWhere((theme) {
      return theme.value == mode;
    }, orElse: () => _themeItems[0]);
  }
}
