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

class InnerLoadingWidget extends StatefulWidget {

  final bool loading;

  const InnerLoadingWidget({
    Key? key,
    this.loading = false,
  }) : super(key: key);

  @override
  State<InnerLoadingWidget> createState() => InnerLoadingWidgetState();
}

class InnerLoadingWidgetState extends State<InnerLoadingWidget> {

  late bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = widget.loading;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _loading ? const CircularProgressIndicator(

      ) : null,
    );
  }

  /// 是否正在加载中
  bool isLoading() => _loading;

  /// 是否显示加载
  void setLoading(bool enable) {

    if (_loading == enable) {
      return;
    }

    setState(() {
      _loading = enable;
    });
  }
}
