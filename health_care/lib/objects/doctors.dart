import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';
import 'package:intl/intl.dart';
import 'package:health_care/objects/hospitals.dart';
import 'package:health_care/objects/timework.dart';
import 'package:health_care/objects/rating.dart';

class DoctorService {
  final HttpProvider _httpProvider = HttpProvider();
  final String _url = HttpProvider.url;

  Future<List<Doctor>> fetchDoctors() async {
    final response =
        await _httpProvider.getData('api/infor-hospital/all-doctor-care');
    //print(response);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> jsonList = responseData['data'];
      //print(responseData);

      List<Doctor> DoctorList =
          jsonList.map((json) => Doctor.fromJson(json)).toList();
      return DoctorList;
    } else {
      throw Exception('Failed to fetch doctors');
    }
  }
  Future<List<Doctor>> fetchDoctorsHospital(int id) async {
    final response =
        await _httpProvider.getData('api/infor-hospital/doctors-home/${id.toString()}');
    //print(response);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> jsonList = responseData['data'];
      //print(responseData);

      List<Doctor> DoctorList =
          jsonList.map((json) => Doctor.fromJson(json)).toList();
      return DoctorList;
    } else {
      throw Exception('Failed to fetch doctors');
    }
  }

  Future<DoctorDetail> fetchDoctorDetail(int id) async {
    final response = await _httpProvider
        .getData('api/infor-doctor/view-profile/${id.toString()}');
    //print(response);
    if (response != null) {
      final responseData = json.decode(response.body);
      //final List<dynamic> jsonList = responseData['data'];
      //print('api/infor-doctor/view-profile/${id.toString()}');
      print(responseData);

      DoctorDetail doctorDetail = DoctorDetail.fromJson(responseData['data']);
      //print(doctorDetail);
      return doctorDetail;
    } else {
      throw Exception('Failed to fetch doctor detail');
    }
  }
}

class Doctor {
  int id;
  String name;
  String avatar;
  String phone;
  String department;
  Doctor({
    required this.id,
    required this.name,
    required this.avatar,
    required this.phone,
    required this.department,
  });

  factory Doctor.fromJson(json) {
    final HttpProvider _httpProvider = HttpProvider();
    final String _url = HttpProvider.url;
    //List<String> infrastructureList = List<String>.from(json['infrastructure']);
    //print(json);
    return Doctor(
        id: json['id_doctor'],
        name: json['name_doctor'] ?? '',
        phone: json['phone'] ?? 'Chưa cập nhật',
        avatar: json['avatar'] != null ? _url + json['avatar'] : '',
        department: json['name_department'] ?? '');
  }
}

class DoctorDetail {
  int id;
  String email;
  String username;
  String name;
  String phone;
  String address;
  String avatar;
  int isAccept;
  String role;
  int idDoctor;
  int idDepartment;
  int idHospital;
  int isConfirm;
  int provinceCode;
  String dateOfBirth;
  int experience;
  int gender;
  int searchNumber;
  TimeWork timeWork;
  Hospitalinfor hospital;
  InforExtend inforExtend;
  Rating rating;
  Department department;
  DoctorDetail({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.phone,
    required this.address,
    required this.avatar,
    required this.isAccept,
    required this.role,
    required this.idDoctor,
    required this.idDepartment,
    required this.idHospital,
    required this.isConfirm,
    required this.provinceCode,
    required this.dateOfBirth,
    required this.experience,
    required this.gender,
    required this.searchNumber,
    required this.hospital,
    required this.timeWork,
    required this.inforExtend,
    required this.rating,
    required this.department,
  });

  factory DoctorDetail.fromJson(Map<String, dynamic> json) {
    final HttpProvider _httpProvider = HttpProvider();
    final String _url = HttpProvider.url;
    return DoctorDetail(
      id: json['id_doctor'],
      email: json['email'] ?? 'Chưa cập nhật',
      username: json['username'] ?? 'Chưa cập nhật',
      name: json['name'],
      phone: json['phone'] ?? 'Chưa cập nhật',
      address: json['address'] ?? 'Chưa cập nhật',
      avatar: json['avatar'] != null ? _url + json['avatar'] : '',
      isAccept: json['is_accept'],
      role: json['role'],
      idDoctor: json['id_doctor'],
      idDepartment: json['id_department'],
      idHospital: json['id_hospital'],
      isConfirm: json['is_confirm'],
      provinceCode: json['province_code'],
      dateOfBirth: json['date_of_birth'] != null
          ? (DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(json['date_of_birth'])))
              .toString()
          : '',
      experience: json['experience'] ?? 0,
      gender: json['gender'] ?? 1,
      searchNumber: json['search_number'],
      inforExtend: InforExtend.fromJson(json['infor_extend']),
      rating: Rating.fromJson(json['rating']),
      department: Department.fromJson(json['department']),
      hospital: Hospitalinfor.fromJson(json['infor_hospital']),
      timeWork: TimeWork.fromJson(json['time_work']),
    );
  }
}

