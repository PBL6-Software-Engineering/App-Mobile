import 'package:flutter/material.dart';
import 'package:health_care/objects/rating.dart';

class RatingComponent extends StatelessWidget {
  final RatingItem rating;

  RatingComponent({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: [
            rating.avatarUser == ''
                ? CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user.jpeg'),
                    radius: 25,
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(rating.avatarUser),
                    radius: 25.0,
                  ),
            SizedBox(width: 10.0),
            Text(rating.nameUser,
                style: TextStyle(fontSize:16.0, fontWeight: FontWeight.bold)),
          ]),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) {
              if (index < rating.numberRating) {
                return Icon(Icons.star, color: Colors.yellow);
              } else {
                return Icon(Icons.star, color: Colors.grey);
              }
            }),
          ),
          SizedBox(height: 10.0),
          Text(rating.detailRating, style: TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}
