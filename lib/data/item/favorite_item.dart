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

class FavoriteItem {

  final int id;
  final String key;
  final int type;

  FavoriteItem(this.id, this.key, this.type);

  factory FavoriteItem.cmd(String key) => FavoriteItem(0, key, 1);

  FavoriteItem copy({
    int? id,
    String? key,
    int? type,
  }) {
    return FavoriteItem(
      id ?? this.id,
      key ?? this.key,
      type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          key == other.key &&
          type == other.type;

  @override
  int get hashCode => id.hashCode ^ key.hashCode ^ type.hashCode;

  @override
  String toString() {
    return 'FavoriteItem{id: $id, key: $key, type: $type}';
  }
}