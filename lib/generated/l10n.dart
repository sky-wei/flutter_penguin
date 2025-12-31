// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `CmdDoc`
  String get appName {
    return Intl.message(
      'CmdDoc',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Hint`
  String get hint {
    return Intl.message(
      'Hint',
      name: 'hint',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Display`
  String get display {
    return Intl.message(
      'Display',
      name: 'display',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Permissions`
  String get permissions {
    return Intl.message(
      'Permissions',
      name: 'permissions',
      desc: '',
      args: [],
    );
  }

  /// `Storage`
  String get storage {
    return Intl.message(
      'Storage',
      name: 'storage',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Restart`
  String get reboot {
    return Intl.message(
      'Restart',
      name: 'reboot',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Follow System`
  String get followSystem {
    return Intl.message(
      'Follow System',
      name: 'followSystem',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get lightMode {
    return Intl.message(
      'Light Mode',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `简体中文`
  String get simplifiedChinese {
    return Intl.message(
      '简体中文',
      name: 'simplifiedChinese',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get on {
    return Intl.message(
      'On',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `{value} cannot be empty!`
  String xNotEmpty(Object value) {
    return Intl.message(
      '$value cannot be empty!',
      name: 'xNotEmpty',
      desc: '',
      args: [value],
    );
  }

  /// `{value} seconds`
  String xSeconds(Object value) {
    return Intl.message(
      '$value seconds',
      name: 'xSeconds',
      desc: '',
      args: [value],
    );
  }

  /// `Off`
  String get off {
    return Intl.message(
      'Off',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `Version: {value}`
  String versionX(Object value) {
    return Intl.message(
      'Version: $value',
      name: 'versionX',
      desc: '',
      args: [value],
    );
  }

  /// `Email: {value}`
  String mailX(Object value) {
    return Intl.message(
      'Email: $value',
      name: 'mailX',
      desc: '',
      args: [value],
    );
  }

  /// `Source Code: {value}`
  String sourceX(Object value) {
    return Intl.message(
      'Source Code: $value',
      name: 'sourceX',
      desc: '',
      args: [value],
    );
  }

  /// `Copyright 2025 The sky Authors\n\nLicensed under the Apache License, Version 2.0 (the "License");\nyou may not use this file except in compliance with the License.\nYou may obtain a copy of the License at\n\n   http://www.apache.org/licenses/LICENSE-2.0\n\nUnless required by applicable law or agreed to in writing, software\ndistributed under the License is distributed on an "AS IS" BASIS,\nWITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\nSee the License for the specific language governing permissions and\nlimitations under the License.`
  String get license {
    return Intl.message(
      'Copyright 2025 The sky Authors\n\nLicensed under the Apache License, Version 2.0 (the "License");\nyou may not use this file except in compliance with the License.\nYou may obtain a copy of the License at\n\n   http://www.apache.org/licenses/LICENSE-2.0\n\nUnless required by applicable law or agreed to in writing, software\ndistributed under the License is distributed on an "AS IS" BASIS,\nWITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\nSee the License for the specific language governing permissions and\nlimitations under the License.',
      name: 'license',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Text Processing`
  String get textProcessing {
    return Intl.message(
      'Text Processing',
      name: 'textProcessing',
      desc: '',
      args: [],
    );
  }

  /// `System Administration`
  String get systemAdministration {
    return Intl.message(
      'System Administration',
      name: 'systemAdministration',
      desc: '',
      args: [],
    );
  }

  /// `Disk Maintenance`
  String get diskMaintenance {
    return Intl.message(
      'Disk Maintenance',
      name: 'diskMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `System Configuration`
  String get systemConfiguration {
    return Intl.message(
      'System Configuration',
      name: 'systemConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Email & Newsgroups`
  String get emailNewsgroups {
    return Intl.message(
      'Email & Newsgroups',
      name: 'emailNewsgroups',
      desc: '',
      args: [],
    );
  }

  /// `File Management`
  String get fileManagement {
    return Intl.message(
      'File Management',
      name: 'fileManagement',
      desc: '',
      args: [],
    );
  }

  /// `File Transfer`
  String get fileTransfer {
    return Intl.message(
      'File Transfer',
      name: 'fileTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Disk Management`
  String get diskManagement {
    return Intl.message(
      'Disk Management',
      name: 'diskManagement',
      desc: '',
      args: [],
    );
  }

  /// `Network Communication`
  String get networkCommunication {
    return Intl.message(
      'Network Communication',
      name: 'networkCommunication',
      desc: '',
      args: [],
    );
  }

  /// `Backup & Compression`
  String get backupCompression {
    return Intl.message(
      'Backup & Compression',
      name: 'backupCompression',
      desc: '',
      args: [],
    );
  }

  /// `Command List`
  String get cmdList {
    return Intl.message(
      'Command List',
      name: 'cmdList',
      desc: '',
      args: [],
    );
  }

  /// `Search Commands`
  String get searchCmd {
    return Intl.message(
      'Search Commands',
      name: 'searchCmd',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `The list is empty~`
  String get listEmptyTips {
    return Intl.message(
      'The list is empty~',
      name: 'listEmptyTips',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Command Description`
  String get cmdDescription {
    return Intl.message(
      'Command Description',
      name: 'cmdDescription',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Feature not yet available!`
  String get featureNotYetAvailable {
    return Intl.message(
      'Feature not yet available!',
      name: 'featureNotYetAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to close the application?`
  String get exitAppTips {
    return Intl.message(
      'Are you sure you want to close the application?',
      name: 'exitAppTips',
      desc: '',
      args: [],
    );
  }

  /// `Display Zoom`
  String get displaySize {
    return Intl.message(
      'Display Zoom',
      name: 'displaySize',
      desc: '',
      args: [],
    );
  }

  /// `Font Size`
  String get fontSize {
    return Intl.message(
      'Font Size',
      name: 'fontSize',
      desc: '',
      args: [],
    );
  }

  /// `Tablet Mode`
  String get tabletMode {
    return Intl.message(
      'Tablet Mode',
      name: 'tabletMode',
      desc: '',
      args: [],
    );
  }

  /// `Language change requires restart to take effect!`
  String get languageRestartAppTips {
    return Intl.message(
      'Language change requires restart to take effect!',
      name: 'languageRestartAppTips',
      desc: '',
      args: [],
    );
  }

  /// `Data`
  String get data {
    return Intl.message(
      'Data',
      name: 'data',
      desc: '',
      args: [],
    );
  }

  /// `Clear Data`
  String get clearData {
    return Intl.message(
      'Clear Data',
      name: 'clearData',
      desc: '',
      args: [],
    );
  }

  /// `Theme change requires restart to take effect!`
  String get themeRestartAppTips {
    return Intl.message(
      'Theme change requires restart to take effect!',
      name: 'themeRestartAppTips',
      desc: '',
      args: [],
    );
  }

  /// `Display zoom change requires restart to take effect!`
  String get displayRestartAppTips {
    return Intl.message(
      'Display zoom change requires restart to take effect!',
      name: 'displayRestartAppTips',
      desc: '',
      args: [],
    );
  }

  /// `Font size change requires restart to take effect!`
  String get fontRestartAppTips {
    return Intl.message(
      'Font size change requires restart to take effect!',
      name: 'fontRestartAppTips',
      desc: '',
      args: [],
    );
  }

  /// `Extra Small`
  String get sizeExtraSmall {
    return Intl.message(
      'Extra Small',
      name: 'sizeExtraSmall',
      desc: '',
      args: [],
    );
  }

  /// `Small`
  String get sizeSmall {
    return Intl.message(
      'Small',
      name: 'sizeSmall',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get sizeDefault {
    return Intl.message(
      'Default',
      name: 'sizeDefault',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get sizeMedium {
    return Intl.message(
      'Medium',
      name: 'sizeMedium',
      desc: '',
      args: [],
    );
  }

  /// `Large`
  String get sizeLarge {
    return Intl.message(
      'Large',
      name: 'sizeLarge',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to clear all local database data?`
  String get clearLocalAllDataTips {
    return Intl.message(
      'Are you sure you want to clear all local database data?',
      name: 'clearLocalAllDataTips',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Save to Local`
  String get saveToLocal {
    return Intl.message(
      'Save to Local',
      name: 'saveToLocal',
      desc: '',
      args: [],
    );
  }

  /// `Service Agreement`
  String get serviceAgreement {
    return Intl.message(
      'Service Agreement',
      name: 'serviceAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Scan Qrcode for feedback`
  String get scanQrcodeFeedbackTips {
    return Intl.message(
      'Scan Qrcode for feedback',
      name: 'scanQrcodeFeedbackTips',
      desc: '',
      args: [],
    );
  }

  /// `Save Image`
  String get saveImage {
    return Intl.message(
      'Save Image',
      name: 'saveImage',
      desc: '',
      args: [],
    );
  }

  /// `Saved to: {path}`
  String saveTo(Object path) {
    return Intl.message(
      'Saved to: $path',
      name: 'saveTo',
      desc: '',
      args: [path],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Press again to exit to desktop!`
  String get exitTips {
    return Intl.message(
      'Press again to exit to desktop!',
      name: 'exitTips',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
