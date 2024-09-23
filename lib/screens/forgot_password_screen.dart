import 'package:flutter/material.dart';
import 'package:donghanh_flutter/widgets/CustomTextField.dart';
import 'package:donghanh_flutter/widgets/CustomPasswordField.dart';
import 'package:donghanh_flutter/widgets/FormLayout.dart';
import 'package:donghanh_flutter/models/ResetPasswordModel.dart';
import 'package:donghanh_flutter/services/auth_service.dart'; // Import your auth service


class ForgotPasswordScreen extends StatefulWidget {
  final String username; // Thêm thuộc tính username
  // Nhận dữ liệu qua constructor
  ForgotPasswordScreen({required this.username});  
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {    
  final _formKey = GlobalKey<FormState>();  
  final AuthService _authService = AuthService();
  final ResetPasswordModel _formModel = ResetPasswordModel(
    username: '',
    password: '',
    oldpassword: '',   
  );
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: FormLayout(
      title: 'Đổi mật khẩu', // Title of the form
      groupTitle: 'THÔNG TIN CẬP NHẬT',
      // Define form fields (e.g., TextFormFields, Dropdowns)
      formFields: [       
        // Password Field
        CustomPasswordField(
          label: 'Nhập mật khẩu cũ',
          defaultShowHide: false,
          onSaved: (value) {
            _formModel.oldpassword = value!;
          },
          validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mật khẩu cũ không được để trống';
              }
              return null; // Trả về null nếu hợp lệ
          },
          
        ),

        // New Password Field
        CustomPasswordField(
          label: 'Nhập mật khẩu mới', 
          defaultShowHide: false,
          onSaved: (value) {
            _formModel.password = value!;
          },
          onChanged: (value) {
            _formModel.password = value!;
          },
          validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mật khẩu mới không được để trống';
              }
              // Regex để kiểm tra mật khẩu
              String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
              RegExp regex = RegExp(pattern);
              
              if (!regex.hasMatch(value)) {
                return 'Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.';
              }   
              return null; // Trả về null nếu hợp lệ
          },
        ),

        // Re New Password Field
        CustomPasswordField(
            label: 'Nhập lại mật khẩu mới',
            defaultShowHide: false,           
            validator: (value) {
              if (value !=  _formModel.password) {
                return 'Mật khẩu không khớp';
              }              
              return null; // Trả về null nếu hợp lệ
            },
        ),

        // You can add more fields like dropdowns for "Tỉnh/Thành phố" etc.
      ],

      // Define the action button (e.g., 'Register' button)
      actionButton: ElevatedButton(
        onPressed: () {
          // Handle form submission
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            _submitForm();
          }
        },
        child: _isLoading
          ? CircularProgressIndicator(color: Colors.white)
          : const Text('ĐỔI MẬT KHẨU', style: TextStyle(fontSize: 15, color: Colors.white)),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            backgroundColor: Colors.lightBlue // Set full width and height
        ),
      ),
    ));
  }
  void _submitForm() async{
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    _formModel.username = widget.username;
    final response = await _authService.changePass(_formModel);
     if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Đổi mật khẩu thành công',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.lightGreen),
        );     
        setState(() {
          _isLoading = false; // Show loading indicator
        });
        await Navigator.pushReplacementNamed(context, '/');  
      } else {
        setState(() {
          _isLoading = false; // Show loading indicator
        });
        final error = response['error'];
        print(error);
        // Hiển thị thông báo nếu đăng nhập không thành công
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Đổi mật khẩu thất bại!',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red),
        );
      }
  }
}

void main() {
  runApp(MaterialApp(home: ForgotPasswordScreen(username: '')));
}
