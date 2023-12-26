import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/timework.dart';

class TagContainer extends StatelessWidget {
  final String tag;

  TagContainer({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container( // Add padding to create space for the vertical line
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Config.blueColor,
            width: 5.0,
          ),
        ),
      ),
      child: Container(
        padding:EdgeInsets.only(left: 8),
        child: Text(
        tag,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      )
    );
  }
}
