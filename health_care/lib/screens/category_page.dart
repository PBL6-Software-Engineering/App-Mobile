import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/components/article.dart';
import 'package:health_care/objects/articles.dart';
import 'package:health_care/objects/categories.dart';
import 'dart:math';
import 'package:health_care/utils/config.dart';
import 'package:health_care/components/Tag.dart';
import 'package:health_care/screens/all_articles_page.dart';

class CategoryPage extends StatefulWidget {
  final Category category;

  CategoryPage({required this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  ArticleService articleService = ArticleService();
  List<Article> articles = [];
  bool loading = true;
  @override
  void dispose() {
    articles = [];
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchArticleList();
  }

  void fetchArticleList() async {
    try {
      loading = true;
      List<Article> fetchedArticles = await articleService
          .fetchArticles('api/article?name_category=${widget.category.name}');
      setState(() {
        articles = fetchedArticles;
        loading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Color(0xFF59D4E9)),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.category.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color.fromARGB(255, 7, 8, 8),
                          ),
                        )),
                    SizedBox(height: 16),
                    Text(widget.category.description,
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TagContainer(tag: 'Bài viết chủ đề này'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AllArticlePage(articles: articles),
                              ),
                            );
                          },
                          child: articles.length > 3
                              ? Text(
                                  'Xem thêm >>',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Config.blueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Text(''),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    articles.length == 0
                        ? Center(
                            child:
                                Text('Chưa có bài viết nào thuộc chủ đề này'),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: min(articles.length, 3),
                              itemBuilder: (context, index) {
                                return ArticleContainer(
                                    article: articles[index]);
                              },
                            ),
                          )
                  ],
                ),
        ));
  }
}
