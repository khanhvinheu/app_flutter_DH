import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:donghanh_flutter/utils/constants.dart';
import 'package:donghanh_flutter/models/ResetPasswordModel.dart';

class RegionService {
  // Get data province by region code
  Future<Map<String, dynamic>> getProvinceByRegion(
      String RegionCode, String NationCode) async {
    try {
      final response = await http.get(
        Uri.parse('$API_IPAD/$API_GET_PROVINCE_ALL_LIST?RegionCode=$RegionCode&Password=$NationCode&Detail=0'),
        headers: {'Content-Type': 'application/json'},
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

  // Get data detail province by province code
  Future<Map<String, dynamic>> getDetailProvinceByCode(
      String ProvinceCode, String NationCode) async {
    try {
      final response = await http.get(
        Uri.parse('$API_IPAD/$API_GET_PROVINCE_DETAIL?ProvinceCode=$ProvinceCode&Password=$NationCode&Detail=0'),
        headers: {'Content-Type': 'application/json'},
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


}
