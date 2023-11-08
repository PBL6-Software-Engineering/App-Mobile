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
        decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            doctor.avatar,
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16.0),
          Text(
            doctor.name,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Chuyên khoa: ' + doctor.department,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Sđt: ' + doctor.phone,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      ),
        )
    );
  }
}