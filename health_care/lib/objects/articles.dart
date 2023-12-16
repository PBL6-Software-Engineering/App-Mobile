import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';
import 'package:intl/intl.dart';

class ArticleService {
  final HttpProvider _httpProvider = HttpProvider();
  final String _url = HttpProvider.url;

  Future<List<Article>> fetchArticles(String apiUrl) async {
    // final response = await _httpProvider.getData('api/article');
    final response = await _httpProvider.getData(apiUrl);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> jsonList = responseData['data'];

      List<Article> articleList =
          jsonList.map((json) => Article.fromJson(json)).toList();

      return articleList;
    } else {
      throw Exception('Failed to fetch articles');
    }
  }
  // Future<List<Article>> fetchArticlesByCategory(String name) async {
  //   //print('api/article?name_category="${name}"');
  //   final response = await _httpProvider.getData('api/article?name_category=${name}');
  //   if (response.statusCode == 200) {
  //     final responseData = json.decode(response.body);
  //     final List<dynamic> jsonList = responseData['data'];

  //     List<Article> articleList =
  //         jsonList.map((json) => Article.fromJson(json)).toList();

  //     return articleList;
  //   } else {
  //     throw Exception('Failed to fetch articles');
  //   }
  // }
}

class Article {
  String _url = HttpProvider.url;
  int id;
  String title;
  String content;
  String thumbnail;
  String author;
  String createdAt;
  int searchNumber;
  String categoryName;
  Article(
      {required this.id,
      required this.title,
      required this.content,
      required this.thumbnail,
      required this.author,
      required this.createdAt,
      required this.searchNumber,
      required this.categoryName});


  factory Article.fromJson(Map<String, dynamic> json) {
    final HttpProvider _httpProvider = HttpProvider();
    final String _url = HttpProvider.url;
    return Article(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      thumbnail: _url + json['thumbnail_article'],
      author: json['name_user'] ?? '',
      searchNumber: json['search_number'],
      createdAt:
          (DateFormat('dd/MM/yyyy').format(DateTime.parse(json['created_at'])))
              .toString(),
      categoryName: json['name_category'],
              
    );
  }
}
