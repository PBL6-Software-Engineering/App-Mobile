import 'package:flutter/material.dart';
import 'package:health_care/components/article.dart';
import 'package:health_care/objects/articles.dart';

class SearchResults extends StatefulWidget {
  final List<Article>? articles;
  final bool loading;

  SearchResults({required this.articles, required this.loading});

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200, 
            child: buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget buildSearchResults() {
    if (widget.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (widget.articles == null || widget.articles!.isEmpty) {
      return Center(
        child: Text('Không tìm thấy kết quả'),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.articles!.length,
        itemBuilder: (context, index) {
          return ArticleContainer(article: widget.articles![index]);
        },
      );
    }
  }
}
