import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/objects/rating.dart';
import 'package:health_care/main_layout.dart';
import 'package:health_care/components/rating.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:flutter_html/flutter_html.dart';

class AllRatingPage extends StatefulWidget {
  final String api;
  AllRatingPage({required this.api});
  @override
  _AllRatingPageState createState() => _AllRatingPageState();
}

class _AllRatingPageState extends State<AllRatingPage> {
  Rating rating = Rating(
    countRating: 100,
    numberRating: 4,
    countDetails: RatingDetails(
      oneStar: 10,
      twoStar: 20,
      threeStar: 30,
      fourStar: 25,
      fiveStar: 15,
    ),
    ratings: [],
  );
  bool loading = true;
  RatingService ratingService = RatingService();
  @override
  void initState() {
    fetchRatingList();
    super.initState();
  }

  void fetchRatingList() async {
    loading = true;
    try {
      rating = await ratingService.fetchRating(widget.api);
      setState(() {
        loading = false;
      });
    } catch (e) {
      print('Error fetch rating: $e');
    }
  }

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
            child: loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: rating.ratings.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: RatingComponent(rating: rating.ratings[index]),
                        );
                      },
                    ),
                  )));
  }
}
