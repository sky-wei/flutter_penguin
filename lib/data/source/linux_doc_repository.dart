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

import 'package:flutter_penguin/data/item/cmd_doc_item.dart';
import 'package:flutter_penguin/data/item/favorite_item.dart';
import 'package:flutter_penguin/data/source/linux_doc_source.dart';
import 'package:flutter_sky_library/flutter_sky_library.dart';

class LinuxDocRepository implements XLinuxDocSource {

  final XSettings _settings;
  final XLinuxDocSource _localSource;
  final XLinuxDocSource _remoteSource;

  LinuxDocRepository({
    required XSettings settings,
    required XLinuxDocSource localSource,
    required XLinuxDocSource remoteSource
  }) : _settings = settings, _localSource = localSource, _remoteSource = remoteSource;

  @override
  Future<CmdDocItem> getCmdDocDetails(int id) {
    return _localSource.getCmdDocDetails(id);
    // return _settings.isOfflineMode() ? _localSource.getDetails(id) : _remoteSource.getDetails(id);
  }

  @override
  Future<List<CmdDocItem>> getCmdDocList(QueryCmdParam param) {
    return _localSource.getCmdDocList(param);
    // return _settings.isOfflineMode() ? _localSource.getDocList(param) : _remoteSource.getDocList(param);
  }

  @override
  Future<bool> importCmdDoc(List<CmdDocItem> items) {
    return _localSource.importCmdDoc(items);
    // return _settings.isOfflineMode() ? _localSource.importDoc(items) : _remoteSource.importDoc(items);
  }

  @override
  Future<List<FavoriteItem>> getFavoriteList() {
    return _localSource.getFavoriteList();
  }

  @override
  Future<FavoriteItem> addFavorite(FavoriteItem item) {
    return _localSource.addFavorite(item);
  }

  @override
  Future<FavoriteItem> removeFavorite(FavoriteItem item) {
    return _localSource.removeFavorite(item);
  }
}

