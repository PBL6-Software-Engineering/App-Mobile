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
            border: Border.all(
              color: Colors.blue,
              width: Config.screenWidth! * 0.01,
            ),
            boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              doctor.avatar != ''
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(doctor.avatar),
                    )
                  : CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/doctor.jpg'),
                    ),
              SizedBox(height: 16.0),
              Center(
                child: Container(
                  height: 65,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      doctor.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
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
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
              // Text(
              //   'Sđt: ' + doctor.phone,
              //   style: TextStyle(
              //     fontSize: 14.0,
              //   ),
              // ),
            ],
          ),
        ));
  }
}
