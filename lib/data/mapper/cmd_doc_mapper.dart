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

import 'package:flutter_penguin/data/entity/cmd_doc_entity.dart';
import 'package:flutter_penguin/data/item/cmd_doc_item.dart';

class CmdDocMapper {

  CmdDocMapper._();

  static List<CmdDocItem> transformEntities(
    List<CmdDocEntity> entities, { bool skipData = false }
  ) {
    return entities.map((e) => transformEntity(
        e, skipData: skipData
    )).toList();
  }

  static CmdDocItem transformEntity(
    CmdDocEntity entity, { bool skipData = false }
  ) {
    return CmdDocItem()
      ..id = entity.id
      ..name = entity.name
      ..categoryId = entity.categoryId
      ..data = entity.data
    ;
  }

  static List<CmdDocEntity> transformItems(List<CmdDocItem> items) {
    return items.map((e) => transformItem(e)).toList();
  }

  static CmdDocEntity transformItem(CmdDocItem item) {
    return CmdDocEntity(
      item.id,
      item.name,
      item.categoryId,
      item.data,
    );
  }
}