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
import 'package:flutter_penguin/data/item/sub_menu_item.dart';
import 'package:flutter_penguin/dialog/message_dialog.dart';
import 'package:flutter_penguin/generated/l10n.dart';
import 'package:flutter_penguin/util/message_util.dart';
import 'package:flutter_penguin/util/size_box_util.dart';
import 'package:flutter_penguin/widget/list_menu_widget.dart';
import 'package:flutter_penguin/widget/sub_scaffold.dart';
import 'package:flutter_penguin/widget/sub_scroll_widget.dart';


class StoragePage extends StatefulWidget {

  final bool inline;

  const StoragePage({
    Key? key,
    this.inline = false
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SubScaffold(
      inline: widget.inline,
      title: '存储',
      body: _buildBodyContent(),
    );
  }

  /// 创建界面内容
  Widget _buildBodyContent() {
    return SubScrollWidget(
      children: [
        // ListMenuWidget(
        //   title: '导入/导出',
        //   onItemTap: _onItemEvent,
        //   menuItems: [
        //     SubMenuItem.more(id: 1, title: '导入'),
        //     SubMenuItem.more(id: 2, title: '导出'),
        //   ],
        // ),
        // XBox.vertical20,
        ListMenuWidget(
          title: '数据',
          onItemTap: _onItemEvent,
          menuItems: [
            SubMenuItem.more(id: 3, title: '清除数据'),
          ],
        )
      ],
    );
  }

  void _onItemEvent(int id) {

    switch(id) {
      case 3:
        _cleanDatabaseData();
        break;
      default:
        MessageUtil.showMessage2('功能暂未开放！');
        break;
    }
  }

  /// 清除订单数据
  Future<void> _cleanDatabaseData() async {

    final result = await showMessageDialog(
        context: context,
        title: S.of(context).hint,
        message: '您确定清除本地数据库数据！'
    );

    // if (result == 1) {
    //   cleanLocalData().then((value) {
    //     MessageUtil.showMessage2('清除数据完成！');
    //   }).onError((error, stackTrace) {
    //     MessageUtil.showMessage(context, ErrorUtil.getMessage(context, error));
    //   });
    // }
  }
}
