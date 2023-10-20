import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpProvider {
  // Change localhost to match the IP address of your computer
  static String url = 'http://192.168.0.154:99/';
  // static String url = 'http://192.168.3.197:99/api';

  postData(data, apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  getData(apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  Map<String, String> _setHeaders() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  }
}
