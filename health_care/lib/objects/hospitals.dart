import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';
import 'package:intl/intl.dart';
import 'package:health_care/objects/timework.dart';
//HospitalService hospitalService = HospitalService();
//HospitalDetail hospital = await hospitalService.fetchHospitalDetail(widget.id);

class HospitalService {
  final HttpProvider _httpProvider = HttpProvider();
  final String _url = HttpProvider.url;

  Future<List<Hospital>> fetchHospitals() async {
    final response = await _httpProvider.getData('api/infor-hospital/all-hospital');
    //print(response);
    if (response !=null) {
      final responseData = json.decode(response.body);
      final List<dynamic> jsonList = responseData['data'];
      print(responseData);

      List<Hospital> HospitalList =
          jsonList.map((json) => Hospital.fromJson(json)).toList();
      //print(HospitalList);
      return HospitalList;
    } else {
      throw Exception('Failed to fetch hospitals');
    }
  }
  Future<HospitalDetail> fetchHospitalDetail(int id) async {
    
    final response = await _httpProvider.getData('api/infor-hospital/view-profile/${id.toString()}');
    print('api/infor-hospital/view-profile/${id.toString()}');
    if (response!=null) {
      final responseData = json.decode(response.body);
      //final List<dynamic> jsonList = responseData['data'];
      //print('api/infor-doctor/view-profile/${id.toString()}');
      print(responseData);

      HospitalDetail hospitalDetail = HospitalDetail.fromJson(responseData['data']);
      print('ok');
      return hospitalDetail;
    } else {
      throw Exception('Failed to fetch hospital detail');
    }
  }
}
class Hospital {
  int id;
  String email;
  String name;
  String phone;
  String address;
  String avatar;
  int provinceCode;
  List<String> infrastructure;
  String description;
  List<int> location;
  int searchNumber;

  Hospital({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    required this.avatar,
    required this.provinceCode,
    required this.infrastructure,
    required this.description,
    required this.location,
    required this.searchNumber,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    final HttpProvider _httpProvider = HttpProvider();
    final String _url = HttpProvider.url;
    //List<String> infrastructureList = List<String>.from(json['infrastructure']);
    //print(json);
    return Hospital(
      id: json['id_hospital'],
      email: json['email'] ?? 'Chưa cập nhật',
      name: json['name'],
      phone: json['phone'] ?? 'Chưa cập nhật',
      address: json['address'] ?? 'Chưa cập nhật',
      avatar: json['avatar'] != null ? _url+json['avatar'] : '',
      provinceCode: json['province_code'],
      infrastructure: List<String>.from(json['infrastructure']),
      description: json['description'],
      location: List<int>.from(json['location']),
      searchNumber: json['search_number'],
    );
  }
}
class HospitalDetail {
  int id;
  String email;
  String name;
  String phone;
  String address;
  String avatar;
  int provinceCode;
  List<String> infrastructure;
  String description;
  List<int> location;
  int searchNumber;
  TimeWork timeWork;
  List<String> departments;

  HospitalDetail({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    required this.avatar,
    required this.provinceCode,
    required this.infrastructure,
    required this.description,
    required this.location,
    required this.searchNumber,
    required this.timeWork,
    required this.departments,
  });

  factory HospitalDetail.fromJson(Map<String, dynamic> json) {
    final HttpProvider _httpProvider = HttpProvider();
    final String _url = HttpProvider.url;
    return HospitalDetail(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      avatar: _url + json['avatar'],
      provinceCode: json['province_code'],
      infrastructure: List<String>.from(json['infrastructure']),
      description: json['description'],
      location: List<int>.from(json['location']),
      searchNumber: json['search_number'],
      timeWork: TimeWork.fromJson(json['time_work']),
      departments: List<String>.from(json['departments']),
    );
  }
}

