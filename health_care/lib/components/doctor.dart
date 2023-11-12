import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/doctors.dart';
import 'package:health_care/screens/doctor_page.dart';

class DoctorContainer extends StatelessWidget {
  final Doctor doctor;
  const DoctorContainer({
    Key? key,
    required this.doctor,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorPage(id: doctor.id),
          ),
        );
      },
      child: Container(
        //height: 200,
        padding: EdgeInsets.all(16.0),
        width: 200,
        margin: EdgeInsets.all(8.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          doctor.avatar==''
          ? Image.asset("assets/images/doctor.jpg", width: 130.0, height: 100.0, fit: BoxFit.cover)
          : Image.network(doctor.avatar, width: 130.0, height: 100.0, fit: BoxFit.cover),
          SizedBox(height: 16.0),
          Container(
            height: 65,
            child: Text(
              doctor.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Chuyên khoa',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            doctor.department,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          )
          // Text(
          //   'Sđt: ' + doctor.phone,
          //   style: TextStyle(
          //     fontSize: 14.0,
          //   ),
          // ),
        ],
      ),
        )
    );
  }
}