import 'package:flutter/material.dart';
import 'package:health_care/components/booking_form.dart';
import 'package:health_care/components/hospital.dart';
import 'package:health_care/objects/hospitals.dart';
import 'package:health_care/components/doctor.dart';
import 'package:health_care/objects/doctors.dart';
import 'package:health_care/components/service.dart';
import 'package:health_care/components/tag.dart';
import 'package:health_care/objects/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/utils/config.dart';
import 'dart:math';

//import 'package:health_care/screens/hospital_page.dart';
class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  bool loading = true;
  HospitalService hospitalService = HospitalService();
  DoctorService doctorService = DoctorService();
  ServiceService serviceService = ServiceService();
  List<Hospital> hospitals = [];
  List<Doctor> doctors = [];
  List<Service> services = [];
  void initState() {
    super.initState();
    fetchHospitalList();
    fetchDoctorlList();
    fetchServiceList();
  }

  void fetchHospitalList() async {
    try {
      loading = true;
      hospitals = await hospitalService.fetchHospitals();
      hospitals.sort((a, b) => b.searchNumber.compareTo(a.searchNumber));
      setState(() {
        loading = false;
      });
      //print(hospitals);
    } catch (e) {
      print('Error fetch hospitals: $e');
    }
  }

  void fetchServiceList() async {
    try {
      loading = true;
      services = await serviceService.fetchServices();
      setState(() {
        loading = false;
      });
      //print(hospitals);
    } catch (e) {
      print('Error fetch services: $e');
    }
  }

  void fetchDoctorlList() async {
    try {
      loading = true;
      doctors = await doctorService.fetchDoctors();
      doctors.sort((a, b) => b.searchNumber.compareTo(a.searchNumber));
      setState(() {
        loading = false;
      });
      //print(doctors);
    } catch (e) {
      print('Error fetch doctors: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       {
        //         Navigator.of(context).pushNamed('main');
        //       }
        //     },
        //   ),
        //   backgroundColor: Color(0xFF59D4E9),
        // ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: 5,
                    top: 50,
                    left: Config.screenWidth! * 0.05,
                    right: Config.screenWidth! * 0.05),
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('booking-search');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      width: Config.screenWidth! * 0.9,
                      decoration: BoxDecoration(
                        color: Config.primaryColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              Navigator.of(context).pushNamed('booking-search');
                            },
                          ),
                          Text(
                            'Tìm kiếm bệnh viện, bác sĩ...',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 550,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TagContainer(tag: "Top Bệnh Viện/Phòng Khám nổi bật"),
                          SizedBox(height: 8),
                          loading
                              ? Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Expanded(
                                  child: ListView.separated(
                                  itemCount: min(6, hospitals.length),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 16),
                                  itemBuilder: (context, index) {
                                    return HospitalContainer(
                                        hospital: hospitals[index]);
                                  },
                                ))
                        ]),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 380,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TagContainer(tag: "Đội Ngũ Bác Sĩ"),
                          SizedBox(height: 8),
                          // Expanded(
                          //     child: ListView.separated(
                          //     itemCount: doctors.length,
                          //     separatorBuilder: (context, index) => SizedBox(height: 16),
                          //     itemBuilder: (context, index) {
                          //       return Container(
                          //         width: 150,
                          //         child: DoctorContainer(doctor: doctors[index]));
                          //   },
                          //   )
                          // )
                          loading
                              ? Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: min(6, doctors.length),
                                    itemBuilder: (context, index) {
                                      return DoctorContainer(
                                          doctor: doctors[index]);
                                    },
                                  ),
                                )
                        ]),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 350,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TagContainer(tag: "Top dịch vụ nổi bật"),
                          SizedBox(height: 8),
                          loading
                              ? Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: min(6, services.length),
                                    itemBuilder: (context, index) {
                                      return ServiceComponent(
                                          service: services[index]);
                                    },
                                  ),
                                )
                        ]),
                  ),
                ]))));
  }
}
