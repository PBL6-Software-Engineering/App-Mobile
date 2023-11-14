import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/components/article.dart';
import 'package:health_care/objects/articles.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;

  CategoryPage({required this.categoryName});

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
          .fetchArticles('api/article?name_category=${widget.categoryName}');
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
                          widget.categoryName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color.fromARGB(255, 7, 8, 8),
                          ),
                        )),
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return ArticleContainer(article: articles[index]);
                        },
                      ),
                    )
                  ],
                ),
        ));
  }
}
