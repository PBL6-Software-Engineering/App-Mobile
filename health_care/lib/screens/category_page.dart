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
      List<Article> fetchedArticles = await articleService
          .fetchArticles('api/article?name_category=${widget.categoryName}');
      setState(() {
        articles = fetchedArticles;
      });
      print(articles);
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
        title: Center(
          child: SvgPicture.asset(
            './assets/icons/logo.svg',
            width: 30.0,
            height: 30.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.categoryName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
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
    );
  }
}
