import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';

class SearchInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  SearchInput({required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Center(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            color: Colors.black54.withOpacity(.6),
          ),
          Config.spaceSmall,
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
