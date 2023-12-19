import 'package:health_care/providers/auth_manager.dart';
import 'package:health_care/utils/api_constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class UserService {
  final HttpProvider _httpProvider = HttpProvider();
  final String _url = ApiConstant.linkApi;

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

  String convertDateFormat(String inputDate) {
    // Định dạng đầu vào: dd/mm/yyyy
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');

    // Định dạng đầu ra: yyyy/mm/dd
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');

    // Chuyển đổi ngày
    DateTime date = inputFormat.parse(inputDate);
    String outputDate = outputFormat.format(date);

    return outputDate;
  }

  Future<void> uploadImage(File imageFile, User user) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://vanmanh.azurewebsites.net/api/infor-user/update'));

    final mimeTypedata =
        lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])?.split('/');
    // Tạo một MultipartFile từ File ảnh
    var stream = http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();

    var multipartFile = await http.MultipartFile.fromPath(
      'avatar', // Tên của trường dữ liệu trong request
      imageFile.path, // Stream dữ liệu file
      // Kích thước file
      contentType:
          MediaType(mimeTypedata![0], mimeTypedata[1]), // Kiểu dữ liệu của file
    );
    final token = AuthManager.getToken();
    // Thêm MultipartFile vào request
    request.files.add(multipartFile);

    request.fields['name'] = user.name;
    request.fields['phone'] = user.phone;
    request.fields['username'] = user.username;
    request.fields['email'] = user.email;
    request.fields['gender'] = user.gender.toString();
    request.fields['address'] = user.address;
    request.fields['date_of_birth'] = convertDateFormat(user.dateOfBirth);
    request.headers['Authorization'] = 'Bearer $token';
    // Gửi request và nhận phản hồi từ API
    //var response = await request.send();
    http.Response response =
        await http.Response.fromStream(await request.send());
    print(response.body);
    // Đọc phản hồi từ API
    if (response.statusCode == 200) {
      // Upload thành công
      print('Upload thành công');
    } else {
      // Upload thất bại
      print('Upload thất bại');
      // var responseString = await response.stream.bytesToString();
      // print('Thông báo từ API: $responseString');
    }
  }
}

class User {
  int id;
  String name;
  String email;
  String phone;
  int gender;
  String dateOfBirth;
  String avatar;
  String address;
  String username;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dateOfBirth,
    required this.avatar,
    required this.address,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final HttpProvider _httpProvider = HttpProvider();
    final String _url = ApiConstant.linkApi;
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'] ?? 'Chưa cập nhật',
      phone: json['phone'] ?? 'Chưa cập nhật',
      gender: json['gender'] ?? 0,
      dateOfBirth: json['date_of_birth'] == null
          ? 'Chưa cập nhật'
          : (DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(json['date_of_birth'])))
              .toString(),
      avatar: json['avatar'] != null ? _url + json['avatar'] : '',
      address: json['address'] ?? 'Chưa cập nhật',
    );
  }
}
