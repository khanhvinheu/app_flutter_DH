import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  // Biến lưu trữ thông tin người dùng
  User? _user;

  // Lấy thông tin người dùng hiện tại
  User? get user => _user;

  // Phương thức để cập nhật thông tin người dùng
  void setUser(User newUser) {
    _user = newUser;

    // Thông báo cho các widget khác biết là dữ liệu đã thay đổi
    notifyListeners();
  }

  // Phương thức để xóa thông tin người dùng (ví dụ khi đăng xuất)
  void clearUser() {
    _user = null;
    notifyListeners();
  }
}

// Đối tượng User cơ bản
class User {
  final String email;
  final String name;

  User({
    required this.email, 
    required this.name
  });
}
