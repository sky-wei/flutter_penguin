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
import 'package:flutter_penguin/data/source/linux_doc_source.dart';

class LinuxDocRemoteSource implements XLinuxDocSource {

  @override
  Future<LinuxDocItem> getDetails(int id) {
    // TODO: implement getDetails
    throw UnimplementedError();
  }

  @override
  Future<List<LinuxDocItem>> getDocList(QueryParam param) {
    // TODO: implement getDocList
    throw UnimplementedError();
  }

  @override
  Future<bool> importDoc(List<LinuxDocItem> items) {
    // TODO: implement importDoc
    throw UnimplementedError();
  }
}
