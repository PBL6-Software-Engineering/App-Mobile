import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';
import 'package:intl/intl.dart';
class ServiceService{
  final HttpProvider _httpProvider = HttpProvider();
  final String _url = HttpProvider.url;

  Future<List<Service>> fetchServices() async {
    final response = await _httpProvider.getData('api/hospital-service/all');
    //print(response);
    if (response !=null) {
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

  Future<List<Service>> fetchServicesHospital( int id) async {
    final response = await _httpProvider.getData('api/hospital-service/hospital/${id.toString()}');
    //print(response);
    if (response !=null) {
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

}
class Service {
  int id;
  String name;
  int price;
  String hospital_name;
  String thumbnail ;
  ServiceInformation infor;

  Service({
    required this.id,
    required this.name,
    required this.price,
    required this.hospital_name,
    required this.infor,
    required this.thumbnail,
  });
  factory  Service.fromJson(Map<String, dynamic> json){
  final HttpProvider _httpProvider = HttpProvider();
  final String _url = HttpProvider.url;
    return Service(
      id: json['id_hospital_service'],
      name: json['name'],
      price: json['price'],
      hospital_name: json['name_hospital'],
      infor: ServiceInformation.fromJson(json['infor']),
      thumbnail: json['thumbnail_service'] == null  ? '' : _url + json['thumbnail_service'],
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