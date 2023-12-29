import 'package:health_care/utils/api_constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';
import 'package:intl/intl.dart';
import 'package:health_care/objects/rating.dart';

class ServiceService {
  final HttpProvider _httpProvider = HttpProvider();
  final String _url = ApiConstant.linkApi;

  Future<List<Service>> fetchServices() async {
    final response = await _httpProvider.getData('api/hospital-service/all');
    //print(response);
    if (response != null) {
      final responseData = json.decode(response.body);
      final List<dynamic> jsonList = responseData['data'];
      //print(responseData);

      List<Service> ServiceList =
          jsonList.map((json) => Service.fromJson(json)).toList();
      //print(HospitalList);
      return ServiceList;
    } else {
      throw Exception('Failed to fetch hospitals');
    }
  }

  Future<List<Service>> fetchServicesHospital(int id) async {
    final response = await _httpProvider
        .getData('api/hospital-service/hospital/${id.toString()}');
    //print(response);
    if (response != null) {
      final responseData = json.decode(response.body);
      final List<dynamic> jsonList = responseData['data'];
      //print(responseData);

      List<Service> ServiceList =
          jsonList.map((json) => Service.fromJson(json)).toList();
      //print(HospitalList);
      return ServiceList;
    } else {
      throw Exception('Failed to fetch hospitals');
    }
  }

  Future<ServiceRating> fetchServiceRating(int id) async {
    final response = await _httpProvider
        .getData('api/hospital-service/detail/${id.toString()}');
    //print(response);
    if (response != null) {
      final responseData = json.decode(response.body);
      //final List<dynamic> jsonList = responseData['data'];
      //print('api/infor-doctor/view-profile/${id.toString()}');
      print(responseData);

      ServiceRating rating = ServiceRating.fromJson(responseData['data']);
      //print(doctorDetail);
      return rating;
    } else {
      throw Exception('Failed to fetch doctor detail');
    }
  }
}

class Service {
  int id;
  String name;
  String price;
  String hospital_name;
  String thumbnail;
  ServiceInformation infor;
  int searchNumber;

  Service({
    required this.id,
    required this.name,
    required this.price,
    required this.hospital_name,
    required this.infor,
    required this.thumbnail,
    required this.searchNumber,
  });
  factory Service.fromJson(Map<String, dynamic> json) {
    final HttpProvider _httpProvider = HttpProvider();
    final String _url = ApiConstant.linkApi;
    return Service(
      id: json['id_hospital_service'],
      name: json['name'],
      price: json['price'] != null ? NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(json['price']) : 'Chưa cập nhật',
      hospital_name: json['name_hospital'],
      infor: ServiceInformation.fromJson(json['infor']),
      thumbnail: json['thumbnail_service'] == null
          ? ''
          : _url + json['thumbnail_service'],
      searchNumber: json['search_number_service'],
    );
  }
}

class ServiceInformation {
  List<int> location;
  String aboutService;
  String prepareProcess;
  String serviceDetails;

  ServiceInformation({
    required this.location,
    required this.aboutService,
    required this.prepareProcess,
    required this.serviceDetails,
  });

  factory ServiceInformation.fromJson(Map<String, dynamic> json) {
    return ServiceInformation(
      location: List<int>.from(json['location']),
      aboutService: json['about_service'],
      prepareProcess: json['prepare_process'],
      serviceDetails: json['service_details'],
    );
  }
}

class ServiceRating {
  int id;
  int countRating;
  double numberRating;
  RatingDetails countDetails;
  List<RatingItem> ratings;
  ServiceRating({
    required this.id,
    required this.countRating,
    required this.numberRating,
    required this.countDetails,
    required this.ratings,
  });

  factory ServiceRating.fromJson(Map<String, dynamic> json) {
    var ratingsList = json['ratings']['data'] as List;
    return ServiceRating(
      id: json['id_hospital_service'],
      countRating: json['cout_rating'],
      numberRating: json['number_rating'].toDouble(),
      countDetails: RatingDetails.fromJson(json['cout_details']),
      ratings: ratingsList.map((e) => RatingItem.fromJson(e)).toList() ?? [],
    );
  }
}
