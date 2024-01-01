import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/hospitals.dart';
import 'package:health_care/screens/hospital_page.dart';
import 'package:health_care/components/button.dart';
import 'package:html/parser.dart' as htmlParser;

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
          padding: EdgeInsets.all(Config.screenWidth! * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  hospital.avatar != ''
                      ? CircleAvatar(
                          radius: Config.screenWidth! * 0.15,
                          backgroundImage: NetworkImage(hospital.avatar),
                        )
                      : CircleAvatar(
                          radius: Config.screenWidth! * 0.15,
                          backgroundImage: AssetImage('assets/images/hospital.jpg'),
                        ),
                  SizedBox(width: Config.screenWidth! * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Config.screenWidth! * 0.45,
                        child: Text(
                          
                          //'bádasdhasjkdhasjkhdjaskdhjkasdhasjdhjk',
                          hospital.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Config.screenWidth! * 0.048,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: Config.screenWidth! * 0.04),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: Config.screenWidth! * 0.04),
                          SizedBox(width: Config.screenWidth! * 0.01),
                          Container(
                            width: Config.screenWidth! * 0.3,
                            child: Text(
                              hospital.address,
                              style: TextStyle(fontSize: Config.screenWidth! * 0.032),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Config.screenWidth! * 0.02),
                      Row(
                        children: [
                          Icon(Icons.phone, size: Config.screenWidth! * 0.04),
                          SizedBox(width: Config.screenWidth! * 0.01),
                          Text(
                            hospital.phone,
                            style: TextStyle(fontSize: Config.screenWidth! * 0.032),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Config.screenWidth! * 0.04),
              Text(
                htmlParser.parse(hospital.description).body!.text.split('\n').first.trim(),
                //hospital.description,
                style: TextStyle(fontSize: Config.screenWidth! * 0.032),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ));
  }
}
