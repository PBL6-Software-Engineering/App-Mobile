import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static SharedPreferences? _prefs;

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
    await _prefs?.setString('access_token', token);
  }

  static Future<void> clearToken() async {
    await _prefs?.remove('access_token');
  }
}
