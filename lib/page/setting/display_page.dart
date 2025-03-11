
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

class DisplayPage extends StatefulWidget {

  final bool inline;

  const DisplayPage({
    super.key,
    this.inline = false
  });

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {

  final List<OptionItem<double>> _displayItems = [
    // OptionItem<double>('0.5x', 1.5),
    // OptionItem<double>('0.6x', 1.4),
    // OptionItem<double>('0.7x', 1.3),
    OptionItem<double>('超小', 1.2),
    OptionItem<double>('小', 1.1),
    OptionItem<double>('默认', 1),
    OptionItem<double>('大', 0.9),
    // OptionItem<double>('1.2x', 0.8),
    // OptionItem<double>('1.3x', 0.7),
    // OptionItem<double>('1.4x', 0.6),
    // OptionItem<double>('1.5x', 0.5),
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
      title: '显示大小',
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return SubScrollWidget(
      children: [
        ListMenuWidget(
          menuItems: _loadDisplayItems(),
          intercept: _onDisplayAction,
        ),
      ],
    );
  }

  List<SubMenuItem> _loadDisplayItems() {

    final curDisplay = _getCurDisplay();

    return _displayItems.map((item) {
      return SubMenuItem.check(
          title: item.name,
          moreIconName: item.value == curDisplay.value ? 'ic_check.svg' : null,
          data: item
      );
    }).toList();
  }

  bool _onDisplayAction(SubMenuItem menu) {

    final OptionItem<double> option = menu.data;

    if (option == _getCurDisplay()) {
      return true;
    }

    setState(() {
      _appSetting.setDisplaySize(option.value);
    });

    showMessageDialog(
        context: context,
        title: S.of(context).hint,
        message: '更换显示大小需要重启才能生效！',
        positive: S.of(context).reboot,
        negative: S.of(context).later
    ).then((value) {
      if (value == 1) {
        _appModel.restartApp(context);
      }
    });
    return true;
  }

  OptionItem<double> _getCurDisplay() {
    final size = _appSetting.getDisplaySize();
    return _displayItems.firstWhere((theme) {
      return theme.value == size;
    }, orElse: () => _displayItems[2]);
  }
}
