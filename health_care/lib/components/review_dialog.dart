import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/providers/http_provider.dart';

class ReviewDialog extends StatefulWidget {
  final String serviceName;
  final String doctorName;
  final int id_work_schedule;

  ReviewDialog({
    required this.serviceName,
    required this.doctorName,
    required this.id_work_schedule,
  });

  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double ratingValue = 0;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          'Đánh giá lịch hẹn',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Tên dịch vụ: ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Config.gapSmall,
                Text(widget.serviceName, style: TextStyle(fontSize: 13)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Bác sĩ: ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Config.gapSmall,
                Text(widget.doctorName, style: TextStyle(fontSize: 12)),
              ],
            ),
            SizedBox(height: 20),
            RatingBar.builder(
              initialRating: ratingValue,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.orangeAccent,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  ratingValue = rating;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                getRatingText(ratingValue),
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: commentController,
              maxLines: null, // Allows for multiple lines
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Nhận xét của bạn về lịch khám',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Hủy'),
        ),
        TextButton(
          onPressed: () async {
            await submitReview();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Gửi đánh giá'),
        ),
      ],
    );
  }

  String getRatingText(double rating) {
    if (rating > 4.5) {
      return 'Rất tốt';
    } else if (rating >= 3.5) {
      return 'Tốt';
    } else if (rating >= 2.5) {
      return 'Bình thường';
    } else if (rating >= 1.5) {
      return 'Tệ';
    } else {
      return 'Rất tệ';
    }
  }

  Future<void> submitReview() async {
    try {
      var data = {
        "id_work_schedule": widget.id_work_schedule,
        "number_rating": ratingValue.toInt(),
        // "detail_rating": getRatingText(ratingValue),
        "detail_rating": commentController.text,

        // "comment": commentController.text,
      };

      var res = await HttpProvider().postData(data, 'api/rating/add');
      var body = json.decode(res.body);

      if (res.statusCode == 201) {
        MessageDialog.showSuccess(context, body['message']);
        Navigator.of(context).pushNamed('main');
      } else {
        MessageDialog.showError(context, body['message']);
        print('Failed to submit review. Error: $body');
      }
    } catch (error) {
      print("An error occurred: $error");
    }
  }
}

void showReviewDialog(BuildContext context,
    {required String serviceName,
    required String doctorName,
    required int id_work_schedule}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ReviewDialog(
        serviceName: serviceName,
        doctorName: doctorName,
        id_work_schedule: id_work_schedule,
      );
    },
  );
}
