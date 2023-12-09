import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/categories.dart';
import 'package:health_care/screens/category_page.dart';

class CategoryContainer extends StatelessWidget {
  final Category category;
  const CategoryContainer({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CategoryPage(category: category),
            ),
          );
        },
        child: Container(
          width: 150,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    image: NetworkImage(category.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  height: 65,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      category.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) =>
              //             CategoryPage(categoryName: category.name),
              //       ),
              //     );
              //   },
              //   child: Text('Xem chi tiết'),
              // ),
            ],
          ),
        ));
  }
}
