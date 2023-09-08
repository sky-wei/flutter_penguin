
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

class FontSizePage extends StatefulWidget {

  final bool inline;

  const FontSizePage({
    Key? key,
    this.inline = false
  }) : super(key: key);

  @override
  State<FontSizePage> createState() => _FontSizePageState();
}

class _FontSizePageState extends State<FontSizePage> {

  final List<OptionItem<double>> _fontSizeItems = [
    OptionItem<double>('小号', 0.9),
    OptionItem<double>('默认', 1),
    OptionItem<double>('中号', 1.1),
    OptionItem<double>('大号', 1.2),
    OptionItem<double>('超大', 1.3),
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
      title: '字体大小',
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return SubScrollWidget(
      children: [
        ListMenuWidget(
          menuItems: _loadFontSizeItems(),
          intercept: _onFontSizeAction,
        ),
      ],
    );
  }

  List<SubMenuItem> _loadFontSizeItems() {

    final curDisplay = _getCurFontSize();

    return _fontSizeItems.map((item) {
      return SubMenuItem.check(
          title: item.name,
          moreIconName: item.value == curDisplay.value ? 'ic_check.svg' : null,
          data: item
      );
    }).toList();
  }

  bool _onFontSizeAction(SubMenuItem menu) {

    final OptionItem<double> option = menu.data;

    if (option == _getCurFontSize()) {
      return true;
    }

    setState(() {
      _appSetting.setFontSize(option.value);
    });

    showMessageDialog(
        context: context,
        title: S.of(context).hint,
        message: '更换字体大小需要重启才能生效！',
        positive: S.of(context).reboot,
        negative: S.of(context).later
    ).then((value) {
      if (value == 1) {
        _appModel.restartApp(context);
      }
    });
    return true;
  }

  OptionItem<double> _getCurFontSize() {
    final size = _appSetting.getFontSize();
    return _fontSizeItems.firstWhere((theme) {
      return theme.value == size;
    }, orElse: () => _fontSizeItems[1]);
  }
}
