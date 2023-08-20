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

import 'package:flutter_penguin/data/entity/linux_doc_entity.dart';
import 'package:flutter_penguin/data/item/linux_doc_item.dart';

class LinuxDocMapper {

  LinuxDocMapper._();

  static List<LinuxDocItem> transformEntities(
    List<LinuxDocEntity> entities, { bool skipData = false }
  ) {
    return entities.map((e) => transformEntity(
        e, skipData: skipData
    )).toList();
  }

  static LinuxDocItem transformEntity(
    LinuxDocEntity entity, { bool skipData = false }
  ) {
    return LinuxDocItem()
      ..id = entity.id
      ..name = entity.name
      ..categoryId = entity.categoryId
      ..data = entity.data
    ;
  }

  static List<LinuxDocEntity> transformItems(List<LinuxDocItem> items) {
    return items.map((e) => transformItem(e)).toList();
  }

  static LinuxDocEntity transformItem(LinuxDocItem item) {
    return LinuxDocEntity(
      item.id,
      item.name,
      item.categoryId,
      item.data
    );
  }
}