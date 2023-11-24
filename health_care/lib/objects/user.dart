
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';
import 'package:intl/intl.dart';
class UserService{
  final HttpProvider _httpProvider = HttpProvider();
  final String _url = HttpProvider.url;

  Future<User> fetchUser() async {
    final response = await _httpProvider.getData('api/infor-user/profile');
    //print(response);
    if (response != null) {
      final responseData = json.decode(response.body);
      //final List<dynamic> jsonList = responseData['data'];
      //print('api/infor-doctor/view-profile/${id.toString()}');
      //print(responseData);

      User user = User.fromJson(responseData['data']);
      //print(doctorDetail);
      return user;
    } else {
      throw Exception('Failed to fetch infor user');
    }
  }
}
class User {
  int id;
  String name;
  String email;
  String phone;
  int gender;
  String dateofbirth;
  String avatar;
  String address;
  String username;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dateofbirth,
    required this.avatar,
    required this.address,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final HttpProvider _httpProvider = HttpProvider();
    final String _url = HttpProvider.url;
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'] ?? 'Chưa cập nhật',
      phone: json['phone'] ?? 'Chưa cập nhật',
      gender: json['gender'] ?? 0,
      dateofbirth: json['date_of_birth'] == null ? 'Chưa cập nhật': (DateFormat('dd/MM/yyyy').format(DateTime.parse(json['date_of_birth']))).toString(),
      avatar: json['avatar'] != null ? _url + json['avatar'] : '',
      address: json['address'] ?? 'Chưa cập nhật',
    );
  }
}