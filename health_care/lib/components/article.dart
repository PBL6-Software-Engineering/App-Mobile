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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 4,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 100,
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
                            color: Color.fromARGB(255, 1, 1, 1),
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        SizedBox(height: 8),
                        Text(
                          article.author  == '' ? 'Health Care' : article.author,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 6, 6, 6),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          article.createdAt,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 2, 2, 2),
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