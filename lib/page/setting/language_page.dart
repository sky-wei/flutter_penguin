
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

class LanguagePage extends StatefulWidget {

  final bool inline;

  const LanguagePage({
    super.key,
    this.inline = false
  });

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  final List<OptionItem<Locale?>> _localeItems = [
    OptionItem(S.current.followSystem, null),
    OptionItem(S.current.english, const Locale.fromSubtags(languageCode: 'en')),
    OptionItem(S.current.simplifiedChinese, const Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN')),
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
      title: S.of(context).language,
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return SubScrollWidget(
      children: [
        ListMenuWidget(
          menuItems: _loadLocaleItems(),
          intercept: _onLocaleAction,
        )
      ],
    );
  }

  List<SubMenuItem> _loadLocaleItems() {

    final curLocale = _getCurLocale();

    return _localeItems.map((item) {
      return SubMenuItem.check(
          title: item.name,
          moreIconName: item.value == curLocale.value ? 'ic_check.svg' : null,
          data: item
      );
    }).toList();
  }

  bool _onLocaleAction(SubMenuItem menu) {

    final OptionItem<Locale?> locale = menu.data;

    if (locale == _getCurLocale()) {
      return true;
    }

    setState(() {
      _appSetting.setLocale(locale.value);
    });

    showMessageDialog(
      context: context,
      title: S.of(context).hint,
      message: S.current.languageRestartAppTips,
      positive: S.of(context).reboot,
      negative: S.of(context).later
    ).then((value) {
      if (value == 1) {
        _appModel.restartApp(context);
      }
    });
    return true;
  }

  OptionItem<Locale?> _getCurLocale() {
    final curLocale = _appSetting.getLocale();
    return _localeItems.firstWhere((locale) {
      return locale.value == curLocale;
    }, orElse: () => _localeItems[0]);
  }
}
