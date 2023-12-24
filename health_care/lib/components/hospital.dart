// import 'package:flutter/material.dart';
// import 'package:health_care/utils/config.dart';
// import 'package:health_care/objects/hospitals.dart';
// import 'package:health_care/screens/hospital_page.dart';
// import 'package:health_care/components/button.dart';

// class HospitalContainer extends StatelessWidget {
//   final Hospital hospital;
//   const HospitalContainer({
//     Key? key,
//     required this.hospital,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HospitalPage(id: hospital.id),
//             ),
//           );
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//              border: Border.all(
//                color: Colors.blue,
//                width: 4,
//              ),
//             borderRadius: BorderRadius.circular(10.0),
            
//           ),
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   hospital.avatar != ''
//                       ? CircleAvatar(
//                           radius: 60,
//                           backgroundImage: NetworkImage(hospital.avatar),
//                         )
//                       : 
//                       CircleAvatar(
//                           radius: 60,
//                           backgroundImage: AssetImage(
//                           'assets/images/hospital.jpg'
//                         ),
//                         ),
//                   SizedBox(width: 8),
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           //width: 150,
//                         width: Config.screenWidth!*0.3,
//                           child: Text(
//                             hospital.name,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         Row(
//                           children: [
//                             Icon(Icons.location_on, size: 20),
//                             SizedBox(width: 4),
//                             Container(
//                               width:
//                                   150, // Đặt kích thước cố định cho Container
//                               child: Text(
//                                 hospital.address,
//                                 style: TextStyle(fontSize: 16),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Icon(Icons.phone, size: 20),
//                             SizedBox(width: 4),
//                             Text(
//                               hospital.phone,
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ],
//                         ),
//                       ])
//                 ],
//               ),
//               SizedBox(height: 16),
//               Text(
//                 hospital.description,
//                 style: TextStyle(fontSize: 16),
//                 overflow: TextOverflow
//                     .ellipsis, // Hiển thị dấu "..." nếu text quá dài
//                 maxLines: 1,
//               ),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //   children: [
//               //     ElevatedButton(
//               //       onPressed: () {
//               //         // Xử lý khi nhấn vào nút "tư vấn"
//               //       },
//               //       child: Text('Tư vấn'),
//               //     ),
//               //     ElevatedButton(
//               //       onPressed: () {
//               //         // Xử lý khi nhấn vào nút "Đặt lịch hẹn"
//               //       },
//               //       child: Text('Đặt lịch'),
//               //     ),
//               //   ],
//               // ),
//             ],
//           ),
//         ));
//   }
// }
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
            border: Border.all(
              color: Colors.blue,
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  hospital.avatar != ''
                      ? CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.2,
                          backgroundImage: NetworkImage(hospital.avatar),
                        )
                      : CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.2,
                          backgroundImage: AssetImage('assets/images/hospital.jpg'),
                        ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          hospital.name,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.048,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: MediaQuery.of(context).size.width * 0.04),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              hospital.address,
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.032),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                      Row(
                        children: [
                          Icon(Icons.phone, size: MediaQuery.of(context).size.width * 0.04),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          Text(
                            hospital.phone,
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.032),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.04),
              Text(
                hospital.description,
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.032),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ));
  }
}
