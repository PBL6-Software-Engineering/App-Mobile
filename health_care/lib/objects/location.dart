import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';
import 'package:intl/intl.dart';

class LocationService {
  final HttpProvider _httpProvider = HttpProvider();

  Future<List<Location>> fetchLocation(String apiUrl) async {
    try {
      final response = await _httpProvider.getData(apiUrl);
      final responseData = json.decode(response.body);
      final List<dynamic> jsonList = responseData['provinces'];
      return jsonList.map((json) => Location.fromJson(json)).toList();
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load location');
    }
  }
}

class Location {
  final int id;
  final int provinceCode;
  final String name;
  final String createdAt;
  final String updatedAt;

  Location({
    required this.id,
    required this.provinceCode,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      provinceCode: json['province_code'],
      name: json['name'],
      createdAt:
          (DateFormat('yyyy-MM-dd').format(DateTime.parse(json['created_at'])))
              .toString(),
      updatedAt:
          (DateFormat('yyyy-MM-dd').format(DateTime.parse(json['updated_at'])))
              .toString(),
    );
  }
}
