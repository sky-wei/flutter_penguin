

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

class SubGroupItem {

  final String? title;
  final List<SubMenuItem> menuItems;

  SubGroupItem({
    this.title,
    required this.menuItems
  });
}



enum MenuType {
  more, check, xSwitch
}

class SubMenuItem {

  final MenuType type;
  final int id;
  final String? iconName;
  final String title;
  final String? desc;
  final String? value;
  final String? moreIconName;
  final dynamic data;

  SubMenuItem({
    required this.type,
    this.id = 0,
    this.iconName,
    required this.title,
    this.desc,
    this.value,
    this.moreIconName,
    this.data
  });

  SubMenuItem.more({
    this.type = MenuType.more,
    this.id = 0,
    this.iconName,
    required this.title,
    this.desc,
    this.value,
    this.moreIconName = 'ic_arrow_right.svg',
    this.data
  });

  SubMenuItem.check({
    this.type = MenuType.check,
    this.id = 0,
    this.iconName,
    required this.title,
    this.desc,
    this.value,
    this.moreIconName = 'ic_check.svg',
    this.data
  });

  SubMenuItem.xSwitch({
    this.type = MenuType.xSwitch,
    this.id = 0,
    this.iconName,
    required this.title,
    this.desc,
    this.value,
    this.moreIconName,
    this.data
  });



  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SubMenuItem &&
              runtimeType == other.runtimeType &&
              type == other.type &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'SubMenuItem{id: $id, iconName: $iconName, title: $title, desc: $desc, value: $value, moreIconName: $moreIconName}';
  }
}