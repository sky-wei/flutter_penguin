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
import 'package:flutter_penguin/generated/json/base/json_convert_content.dart';

LinuxDocItem $LinuxDocItemFromJson(Map<String, dynamic> json) {
	final LinuxDocItem linuxDocItem = LinuxDocItem();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		linuxDocItem.name = name;
	}
	final int? categoryId = jsonConvert.convert<int>(json['categoryId']);
	if (categoryId != null) {
		linuxDocItem.categoryId = categoryId;
	}
	final String? data = jsonConvert.convert<String>(json['data']);
	if (data != null) {
		linuxDocItem.data = data;
	}
	return linuxDocItem;
}

Map<String, dynamic> $LinuxDocItemToJson(LinuxDocItem entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['categoryId'] = entity.categoryId;
	data['data'] = entity.data;
	return data;
}