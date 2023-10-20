import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/components/search_form.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/utils/text.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  Future<List<String>>? searchResults;

  // Future<List<String>> _search(String query) async {
  //   final response =
  //       await http.get(Uri.parse('https://api.example.com/search?q=$query'));

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     return List<String>.from(data['results']);
  //   } else {
  //     throw Exception('Failed to load search results');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      appBar: AppBar(
        title: SearchInput(
          hintText: AppText.enText['search_text']!,
          controller: _searchController,
          // onSubmitted: (query) {
          //   setState(() {
          //     searchResults = _search(query);
          //   });
          // },
        ),
        backgroundColor: Config.blueColor,
      ),
      body: searchResults != null
          ? FutureBuilder<List<String>>(
              future: searchResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final results = snapshot.data!;
                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(results[index]),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return Center(child: CircularProgressIndicator());
              },
            )
          : Center(child: Text('Không tìm thấy kết quả')),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SearchPage(),
  ));
}
