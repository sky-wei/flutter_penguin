// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(value) => "${value}不能为空！";

  static String m1(value) => "${value}Seconds";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "appName": MessageLookupByLibrary.simpleMessage("LinuxDoc"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "display": MessageLookupByLibrary.simpleMessage("Display"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "followSystem": MessageLookupByLibrary.simpleMessage("Follow System"),
        "hint": MessageLookupByLibrary.simpleMessage("Hint"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "later": MessageLookupByLibrary.simpleMessage("Later"),
        "lightMode": MessageLookupByLibrary.simpleMessage("Light Mode"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
        "off": MessageLookupByLibrary.simpleMessage("Off"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "on": MessageLookupByLibrary.simpleMessage("ON"),
        "permissions": MessageLookupByLibrary.simpleMessage("Permissions"),
        "reboot": MessageLookupByLibrary.simpleMessage("Reboot"),
        "setting": MessageLookupByLibrary.simpleMessage("Settings"),
        "simplifiedChinese": MessageLookupByLibrary.simpleMessage("简体中文"),
        "storage": MessageLookupByLibrary.simpleMessage("Storage"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "xNotEmpty": m0,
        "xSeconds": m1
      };
}
