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

import 'package:flutter_penguin/data/item/linux_doc_item.dart';

abstract class XLinuxDocSource {

  /// 导入文档
  Future<bool> importDoc(List<LinuxDocItem> items);

  /// 获取文档列表(没有data字段数据)
  Future<List<LinuxDocItem>> getDocList(QueryParam param);

  /// 获取文档详情数据
  Future<LinuxDocItem> getDetails(int id);
}

class QueryParam {

  String keyword = '';
  int category = -1;
  bool favorite = false;
  int page = 0;
  int pageSize = 20;

  @override
  String toString() {
    return 'QueryParam{keyword: $keyword, category: $category, favorite: $favorite, page: $page, pageSize: $pageSize}';
  }
}

