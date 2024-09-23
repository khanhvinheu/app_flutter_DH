class ResetPasswordModel {
  String username;
  String password;
  String oldpassword;

  ResetPasswordModel({
    required this.username,
    required this.password,
    required this.oldpassword,
  });

  // Thêm phương thức toJson
  Map<String, dynamic> toJson() {
    return {
      'UserName': username,
      'Password': password,
      'OldPassword': oldpassword,
    };
  }
}
