import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';

class SearchInput extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function() onSearch;

  SearchInput({
    required this.hintText,
    required this.controller,
    required this.onSearch,
  });

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  bool isTextEmpty = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_textListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_textListener);
    super.dispose();
  }

  void _textListener() {
    setState(() {
      isTextEmpty = widget.controller.text.isEmpty;
    });
  }

  void clearText() {
    widget.controller.clear();
  }

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
              controller: widget.controller,
              onSubmitted: (text) {
                if (!isTextEmpty) {
                  widget.onSearch();
                }
              },
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
          if (!isTextEmpty)
            IconButton(
              icon: Icon(Icons.close),
              onPressed: clearText,
            ),
        ],
      ),
    );
  }
}
