
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

class TabletPage extends StatefulWidget {

  final bool inline;

  const TabletPage({
    super.key,
    this.inline = false
  });

  @override
  State<TabletPage> createState() => _TabletPageState();
}

class _TabletPageState extends State<TabletPage> {

  final List<OptionItem<bool>> _tabletItems = [
    OptionItem<bool>(S.current.on, true),
    OptionItem<bool>(S.current.off, false)
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
      title: '平板模式',
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return SubScrollWidget(
      children: [
        ListMenuWidget(
          menuItems: _loadTabletItems(),
          intercept: _onTabletAction,
        ),
      ],
    );
  }

  List<SubMenuItem> _loadTabletItems() {

    final curTablet = _getCurTablet();

    return _tabletItems.map((item) {
      return SubMenuItem.check(
        title: item.name,
        moreIconName: item.value == curTablet.value ? 'ic_check.svg' : null,
        data: item
      );
    }).toList();
  }

  bool _onTabletAction(SubMenuItem menu) {

    final OptionItem<bool> option = menu.data;

    if (option == _getCurTablet()) {
      return true;
    }

    setState(() {
      _appSetting.setTabletMode(option.value);
    });

    showMessageDialog(
      context: context,
      title: S.of(context).hint,
      message: '更换平板模式需要重启才能生效！',
      positive: S.of(context).reboot,
      negative: S.of(context).later
    ).then((value) {
      if (value == 1) {
        _appModel.restartApp(context);
      }
    });
    return true;
  }

  OptionItem<bool> _getCurTablet() {
    final enable = _appSetting.isTabletMode();
    return _tabletItems.firstWhere((theme) {
      return theme.value == enable;
    }, orElse: () => _tabletItems[1]);
  }
}
