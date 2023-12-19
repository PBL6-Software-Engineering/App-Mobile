import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/objects/categories.dart';
import 'package:health_care/components/category.dart';
import 'package:health_care/main_layout.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:flutter_html/flutter_html.dart';

class AllCategoryPage extends StatelessWidget {
  final List<Category> categories;
  AllCategoryPage({required this.categories});

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
            child: ListView(children: [
              Wrap(
                alignment: WrapAlignment.start,
                //alignment: WrapAlignment.center,
                spacing:
                    40.0, // Khoảng cách giữa các component theo chiều ngang
                runSpacing: 16.0, // Khoảng cách giữa các hàng theo chiều dọc
                children: List<Widget>.generate(categories.length, (index) {
                  return CategoryContainer(category: categories[index]);
                }),
              )
            ])));
  }
}
