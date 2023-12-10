import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:health_care/utils/config.dart';

class HistoryDetailPage extends StatelessWidget {
  final String title;
  final String htmlContent;

  const HistoryDetailPage({
    Key? key,
    required this.title,
    required this.htmlContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title)),
        backgroundColor: Config.blueColor,
      ),
      body: SingleChildScrollView(
        child: Html(data: htmlContent),
      ),
    );
  }
}
