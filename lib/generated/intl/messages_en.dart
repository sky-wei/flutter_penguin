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

  static String m0(value) => "Email: ${value}";

  static String m1(value) => "Source Code: ${value}";

  static String m2(value) => "Version: ${value}";

  static String m3(value) => "${value} cannot be empty!";

  static String m4(value) => "${value} seconds";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "appName": MessageLookupByLibrary.simpleMessage("LinuxDoc"),
    "backupCompression": MessageLookupByLibrary.simpleMessage(
      "Backup & Compression",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "clearData": MessageLookupByLibrary.simpleMessage("Clear Data"),
    "clearLocalAllDataTips": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to clear all local database data?",
    ),
    "cmdDescription": MessageLookupByLibrary.simpleMessage(
      "Command Description",
    ),
    "cmdList": MessageLookupByLibrary.simpleMessage("Command List"),
    "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "data": MessageLookupByLibrary.simpleMessage("Data"),
    "diskMaintenance": MessageLookupByLibrary.simpleMessage("Disk Maintenance"),
    "diskManagement": MessageLookupByLibrary.simpleMessage("Disk Management"),
    "display": MessageLookupByLibrary.simpleMessage("Display"),
    "displayRestartAppTips": MessageLookupByLibrary.simpleMessage(
      "Display zoom change requires restart to take effect!",
    ),
    "displaySize": MessageLookupByLibrary.simpleMessage("Display Zoom"),
    "emailNewsgroups": MessageLookupByLibrary.simpleMessage(
      "Email & Newsgroups",
    ),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "exitAppTips": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to close the application?",
    ),
    "exitTips": MessageLookupByLibrary.simpleMessage(
      "Press again to exit to desktop!",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favorites"),
    "featureNotYetAvailable": MessageLookupByLibrary.simpleMessage(
      "Feature not yet available!",
    ),
    "fileManagement": MessageLookupByLibrary.simpleMessage("File Management"),
    "fileTransfer": MessageLookupByLibrary.simpleMessage("File Transfer"),
    "filter": MessageLookupByLibrary.simpleMessage("Filter"),
    "followSystem": MessageLookupByLibrary.simpleMessage("Follow System"),
    "fontRestartAppTips": MessageLookupByLibrary.simpleMessage(
      "Font size change requires restart to take effect!",
    ),
    "fontSize": MessageLookupByLibrary.simpleMessage("Font Size"),
    "help": MessageLookupByLibrary.simpleMessage("Help"),
    "hint": MessageLookupByLibrary.simpleMessage("Hint"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "languageRestartAppTips": MessageLookupByLibrary.simpleMessage(
      "Language change requires restart to take effect!",
    ),
    "later": MessageLookupByLibrary.simpleMessage("Later"),
    "license": MessageLookupByLibrary.simpleMessage(
      "Copyright 2024 The sky Authors\n\nLicensed under the Apache License, Version 2.0 (the \"License\");\nyou may not use this file except in compliance with the License.\nYou may obtain a copy of the License at\n\n   http://www.apache.org/licenses/LICENSE-2.0\n\nUnless required by applicable law or agreed to in writing, software\ndistributed under the License is distributed on an \"AS IS\" BASIS,\nWITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\nSee the License for the specific language governing permissions and\nlimitations under the License.",
    ),
    "lightMode": MessageLookupByLibrary.simpleMessage("Light Mode"),
    "listEmptyTips": MessageLookupByLibrary.simpleMessage("The list is empty~"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "mailX": m0,
    "networkCommunication": MessageLookupByLibrary.simpleMessage(
      "Network Communication",
    ),
    "off": MessageLookupByLibrary.simpleMessage("Off"),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "on": MessageLookupByLibrary.simpleMessage("On"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "permissions": MessageLookupByLibrary.simpleMessage("Permissions"),
    "reboot": MessageLookupByLibrary.simpleMessage("Restart"),
    "searchCmd": MessageLookupByLibrary.simpleMessage("Search Commands"),
    "setting": MessageLookupByLibrary.simpleMessage("Settings"),
    "share": MessageLookupByLibrary.simpleMessage("Share"),
    "simplifiedChinese": MessageLookupByLibrary.simpleMessage("简体中文"),
    "sizeDefault": MessageLookupByLibrary.simpleMessage("Default"),
    "sizeExtraSmall": MessageLookupByLibrary.simpleMessage("Extra Small"),
    "sizeLarge": MessageLookupByLibrary.simpleMessage("Large"),
    "sizeMedium": MessageLookupByLibrary.simpleMessage("Medium"),
    "sizeSmall": MessageLookupByLibrary.simpleMessage("Small"),
    "sourceX": m1,
    "storage": MessageLookupByLibrary.simpleMessage("Storage"),
    "systemAdministration": MessageLookupByLibrary.simpleMessage(
      "System Administration",
    ),
    "systemConfiguration": MessageLookupByLibrary.simpleMessage(
      "System Configuration",
    ),
    "tabletMode": MessageLookupByLibrary.simpleMessage("Tablet Mode"),
    "textProcessing": MessageLookupByLibrary.simpleMessage("Text Processing"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeRestartAppTips": MessageLookupByLibrary.simpleMessage(
      "Theme change requires restart to take effect!",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "versionX": m2,
    "xNotEmpty": m3,
    "xSeconds": m4,
  };
}
