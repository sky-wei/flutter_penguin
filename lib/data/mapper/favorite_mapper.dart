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

import 'package:flutter_penguin/data/entity/favorite_entity.dart';
import 'package:flutter_penguin/data/item/favorite_item.dart';

class FavoriteMapper {

  FavoriteMapper._();

  static List<FavoriteItem> transformEntities(List<FavoriteEntity> entities) {
    return entities.map((e) => transformEntity(e)).toList();
  }

  static FavoriteItem transformEntity(FavoriteEntity entity) {
    return FavoriteItem(
      entity.id,
      entity.key,
      entity.type
    );
  }

  static List<FavoriteEntity> transformItems(List<FavoriteItem> items) {
    return items.map((e) => transformItem(e)).toList();
  }

  static FavoriteEntity transformItem(FavoriteItem item) {
    return FavoriteEntity(
      item.id,
      item.key,
      item.type,
    );
  }
}
