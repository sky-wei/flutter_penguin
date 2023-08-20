// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static String m0(value) => "${value}不能为空！";

  static String m1(value) => "${value}秒";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("关于"),
        "appName": MessageLookupByLibrary.simpleMessage("LinuxDoc"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "darkMode": MessageLookupByLibrary.simpleMessage("暗色模式"),
        "display": MessageLookupByLibrary.simpleMessage("显示"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "followSystem": MessageLookupByLibrary.simpleMessage("跟随系统"),
        "hint": MessageLookupByLibrary.simpleMessage("提示"),
        "language": MessageLookupByLibrary.simpleMessage("语言"),
        "later": MessageLookupByLibrary.simpleMessage("稍后"),
        "lightMode": MessageLookupByLibrary.simpleMessage("亮色模式"),
        "loading": MessageLookupByLibrary.simpleMessage("加载中..."),
        "off": MessageLookupByLibrary.simpleMessage("关闭"),
        "ok": MessageLookupByLibrary.simpleMessage("确定"),
        "on": MessageLookupByLibrary.simpleMessage("启用"),
        "permissions": MessageLookupByLibrary.simpleMessage("权限"),
        "reboot": MessageLookupByLibrary.simpleMessage("重启"),
        "setting": MessageLookupByLibrary.simpleMessage("设置"),
        "simplifiedChinese": MessageLookupByLibrary.simpleMessage("简体中文"),
        "storage": MessageLookupByLibrary.simpleMessage("存储"),
        "theme": MessageLookupByLibrary.simpleMessage("主题"),
        "update": MessageLookupByLibrary.simpleMessage("更新"),
        "xNotEmpty": m0,
        "xSeconds": m1
      };
}
