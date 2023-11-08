import 'package:flutter/material.dart';
import 'package:health_care/components/hospital.dart';
import 'package:health_care/objects/hospitals.dart';
import 'package:health_care/components/doctor.dart';
import 'package:health_care/objects/doctors.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:health_care/screens/hospital_page.dart';
class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  HospitalService hospitalService = HospitalService();
  DoctorService doctorService = DoctorService();
  List<Hospital> hospitals= [];
  List<Doctor> doctors = [];
  void initState() {
    fetchHospitalList();
    fetchDoctorlList();
    super.initState();
  }

  void fetchHospitalList() async {
    try {
      hospitals = await hospitalService.fetchHospitals();
      setState(() {});
      //print(hospitals);
    } catch (e) {
      print('Error fetch hospital: $e');
    }
  }
  void fetchDoctorlList() async {
    try {
      doctors = await doctorService.fetchDoctors();
      setState(() {});
      //print(doctors);
    } catch (e) {
      print('Error fetch doctor: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: SvgPicture.asset(
            './assets/icons/logo.svg',
            width: 30.0,
            height: 30.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
      child:Padding(
      padding: EdgeInsets.all(16),
      child: Column(
          children: [

            Container(
              height: 590,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                    'Top Bệnh Viện',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                      child: ListView.separated(
                      itemCount: hospitals.length,
                      separatorBuilder: (context, index) => SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return HospitalContainer(hospital: hospitals[index]);
                    },
                    )
                  )
               ]
            ),
            ),
            SizedBox(height: 16),
            Container(
              height: 590,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                    'Top Bác Sĩ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                      child: ListView.separated(
                      itemCount: doctors.length,
                      separatorBuilder: (context, index) => SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 150,
                          child: DoctorContainer(doctor: doctors[index]));
                    },
                    )
                  )
               ]
            ),
            )
          ]
      )
    )
    )
    );
  }
}
