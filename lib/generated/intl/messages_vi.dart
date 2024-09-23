// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  static String m0(name) => "Xin chào ${name}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account": MessageLookupByLibrary.simpleMessage("Tài khoản"),
        "companion": MessageLookupByLibrary.simpleMessage("ĐỒNG HÀNH"),
        "email": MessageLookupByLibrary.simpleMessage("email"),
        "english": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
        "forgotPassword": MessageLookupByLibrary.simpleMessage("Quên mật khẩu"),
        "greeting": m0,
        "home": MessageLookupByLibrary.simpleMessage("Trang chủ"),
        "lang": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
        "login": MessageLookupByLibrary.simpleMessage("ĐĂNG NHẬP"),
        "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
        "nonetwork":
            MessageLookupByLibrary.simpleMessage("Không có kết nối mạng!"),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "passwordResetRequest":
            MessageLookupByLibrary.simpleMessage("Password reset request"),
        "register": MessageLookupByLibrary.simpleMessage("Đăng ký mới"),
        "register_account":
            MessageLookupByLibrary.simpleMessage("Đăng ký tài khoản"),
        "sendResetLink":
            MessageLookupByLibrary.simpleMessage("Send reset link"),
        "setting": MessageLookupByLibrary.simpleMessage("Cài đặt"),
        "theme": MessageLookupByLibrary.simpleMessage("Giao diện"),
        "thongtinvungtrong":
            MessageLookupByLibrary.simpleMessage("Thông tin vùng trồng"),
        "username": MessageLookupByLibrary.simpleMessage("Tên đăng nhập"),
        "vietnam": MessageLookupByLibrary.simpleMessage("Việt Nam"),
        "wellcometoapp":
            MessageLookupByLibrary.simpleMessage("Welcome to COMPANY")
      };
}