class InforExtend {
  int id;
  int idDoctor;
  List<Prominent> prominent;
  String information;
  List<String> strengths;
  List<WorkExperience> workExperience;
  List<TrainingProcess> trainingProcess;
  List<String> language;
  List<AwardsRecognition> awardsRecognition;
  List<ResearchWork> researchWork;
  DateTime createdAt;
  DateTime updatedAt;

  InforExtend({
    required this.id,
    required this.idDoctor,
    required this.prominent,
    required this.information,
    required this.strengths,
    required this.workExperience,
    required this.trainingProcess,
    required this.language,
    required this.awardsRecognition,
    required this.researchWork,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InforExtend.fromJson(Map<String, dynamic> json) {
    var prominentList = json['prominent'] as List;
    var workExperienceList = json['work_experience'] as List;
    var trainingProcessList = json['training_process'] as List;
    var awardsRecognitionList = json['awards_recognition'] as List;
    var researchWorkList = json['research_work'] as List;

    return InforExtend(
      id: json['id'],
      idDoctor: json['id_doctor'],
      prominent: prominentList.map((e) => Prominent.fromJson(e)).toList(),
      information: json['information'],
      strengths: json['strengths'].cast<String>(),
      workExperience:
          workExperienceList.map((e) => WorkExperience.fromJson(e)).toList(),
      trainingProcess:
          trainingProcessList.map((e) => TrainingProcess.fromJson(e)).toList(),
      language: json['language'].cast<String>(),
      awardsRecognition: awardsRecognitionList
          .map((e) => AwardsRecognition.fromJson(e))
          .toList(),
      researchWork:
          researchWorkList.map((e) => ResearchWork.fromJson(e)).toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Prominent {
  String title;
  List<String> subtitle;

  Prominent({required this.title, required this.subtitle});

  factory Prominent.fromJson(Map<String, dynamic> json) {
    return Prominent(
      title: json['title'],
      subtitle: json['subtitle'].cast<String>(),
    );
  }
}

class WorkExperience {
  String title;
  List<String> subtitle;

  WorkExperience({required this.title, required this.subtitle});

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      title: json['title'],
      subtitle: json['subtitle'].cast<String>(),
    );
  }
}

class TrainingProcess {
  String title;
  List<String> subtitle;

  TrainingProcess({required this.title, required this.subtitle});

  factory TrainingProcess.fromJson(Map<String, dynamic> json) {
    return TrainingProcess(
      title: json['title'],
      subtitle: json['subtitle'].cast<String>(),
    );
  }
}

class AwardsRecognition {
  String title;
  List<String> subtitle;

  AwardsRecognition({required this.title, required this.subtitle});

  factory AwardsRecognition.fromJson(Map<String, dynamic> json) {
    return AwardsRecognition(
      title: json['title'],
      subtitle: json['subtitle'].cast<String>(),
    );
  }
}

class ResearchWork {
  String title;
  List<String> subtitle;

  ResearchWork({required this.title, required this.subtitle});

  factory ResearchWork.fromJson(Map<String, dynamic> json) {
    return ResearchWork(
      title: json['title'],
      subtitle: json['subtitle'].cast<String>(),
    );
  }
}

class Hospitalinfor {
  int id;
  String name;
  Hospitalinfor({
    required this.id,
    required this.name,
  });
  factory Hospitalinfor.fromJson(Map<String, dynamic> json) {
    return Hospitalinfor(
      id: json['id_hospital'],
      name: json['name'],
    );
  }
}

class Department {
  int id;
  String name;
  String description;
  String thumbnail;
  int searchNumber;
  DateTime createdAt;
  DateTime updatedAt;

  Department({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.searchNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      searchNumber: json['search_number'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
