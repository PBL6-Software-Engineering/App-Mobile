import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/objects/articles.dart';
import 'package:health_care/main_layout.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:flutter_html/flutter_html.dart';

class AllArticlePage extends StatelessWidget {
  final List<Article> articles;
  AllArticlePage({required this.articles});
  
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
          backgroundColor: Color(0xFF59D4E9)
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
      )
    );
  }
}