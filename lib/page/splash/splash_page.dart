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

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_penguin/core/context.dart';
import 'package:flutter_penguin/generated/l10n.dart';
import 'package:flutter_penguin/model/app_model.dart';
import 'package:flutter_penguin/route.dart';
import 'package:flutter_penguin/util/error_util.dart';
import 'package:flutter_penguin/util/message_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sky_library/flutter_sky_library.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:objectbox/objectbox.dart';
import 'package:provider/provider.dart';


class SplashPage extends StatefulWidget {

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  late AppContext _appContext;
  late AppModel _appModel;

  XSettings get appSetting => _appContext.appSetting;

  @override
  void initState() {
    super.initState();
    _appContext = context.read<AppContext>();
    _appModel = context.read<AppModel>();
    _appContext.initialize().then((value) {
      context.pushReplacement(XRoute.home);
    }).onError((error, stackTrace) {
      _handleInitError(error, stackTrace);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (PlatformUtil.isMobile()) {
      final orientation = appSetting.isTabletMode()
          ? Orientation.landscape : Orientation.portrait;
      PlatformUtil.setPreferredOrientations(context, orientation);
    }
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {
    
    final backgroundColor = Theme.of(context).xColor.surface;
    
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
          ),
          body: _buildBodyContent(context),
          backgroundColor: backgroundColor,
        ),
        onWillPop: () => Future.value(false)
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/svg/ic_head_logo.svg',
            width: 50.r,
            color: Theme.of(context).themeColor,
          ),
          XBox.vertical20,
          Text(
            S.of(context).loading,
            style: TextStyle(
              fontSize: 18.sp
            ),
          )
        ],
      ),
    );
  }

  /// 处理错误
  void _handleInitError(Object? error, StackTrace stackTrace) {
    if (error is ObjectBoxException) {
      _showResetPublicDatabaseDialog();
    } else {
      MessageUtil.showMessage(context, ErrorUtil.getMessage(context, error));
    }
  }

  /// 显示重置数据库的提示框
  Future<void> _showResetPublicDatabaseDialog() async {

    final result = await showMessageDialog(
      context: context,
      title: S.of(context).hint,
      message: '您的数据库出现异常,是否删除本地数据库文件？ 删除完成后应用将自动退出！',
      positive: S.of(context).ok,
      negative: S.of(context).cancel,
    );

    if (result != 1) return;

    // 删除公共数据库
    _appModel.deletePublicDatabase().then((value) {
      if (value) appWindow.close();
    }).onError((error, stackTrace) {
      MessageUtil.showMessage(context, ErrorUtil.getMessage(context, error));
    });
  }
}

