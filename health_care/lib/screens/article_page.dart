import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/objects/articles.dart';
import 'package:health_care/main_layout.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:health_care/objects/articles.dart';
import 'package:health_care/components/tag.dart';
import 'package:health_care/components/article.dart';
import 'package:health_care/screens/all_articles_page.dart';
import 'package:health_care/utils/config.dart';

class ArticlePage extends StatefulWidget {
  final Article article;

  ArticlePage({required this.article});
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  ArticleService articleService = ArticleService();
  List<Article> articles = [];
  bool loading = true;
  void initState() {
    fetchArticleList();
    super.initState();
  }

  void fetchArticleList() async {
    loading = true;
    try {
      articles = await articleService.fetchArticles(
          'api/article?name_category=${widget.article.categoryName}');

      setState(() {
        loading = false;
      });
    } catch (e) {
      print('Error fetch article: $e');
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    image: NetworkImage(widget.article
                        .thumbnail), // Thay thế 'your_image.jpg' bằng đường dẫn đến hình ảnh của bạn
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.article.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Tác giả: ' + widget.article.author,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Xuất bản: ' + widget.article.createdAt,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.visibility,
                    size: 16.0,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    widget.article.searchNumber.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Html(
                data: widget.article.content,
              ),
              SizedBox(height: 16),
              Container(
                //padding: EdgeInsets.all(16.0),
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TagContainer(tag: 'Bài viết cùng chủ đề'),
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
                          child: Text(
                            'Xem thêm >>',
                            style: TextStyle(
                              fontSize: 16,
                              color: Config.blueColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Config.spaceSmall,
                    loading
                        ? Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : articles.length != 0
                            ? 
                            //Container(
                              //  height: 450,
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: articles.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        child: ArticleContainer(
                                            article: articles[index]),
                                      );
                                    },
                                  ),
                                )
                            : Center(
                                child: Text(
                                  "Không có bài viết liên quan",
                                ),
                              ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
