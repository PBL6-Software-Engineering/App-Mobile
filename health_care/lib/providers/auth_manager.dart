import 'dart:convert';

import 'package:health_care/objects/user.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/utils/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static SharedPreferences? _prefs;
  static HttpProvider _httpProvider = HttpProvider();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool isAuthenticated() {
    return _prefs?.getString('access_token') != null;
  }

  static String? getToken() {
    return _prefs?.getString('access_token');
  }

  static Future<void> setToken(String token) async {
    print('Tokendd: $token');

    await _prefs?.setString('access_token', token);
  }

  static Future<void> clearToken() async {
    await _prefs?.remove('access_token');
  }

  static Future<User> fetchUser() async {
    try {
      // Check if the user is authenticated
      if (!isAuthenticated()) {
        throw Exception('User is not authenticated');
      }

      // Make an API call using the access token
      final response = await _httpProvider.getData('api/infor-user/profile');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        User user = User.fromJson(responseData['data']);
        return user;
      } else {
        throw Exception('Failed to fetch user information');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
