import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  Article art = Article(
      image: '',
      title: 'Article 23123',
      author: 'Quoc Tran',
      publishDate: '23/12/2012',
      content: 'hello');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Xử lý sự kiện khi nhấn nút quay về
            },
          ),
          title: Center(
            child: SvgPicture.asset(
              './assets/icons/logo.svg',
              width: 30.0,
              height: 30.0,
            ),
          )),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              art.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'By ' + art.author + '•' + art.publishDate,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  art.content,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Article {
  final String image;
  final String title;
  final String author;
  final String publishDate;
  final String content;
  Article(
      {required this.image,
      required this.title,
      required this.author,
      required this.publishDate,
      required this.content});
}
