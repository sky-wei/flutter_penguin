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

import 'package:objectbox/objectbox.dart';

@Entity()
class CmdDocEntity {

  @Id(assignable: true)
  int id;

  String name;
  int categoryId;
  String data;

  CmdDocEntity(this.id, this.name, this.categoryId, this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CmdDocEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          categoryId == other.categoryId;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ categoryId.hashCode;

  @override
  String toString() {
    return 'CmdDocEntity{id: $id, name: $name, categoryId: $categoryId, data: $data}';
  }
}
