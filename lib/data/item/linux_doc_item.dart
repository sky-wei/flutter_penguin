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

import 'dart:convert';

import 'package:flutter_penguin/generated/json/base/json_field.dart';
import 'package:flutter_penguin/generated/json/linux_doc_item.g.dart';

@JsonSerializable()
class LinuxDocItem {

	@JSONField(serialize: false, deserialize: false)
	int id = 0;

	String name = '';
	int categoryId = 0;
	String data = '';

	@JSONField(serialize: false, deserialize: false)
	String category = '';

	@JSONField(serialize: false, deserialize: false)
	bool favorite = false;

	LinuxDocItem();

	factory LinuxDocItem.fromJson(Map<String, dynamic> json) => $LinuxDocItemFromJson(json);

	Map<String, dynamic> toJson() => $LinuxDocItemToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}