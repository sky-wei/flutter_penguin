
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/item/avatar_image.dart';
import '../util/log_util.dart';
import '../util/platform_util.dart';

/// 用户头像控件
class UserAvatarWidget extends StatelessWidget {

  final double? width;
  final AvatarImage avatarImage;
  final AvatarImage? errorAvatar;

  const UserAvatarWidget({
    Key? key,
    this.width,
    required this.avatarImage,
    this.errorAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final imageWidth = width ?? (PlatformUtil.isTabletMode() ? 150.r : 120.r);

    return _buildAvatarWidget(
        context: context,
        width: imageWidth,
        avatar: avatarImage,
        errorWidget: _buildErrorWidget(context, imageWidth)
    );
  }

  /// 生成异常后的头像控件
  Widget? _buildErrorWidget(BuildContext context, double imageWidth) {
    if (errorAvatar != null) {
      return _buildAvatarWidget(
          context: context,
          width: imageWidth,
          avatar: errorAvatar!
      );
    }
    return null;
  }

  /// 生成头像控件
  Widget _buildAvatarWidget({
    required BuildContext context,
    required double width,
    required AvatarImage avatar,
    Widget? errorWidget,
  }) {
    return ClipOval(
      child: Image.asset(
        avatarImage.path,
        width: width,
        errorBuilder: errorWidget != null ? (context, error, stackTrace) {
          XLog.d('加载图片异常！ $error');
          return errorWidget;
        } : null,
      ),
    );
  }
}