import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';
import 'package:intl/intl.dart';
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
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      avatar: _url+json['avatar'],
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

class TimeWork {
  int id;
  int idHospital;
  Map<String, DayTime> times;
  int enable;
  String note;

  TimeWork({
    required this.id,
    required this.idHospital,
    required this.times,
    required this.enable,
    required this.note,
  });

  factory TimeWork.fromJson(Map<String, dynamic> json) {
    return TimeWork(
      id: json['id'],
      idHospital: json['id_hospital'],
      times: Map<String, DayTime>.from(json['times'].map((k, v) => MapEntry(k, DayTime.fromJson(v)))),
      enable: json['enable'],
      note: json['note'] ?? '',
    );
  }
}

class DayTime {
  final TimeRange night;
  final bool enable;
  final TimeRange morning;
  final TimeRange afternoon;

  DayTime({
    required this.night,
    required this.enable,
    required this.morning,
    required this.afternoon,
  });

  factory DayTime.fromJson(Map<String, dynamic> json) {
    return DayTime(
      night: TimeRange.fromJson(json['night']),
      enable: json['enable'],
      morning: TimeRange.fromJson(json['morning']),
      afternoon: TimeRange.fromJson(json['afternoon']),
    );
  }
}

class TimeRange {
  final List<String> time;
  final bool enable;

  TimeRange({
    required this.time,
    required this.enable,
  });

  factory TimeRange.fromJson(Map<String, dynamic> json) {
    return TimeRange(
      time: List<String>.from(json['time']),
      enable: json['enable'],
    );
  }
}