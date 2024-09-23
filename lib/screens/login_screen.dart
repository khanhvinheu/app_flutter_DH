import 'package:donghanh_flutter/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donghanh_flutter/providers/ThemeProvider.dart';
import 'package:donghanh_flutter/providers/LanguageProvider.dart';
import 'package:donghanh_flutter/providers/UserProvider.dart';
import 'package:donghanh_flutter/services/auth_service.dart'; // Import your auth service
import 'package:donghanh_flutter/generated/l10n.dart';
import 'package:donghanh_flutter/utils/route_utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreen({super.key});
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Tạo key để quản lý Form
  final _formKey = GlobalKey<FormState>();
  // Khai báo biến dùng chung
  bool _isLoading = false; // State to manage loading
  bool _obscureText = true; // State to track whether the password is hidden
  // Khai báo TextEditingController để lấy giá trị từ các TextField
  final TextEditingController _emailController =
      TextEditingController(text: 'yenlinh.phan');
  final TextEditingController _passwordController =
      TextEditingController(text: 'Yenlinh@123');
  final AuthService _authService = AuthService();
  // Hàm xử lý sự kiện khi bấm nút đăng nhập
  void _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      final response =
          await _authService.signInWithEmailPassword(email, password);
      // Xác thực tài khoản
      if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Đăng nhập thành công',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.lightGreen),
        );
        final data = response['data'];
        // Khi đăng nhập thành công, cập nhật thông tin người dùng
        final user = User(
          email: data['CustomerCode'],
          name: data['UserName'],
        );
        // Gọi UserProvider để lưu thông tin người dùng
        context.read<UserProvider>().setUser(user);

        await Future.delayed(Duration(seconds: 1)); // Mock login delay
        // Điều hướng đến màn hình HomeScreen sau khi đăng nhập thành công
        await Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _isLoading = false; // Show loading indicator
        });
        // Hiển thị thông báo nếu đăng nhập không thành công
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Sai tên tài khoản hoặc mật khẩu đăng nhập!',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // Toggle the obscureText state
    });
  }

  static const BorderRadius borderRadius =
      BorderRadius.all(Radius.circular(12.0));
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final user = context.watch<UserProvider>().user;
    String titleApp = S.of(context).companion;

    return Scaffold(
      // appBar: AppBar(title: Text("Login")),
      body: Container(
        // Đặt màu nền cho body
        color: const Color(0xFF202133),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0), // Padding cho toàn bộ form
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo_App_DongHanh.png',
                    fit: BoxFit.cover,
                    width: 150, // Đặt chiều rộng của hình ảnh
                    height: 150, // Đặt chiều cao của hình ảnh
                  ),
                  const SizedBox(height: 20),
                  // Tiêu đề màn hình
                  Text(
                    S.of(context).companion,
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF31c6f2)),
                  ),
                  const SizedBox(height: 20),
                  // TextFormField nhập email
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(
                      color: Color(0xFFffffff), // Màu văn bản của TextFormField
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.account_circle,
                          color: Color(0xFFffffff)),
                      labelText: S.of(context).username,
                      labelStyle: const TextStyle(color: Color(0xFF31c6f2)),
                      border:
                          const OutlineInputBorder(borderRadius: borderRadius),
                      filled: true,
                      fillColor: const Color(0xFF0f1219),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF31c6f2),
                          width: 2,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên đăng nhập';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // TextFormField nhập mật khẩu
                  TextFormField(
                    controller: _passwordController,
                    style: const TextStyle(
                      color: Color(0xFFffffff), // Màu văn bản của TextFormField
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.key_outlined,
                          color: Color(0xFFffffff)),
                      labelText: S.of(context).password,
                      labelStyle: const TextStyle(color: Color(0xFF31c6f2)),
                      border:
                          const OutlineInputBorder(borderRadius: borderRadius),
                      filled: true,
                      fillColor: const Color(0xFF0f1219),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF31c6f2),
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed:
                            _togglePasswordVisibility, // Toggle visibility on press
                      ),
                    ),
                    obscureText:
                        _obscureText, // Controls whether the text is obscured
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      } else if (value.length < 6) {
                        return 'Mật khẩu phải có ít nhất 6 ký tự';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Nút đăng nhập
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xFF1cbadd)),
                          minimumSize: WidgetStateProperty.all<Size>(
                              const Size(double.infinity, 50)), // Chiều cao 60
                          padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(horizontal: 14)),
                        ),
                        onPressed: () => _isLoading
                            ? null
                            : _login(context), // Gọi hàm đăng nhập
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                S.of(context).login,
                                style: TextStyle(
                                    color: Color(0xFF202133), fontSize: 15),
                              )),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize
                          .min, // Đảm bảo chiều cao của form không chiếm toàn bộ màn hình
                      children: [
                        IconButton(
                          icon: ClipOval(
                            child: Image.asset(
                              'assets/flags/en.png',
                              fit: BoxFit.cover,
                              width: 25, // Đặt chiều rộng của hình ảnh
                              height: 25, // Đặt chiều cao của hình ảnh
                            ),
                          ),
                          iconSize: 20.0,
                          onPressed: () {
                            languageProvider.setLocale(Locale('en', ''));
                          },
                        ),
                        IconButton(
                          icon: ClipOval(
                            child: Image.asset(
                              'assets/flags/vn.png',
                              fit: BoxFit.fitHeight,
                              width: 25, // Đặt chiều rộng của hình ảnh
                              height: 25, // Đặt chiều cao của hình ảnh
                            ),
                          ),
                          iconSize: 20.0,
                          onPressed: () {
                            languageProvider.setLocale(Locale('vi', ''));
                          },
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize
                          .min, // Đảm bảo chiều cao của form không chiếm toàn bộ màn hình
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextButton(
                            onPressed: () {
                              // Hành động khi nhấn nút
                              Navigator.of(context).push(createRoute(RegistrationForm()));
                            },
                            child: Text(
                              S.of(context).register,
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFF1cbadd)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextButton(
                            onPressed: () {
                              // Hành động khi nhấn nút                            
                              // Navigator.of(context).push(createRoute(ForgotPasswordScreen(username: _emailController.text)));
                            },
                            child: Text(
                              S.of(context).forgotPassword,
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFFffffff)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
