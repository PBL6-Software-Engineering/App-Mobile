import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:health_care/components/button.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/components/review_dialog.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/screens/history_detail.dart';
import 'package:health_care/utils/api_constant.dart';
import 'package:health_care/utils/config.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final String status;
  final bool isConfirm;

  const HistoryCard({
    Key? key,
    required this.data,
    required this.status,
    required this.isConfirm,
  }) : super(key: key);

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  bool isLoading = false;
  double ratingValue = 0;

  Future<void> cancelBooking(BuildContext context) async {
    try {
      bool confirmed = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
                child: Text('Xác nhận',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
            content:
                // Center(
                //     child: Text('Bạn có chắc chắn muốn hủy lịch hẹn không?')),
                Text('Bạn có chắc chắn muốn hủy lịch hẹn không?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // User canceled
                },
                child: Text('Không'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  setState(() {
                    isLoading = true;
                  });
                },
                child: Text('Có'),
              ),
            ],
          );
        },
      );

      if (confirmed == true) {
        final response = await HttpProvider()
            .deleteData('/api/work-schedule/user-cancel/${widget.data['id']}');
        var body = json.decode(response.body);

        if (response.statusCode == 200) {
          MessageDialog.showSuccess(context, body['message']);
          Navigator.of(context).pop();
        } else {
          MessageDialog.showError(context, body['message']);
          print('Failed to cancel booking. Error: $body');
        }
      }
    } catch (e) {
      MessageDialog.showError(context, "An error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final HttpProvider _httpProvider = HttpProvider();
    final String _url = ApiConstant.linkApi;

    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.data['doctor_avatar'] != null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              _url + (widget.data['doctor_avatar'] ?? '')),
                        )
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/images/doctor.jpg'),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data['service_name'] ?? "Lịch tư vấn",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Config.primaryColor,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.data['doctor_name'] ??
                              "Đợi bệnh viện chỉ định bác sĩ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 6, 6, 6),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Config.primaryColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(
                                        widget.data['work_schedule_time']
                                                ['date'] ??
                                            '19/02/1999'),
                                  ),
                                  style: TextStyle(
                                    color: Config.primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Config.gapSmall,
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Config.primaryColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '${widget.data['work_schedule_time']?['interval'][0]} - ${widget.data['work_schedule_time']?['interval'][1]}',
                                  style: TextStyle(
                                    color: Config.primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'Địa chỉ bệnh viện:',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     Text(
                        //       widget.data['hospital_address'] ?? " None",
                        //       style: TextStyle(
                        //         fontSize: 14,
                        //         color: Color.fromARGB(255, 6, 6, 6),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        (widget.status == 'complete' && widget.isConfirm)
                            ? widget.data['rating'] == null
                                ? GestureDetector(
                                    onTap: () {
                                      showReviewDialog(
                                        context,
                                        serviceName:
                                            widget.data['service_name'] ??
                                                "Lịch tư vấn",
                                        doctorName:
                                            widget.data['doctor_name'] ??
                                                "Đang cập nhật",
                                        id_work_schedule:
                                            widget.data['work_schedule_id'],
                                      );
                                    },
                                    child: Text(
                                      'Đánh giá lịch hẹn',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: (widget.data['rating']
                                                    ?['number_rating'] ??
                                                0)
                                            .toDouble(),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
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
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget.data['rating']?['detail_rating'],
                                        style: TextStyle(),
                                      ),
                                    ],
                                  )
                            : Container(),

                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            widget.status == 'upcoming'
                                ? Expanded(
                                    child: Button(
                                      height: 40,
                                      title: isLoading ? 'Đang huỷ ...' : 'Huỷ',
                                      fontSize: 13,
                                      backgroundColor:
                                          isLoading ? Colors.grey : Colors.red,
                                      foregroundColor: Colors.white,
                                      onPressed: () {
                                        cancelBooking(context);
                                      },
                                      disable: false,
                                    ),
                                  )
                                : Container(),
                            SizedBox(width: 5),
                            Expanded(
                              child: Button(
                                height: 40,
                                title: 'Xem chi tiết',
                                fontSize: 12,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HistoryDetailPage(
                                        title: widget.data['service_name'] ??
                                            "Lịch tư vấn",
                                        htmlContent: widget
                                            .data['work_schedule_content'],
                                      ),
                                    ),
                                  );
                                },
                                disable: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
