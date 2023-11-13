import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
class HtmlComponent extends StatelessWidget {
  final String str;
  const HtmlComponent({
    Key? key,
    required this.str,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Html(
      data: str,
      // customRender: (node, children) {
      //       if (node is dom.Element && node.localName == 'br') {
      //         return SizedBox(height: 10);
      //       }
      //       return null;
      //     },
    );
  }
}