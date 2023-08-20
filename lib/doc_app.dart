

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
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/context.dart';
import 'core/settings.dart';
import 'generated/l10n.dart';
import 'model/app_model.dart';
import 'page/home/home_page.dart';
import 'page/splash/splash_page.dart';
import 'route.dart';
import 'theme/theme.dart';
import 'util/app_navigator_observer.dart';
import 'util/easy_loading_util.dart';
import 'util/platform_util.dart';
import 'widget/monitor_widget.dart';


class DocApp extends StatefulWidget {

  final BaseContext baseContext;

  const DocApp({
    Key? key,
    required this.baseContext
  }) : super(key: key);

  @override
  State<DocApp> createState() => _DocAppState();
}

class _DocAppState extends State<DocApp> {

  BaseContext get baseContext => widget.baseContext;
  XSettings get appSetting => baseContext.appSetting;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _getDesignSize(),
      builder: (context, child) {
        return _buildBodyWidget(context);
      }
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    PlatformUtil.initialize(appSetting);
    PlatformUtil.setUIOverlayStyle(appSetting);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppContext(baseContext: baseContext)
        ),
        ChangeNotifierProvider(
          create: (context) => AppModel(context.read<AppContext>())
        ),
      ],
      child: MaterialApp(
        title: 'ToolBox',
        theme: XTheme.lightTheme(context),
        darkTheme: XTheme.darkTheme(context),
        themeMode: _getThemeMode(),
        debugShowCheckedModeBanner: false,
        routes: {
          XRoute.splash: (context) => const SplashPage(),
          XRoute.home: (context) => const HomePage(),
        },
        builder: EasyLoading.init(builder: (context, child) {
          LoadingUtil.initialize(context);
          final fontSize = appSetting.getFontSize();
          final data = MediaQuery.of(context).copyWith(textScaleFactor: fontSize);
          return MediaQuery(
            data: data,
            child: MonitorWidget(child: child)
          );
        }),
        initialRoute: XRoute.splash,
        locale: appSetting.getLocale(),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        navigatorObservers: [AppNavigatorObserver()],
      ),
    );
  }

  /// 获取显示大小
  Size _getDesignSize() {
    final size = appSetting.getDisplaySize();
    return PlatformUtil.isPC()
        ? Size(1500 * size, 1000 * size)
        : appSetting.isTabletMode()
        ? Size(1500 * size, 1000 * size)
        : Size(432 * size, 768 * size);
  }

  /// 获取主题模式
  ThemeMode _getThemeMode() {
    final mode = appSetting.getDarkMode(XTheme.system);
    return XTheme.light == mode
        ? ThemeMode.light
        : XTheme.dark == mode
        ? ThemeMode.dark
        : ThemeMode.system;
    // return ThemeMode.dark;
  }
}