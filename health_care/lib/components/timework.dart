
import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/timework.dart';
class TimeWorkContainer extends StatelessWidget {
  final TimeWork timeWork;

  TimeWorkContainer({required this.timeWork});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey),
      //   borderRadius: BorderRadius.circular(8.0),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thứ Hai: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "7:30 - 11:00, 13:00 - 16:30, 18:00 - 20:00",//timeWork.times['monday']?.morning?.time[0],
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thứ Ba: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                "7:30 - 11:00, 13:00 - 16:30, 18:00 - 20:00",//timeWork.times['monday']?.morning?.time[0],
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thứ Tư: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                "7:30 - 11:00, 13:00 - 16:30, 18:00 - 20:00",//timeWork.times['monday']?.morning?.time[0],
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thứ Năm: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                "7:30 - 11:00, 13:00 - 16:30, 18:00 - 20:00",//timeWork.times['monday']?.morning?.time[0],
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thứ Sáu: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                "7:30 - 11:00, 13:00 - 16:30, 18:00 - 20:00",//timeWork.times['monday']?.morning?.time[0],
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ]
          )
        ]


        // children: [
        //   Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: timeWork.times.entries
        //         .map((entry) => Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   entry.key, // Day of the week
        //                   style: TextStyle(fontWeight: FontWeight.bold),
        //                 ),
        //                 SizedBox(height: 4.0),
        //                 TimeSlot('Morning', entry.value.morning.time),
        //                 TimeSlot('Afternoon', entry.value.afternoon.time),
        //                 TimeSlot('Night', entry.value.night.time),
        //                 SizedBox(height: 8.0),
        //               ],
        //             ))
        //         .toList(),
        //   ),
        // ],
      ),
    );
  }
}

class TimeSlot extends StatelessWidget {
  final String title;
  final List<String> times;

  TimeSlot(this.title, this.times);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: times.map((time) => Text(time)).toList(),
        ),
      ],
    );
  }
}