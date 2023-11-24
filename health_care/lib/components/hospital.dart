import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/hospitals.dart';
import 'package:health_care/screens/hospital_page.dart';
import 'package:health_care/components/button.dart';

class HospitalContainer extends StatelessWidget {
  final Hospital hospital;
  const HospitalContainer({
    Key? key,
    required this.hospital,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HospitalPage(id: hospital.id),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(
                color: Color(0xFF0B8AA0),
                width: 8.0,
              ),
              right: BorderSide(
                color: Color(0xFF11B3CF),
                width: 2.0,
              ),
              top: BorderSide(
                color: Color(0xFF11B3CF),
                width: 2.0,
              ),
              bottom: BorderSide(
                color: Color(0xFF11B3CF),
                width: 2.0,
              ),
            ),
          ),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(8),
          //   border: Border.all(
          //     color: Colors.grey,
          //     width: 1,
          //   ),
          // ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  hospital.avatar != ''
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(hospital.avatar),
                        )
                      : 
                      CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                          'assets/images/hospital.jpg'
                        ),
                        ),
                  SizedBox(width: 8),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //width: 150,
                          child: Text(
                            hospital.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 20),
                            SizedBox(width: 4),
                            Container(
                              width:
                                  150, // Đặt kích thước cố định cho Container
                              child: Text(
                                hospital.address,
                                style: TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 20),
                            SizedBox(width: 4),
                            Text(
                              hospital.phone,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ])
                ],
              ),
              SizedBox(height: 16),
              Text(
                hospital.description,
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow
                    .ellipsis, // Hiển thị dấu "..." nếu text quá dài
                maxLines: 1,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     ElevatedButton(
              //       onPressed: () {
              //         // Xử lý khi nhấn vào nút "tư vấn"
              //       },
              //       child: Text('Tư vấn'),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         // Xử lý khi nhấn vào nút "Đặt lịch hẹn"
              //       },
              //       child: Text('Đặt lịch'),
              //     ),
              //   ],
              // ),
            ],
          ),
        ));
  }
}
