import 'dart:convert';
import 'package:health_care/providers/auth_manager.dart';
import 'package:health_care/utils/api_constant.dart';
import 'package:http/http.dart' as http;

class HttpProvider {
  // static String url = 'https://vanmanh.azurewebsites.net/';

  // // static String url = 'http://192.168.11.250:8000/';

  Future<http.Response> postData(data, apiUrl) async {
    var fullUrl = ApiConstant.linkApi + apiUrl;
    Map<String, String> headers = _setHeaders();

    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: headers,
    );
  }

  Future<http.Response> getData(apiUrl) async {
    var fullUrl = ApiConstant.linkApi + apiUrl;
    Map<String, String> headers = _setHeaders();

    return await http.get(
      Uri.parse(fullUrl),
      headers: headers,
    );
  }

  Future<http.Response> getMessageData(fullUrl) async {
    Map<String, String> headers = _setHeaders();

    return await http.get(
      Uri.parse(fullUrl),
      headers: headers,
    );
  }

  Future<http.Response> deleteData(apiUrl) async {
    var fullUrl = ApiConstant.linkApi + apiUrl;
    Map<String, String> headers = _setHeaders();

    return await http.delete(
      Uri.parse(fullUrl),
      headers: headers,
    );
  }

  Map<String, String> _setHeaders() {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final token = AuthManager.getToken();
    print('Token header: $token');

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }
}
