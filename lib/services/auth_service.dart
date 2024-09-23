import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:donghanh_flutter/utils/constants.dart';
import 'package:donghanh_flutter/models/ResetPasswordModel.dart';

class AuthService {
  // Sign in with email and password
  Future<Map<String, dynamic>> signInWithEmailPassword(
      String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$API_IPAD/$API_LOGIN_CUSTOMER'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Username': username,
          'Password': password,
        }),
      );
      // Check for different status codes
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Parse and return response body
      } else if (response.statusCode == 400) {
        throw Exception(
            'Invalid credentials'); // Bad request, possibly invalid credentials
      } else if (response.statusCode == 500) {
        throw Exception(
            'Server error. Please try again later.'); // Internal server error
      } else {
        throw Exception(
            'Unexpected error: ${response.statusCode}'); // Other unexpected errors
      }
    } catch (e) {
      throw Exception('Failed to sign in: $e'); // Catch any other errors
    }
  }

  // Register with email and password
  Future<Map<String, dynamic>> registerWithEmailPassword(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$API_IPAD/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  // Sign out
  Future<void> signOut() async {
    // Assuming your API requires a sign-out request
    final response = await http.post(
      Uri.parse('$API_IPAD/signout'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to sign out');
    }
  }

// Change password
  Future<Map<String, dynamic>> changePass(ResetPasswordModel formModel) async {
    final response = await http.post(
      Uri.parse('$API_IPAD/$API_V1_CUSTOMER_RESET_PASS'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(formModel.toJson()), // Chuyển đổi thành chuỗi JSON
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to change password');
    }
  }
}
