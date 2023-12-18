import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';
import 'package:intl/intl.dart';
class InsuranceService {
  final HttpProvider _httpProvider = HttpProvider();
  final String _url = HttpProvider.url;
  Future<List<Insurance>> fetchInsurances(int id) async {
    final response =
        await _httpProvider.getData('api/health-insurace-hospital/hospital/${id.toString()}');
    //print(response);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> jsonList = responseData['data'];
      //print(responseData);

      List<Insurance> InsuranceList =
          jsonList.map((json) => Insurance.fromJson(json)).toList();
      return InsuranceList;
    } else {
      throw Exception('Failed to fetch doctors');
    }
  }
}
class Insurance {
  int id;
  String name;
  String description;

  Insurance({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Insurance.fromJson(Map<String, dynamic> json) {
    return Insurance(
      id: json['id_health_insurance'],
      name: json['name'],
      description: json['description'],
    );
  }
}

