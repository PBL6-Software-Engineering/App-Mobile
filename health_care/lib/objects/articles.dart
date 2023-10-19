import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/providers/http_provider.dart';

class ArticleService {
  final HttpProvider _httpProvider = HttpProvider();

  Future<List<Article>> fetchArticles() async {
    final response = await _httpProvider.getData('/article');

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
}
class Article {
  final int id;
  final String title;
  final String content;
  final String thumbnail;

  Article({required this.id, required this.title, required this.content, required this.thumbnail});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      thumbnail: json['thumbnail'],
    );
  }
}