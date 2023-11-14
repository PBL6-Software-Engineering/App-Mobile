import 'package:flutter/material.dart';
import 'package:health_care/components/article.dart';
import 'package:health_care/objects/articles.dart';
import 'package:http/http.dart' as http;
import 'package:health_care/components/search_form.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/utils/text.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Article> articleResults = [];
  bool isSearching = true;

  // Function to fetch search results
  ArticleService articleService = ArticleService();

  void fetchSearchArticleList() async {
    isSearching = true;

    try {
      List<Article> fetchedArticles = await articleService.fetchArticles(
        'api/article?search=${_searchController.text}',
      );
      setState(() {
        articleResults = fetchedArticles;
        isSearching = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      appBar: AppBar(
        title: SearchInput(
          hintText: AppText.enText['search_text']!,
          controller: _searchController,
          onSearch: fetchSearchArticleList,
        ),
        backgroundColor: Config.blueColor,
      ),
      body: isSearching || _searchController.text.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : articleResults.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: [
                      Text(
                        '${articleResults.length} kết quả được tìm thấy',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: articleResults.length,
                          itemBuilder: (context, index) {
                            return ArticleContainer(
                              article: articleResults[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Center(child: Text('Không tìm thấy kết quả')),
    );
  }
}
