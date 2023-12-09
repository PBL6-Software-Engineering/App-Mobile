import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';

class CategoryService {
  final HttpProvider _httpProvider = HttpProvider();

  Future<List<Category>> fetchCategories() async {
    final response = await _httpProvider.getData('api/category');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> jsonList = responseData['data'];

      List<Category> categoryList =
          jsonList.map((json) => Category.fromJson(json)).toList();

      return categoryList;
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}

class Category {
  int id;
  String name;
  String thumbnail;
  int searchNumber;
  String description;
  //DateTime createdAt;
  //DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.searchNumber,
    required this.description
    //required this.createdAt,
    //required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    final HttpProvider _httpProvider = HttpProvider();
    final String _url = HttpProvider.url;
    return Category(
      id: json['id'],
      name: json['name'],
      thumbnail: _url+json['thumbnail'],
      searchNumber: json['search_number'],
      description: json['description_category'],
      //createdAt: DateTime.parse(json['created_at']),
      //updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
