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

import 'package:flutter_penguin/core/component.dart';
import 'package:flutter_penguin/core/context.dart';
import 'package:flutter_penguin/data/source/linux_doc_repository.dart';
import 'package:flutter_penguin/data/source/linux_doc_source.dart';
import 'package:flutter_penguin/data/source/local/linux_doc_local_source.dart';
import 'package:flutter_penguin/data/source/remote/linux_doc_remote_source.dart';

abstract class XRepositoryFactory implements XComponent {

  static const String componentName = 'repositoryFactory';

  static XRepositoryFactory getRepositoryFactory(XContext context) {
    return context.getComponent(componentName);
  }

  XLinuxDocSource createLinuxDocSource();
}


class RepositoryFactory extends AbstractComponent implements XRepositoryFactory {

  final XContext context;

  RepositoryFactory(this.context);

  @override
  XLinuxDocSource createLinuxDocSource() {
    return LinuxDocRepository(
      settings: context.appSetting,
      localSource: LinuxDocLocalSource(context.dataManager),
      remoteSource: LinuxDocRemoteSource()
    );
  }
}
