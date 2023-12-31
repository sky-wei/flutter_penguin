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

enum SortType {
  terminal,
  favorite,
  setting,
  help,
  other,
}

class SideItem {

  final String? icon;
  final String? name;

  final SortType type;
  final dynamic data;

  SideItem({
    this.icon,
    this.name,
    this.type = SortType.other,
    this.data
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SideItem &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          name == other.name &&
          type == other.type &&
          data == other.data;

  @override
  int get hashCode =>
      icon.hashCode ^ name.hashCode ^ type.hashCode ^ data.hashCode;

  @override
  String toString() {
    return 'SideItem{icon: $icon, name: $name, type: $type, data: $data}';
  }
}