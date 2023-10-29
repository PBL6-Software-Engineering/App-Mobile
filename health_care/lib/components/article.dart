import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/articles.dart';
import 'package:health_care/screens/article_page.dart';
class ArticleContainer extends StatelessWidget {
  final Article article;
  const ArticleContainer({
    Key? key,
    required this.article,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticlePage(article: article),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(article.thumbnail),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 43, 52, 179),
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          article.author,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 83, 61, 207),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          article.createdAt,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 98, 77, 214),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
    );
  }
}