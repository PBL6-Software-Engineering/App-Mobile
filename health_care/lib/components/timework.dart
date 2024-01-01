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
      child: ListView(
        
        children: [
        Wrap(
                alignment: WrapAlignment.start,
                //alignment: WrapAlignment.center,
                spacing:
                    8.0, // Khoảng cách giữa các component theo chiều ngang
                runSpacing: 16.0, // Khoảng cách giữa các hàng theo chiều dọc
                children:[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Thứ Hai: ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '• Sáng: '+(timeWork.times['monday']?.morning?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['monday']?.morning?.time[1] ?? '') + '\n'+
                 '• Chiều: '+ (timeWork.times['monday']?.afternoon?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['monday']?.afternoon?.time[1] ?? '')  + '\n' +
                  '• Tối: '+(timeWork.times['monday']?.night?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['monday']?.night?.time[1] ?? '' + '.'),
              style: TextStyle(
                fontSize: 14.0
              ),
            ),
          ]
          ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Thứ Ba: ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '• Sáng: '+(timeWork.times['tuesday']?.morning?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['tuesday']?.morning?.time[1] ?? '') + '\n'+
                 '• Chiều: '+ (timeWork.times['tuesday']?.afternoon?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['tuesday']?.afternoon?.time[1] ?? '')  + '\n' +
                  '• Tối: '+(timeWork.times['tuesday']?.night?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['tuesday']?.night?.time[1] ?? '' + '.'),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ]
          ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Thứ Tư: ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '• Sáng: '+(timeWork.times['wednesday']?.morning?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['wednesday']?.morning?.time[1] ?? '') + '\n'+
                 '• Chiều: '+ (timeWork.times['wednesday']?.afternoon?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['wednesday']?.afternoon?.time[1] ?? '')  + '\n' +
                  '• Tối: '+(timeWork.times['wednesday']?.night?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['wednesday']?.night?.time[1] ?? '' + '.'),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ]
          ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Thứ Năm: ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '• Sáng: '+(timeWork.times['thursday']?.morning?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['thursday']?.morning?.time[1] ?? '') + '\n'+
                 '• Chiều: '+ (timeWork.times['thursday']?.afternoon?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['thursday']?.afternoon?.time[1] ?? '')  + '\n' +
                  '• Tối: '+(timeWork.times['thursday']?.night?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['thursday']?.night?.time[1] ?? '' + '.'),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ]
          ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Thứ Sáu: ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '• Sáng: '+(timeWork.times['friday']?.morning?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['friday']?.morning?.time[1] ?? '') + '\n'+
                 '• Chiều: '+ (timeWork.times['friday']?.afternoon?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['friday']?.afternoon?.time[1] ?? '')  + '\n' +
                  '• Tối: '+(timeWork.times['friday']?.night?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['friday']?.night?.time[1] ?? '' + '.'),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ]
          ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Thứ Bảy: ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '• Sáng: '+(timeWork.times['saturday']?.morning?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['saturday']?.morning?.time[1] ?? '') + '\n'+
                 '• Chiều: '+ (timeWork.times['saturday']?.afternoon?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['saturday']?.afternoon?.time[1] ?? '')  + '\n' +
                  '• Tối: '+(timeWork.times['saturday']?.night?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['saturday']?.night?.time[1] ?? '' + '.'),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ]
          ),
        Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Chủ nhật: ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '• Sáng: '+(timeWork.times['sunday']?.morning?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['sunday']?.morning?.time[1] ?? '') + '\n'+
                 '• Chiều: '+ (timeWork.times['sunday']?.afternoon?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['sunday']?.afternoon?.time[1] ?? '')  + '\n' +
                  '• Tối: '+(timeWork.times['sunday']?.night?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['sunday']?.night?.time[1] ?? '' + '.'),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ]
          ),
        ]
      )
      ]
      )
    );
  }
}

class TimeSlot extends StatelessWidget {
  final TimeWork timeWork;
  final String dayofweek;

  TimeSlot({required this.timeWork, required this.dayofweek});
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Thứ Hai: ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '• Sáng: '+(timeWork.times['monday']?.morning?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['monday']?.morning?.time[1] ?? '') + '\n'+
                 '• Chiều: '+ (timeWork.times['monday']?.afternoon?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['monday']?.afternoon?.time[1] ?? '')  + '\n' +
                  '• Tối: '+(timeWork.times['monday']?.night?.time[0] ?? '') +
                  ' - ' +
                  (timeWork.times['monday']?.night?.time[1] ?? '' + '.'),
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ]
          );
}
}