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
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_sky_library/flutter_sky_library.dart';


abstract class XEncrypt implements XComponent {

  static const String componentName = 'encryptStore';

  static XEncrypt getEncrypt(XContext context) {
    return context.getComponent(componentName);
  }

  String encodeBase64(String data);

  String decodeBase64(String data);

  String md5sum(String data);

  String encrypt(String password, String data);

  String decrypt(String password, String data);
}


class EncryptStore extends AbstractComponent implements XEncrypt {

  final _ivBytes = [89, 10, 68, 89, 20, 1, 9, 8, 9, 28, 21, 91, 10, 26, 16, 90];

  /// Base64加密
  @override
  String encodeBase64(String data){
    return base64Encode(utf8.encode(data));
  }

  /// Base64解密
  @override
  String decodeBase64(String data){
    return String.fromCharCodes(base64Decode(data));
  }

  /// md5加密
  @override
  String md5sum(String data) {
    return md5.convert(utf8.encode(data)).toString();
  }

  /// 加密数据
  @override
  String encrypt(String password, String data) {

    if (data.isEmpty) return "";

    final key = _buildKey(password);
    final iv = IV(Uint8List.fromList(_ivBytes));

    final encrypt = Encrypter(
        AES(key, mode: AESMode.cbc)
    );

    return encrypt.encrypt(data, iv: iv).base64;
  }

  /// 解密数据
  @override
  String decrypt(String password, String data) {

    if (data.isEmpty) return "";

    final key = _buildKey(password);
    final iv = IV(Uint8List.fromList(_ivBytes));

    final encrypt = Encrypter(
        AES(key, mode: AESMode.cbc)
    );

    try {
      return encrypt.decrypt64(data, iv: iv).toString();
    } catch(e) {
      XLog.d('Decrypt Error!\n$e');
    }
    return data;
  }

  /// 生成Key
  Key _buildKey(String password) {
    return Key(
      Uint8List.fromList(
        sha256.convert(utf8.encode(password)).bytes
      )
    );
  }
}

