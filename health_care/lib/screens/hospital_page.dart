import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/objects/hospitals.dart';
import 'package:health_care/objects/timework.dart';
import 'package:health_care/components/timework.dart';
import 'package:health_care/components/doctor.dart';
import 'package:health_care/objects/doctors.dart';

class HospitalPage extends StatefulWidget {
  final int id;
  const HospitalPage({
    required this.id,
  });

  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage>
    with SingleTickerProviderStateMixin {
  HospitalService hospitalService = HospitalService();
  DoctorService doctorService = DoctorService();
  bool loading = true;
  bool loadingdoctors = true;
  List<Doctor> doctors = [];
  HospitalDetail hospital = HospitalDetail(
    id: 1,
    email: "",
    name: "",
    phone: "",
    address: "",
    avatar: "",
    provinceCode: 42,
    infrastructure: [],
    description: "",
    location: [],
    searchNumber: 0,
    timeWork: TimeWork(
      id: 1,
      idHospital: 1,
      times: {},
      enable: 1,
      note: "",
    ),
    departments: [],
    cover_image: '',
  );

  void initState() {
    fetchHospital();
    fetchDoctorsHospital();
    super.initState();
  }

  void fetchHospital() async {
    try {
      loadingdoctors = true;
      hospital = await hospitalService.fetchHospitalDetail(widget.id);
      //print(hospital);
      setState(() {
        loadingdoctors = false;
      });
    } catch (e) {
      print('Error fetch Hospital at page: $e');
    }
  }

  void fetchDoctorsHospital() async {
    try {
      loading = true;
      doctors = await doctorService.fetchDoctorsHospital(widget.id);
      setState(() {
        loading = false;
      });
    } catch (e) {
      print('Error fetch doctors hospital: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xFF59D4E9)),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Container chứa ảnh và thông tin bác sĩ
                  Container(
                      height: 270,
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(hospital.cover_image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 140,
                            left: 16,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                hospital.avatar,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 210,
                            left: 140,
                            child: Text(
                              hospital.name,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 6, 5, 5),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow
                                  .ellipsis, // Hiển thị dấu "..." nếu text quá dài
                              maxLines: 1,
                            ),
                          ),
                        ],
                      )),
                  //SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 16, left: 16, right: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 24.0,
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 100,
                          ),
                          child: Text(
                            hospital.address,
                            style: TextStyle(fontSize: 18.0),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(16.0),
                    height: 400,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Đội ngũ bác sĩ',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: loadingdoctors == true
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: doctors.length,
                                    itemBuilder: (context, index) {
                                      return DoctorContainer(
                                          doctor: doctors[index]);
                                    },
                                  ),
                          )
                        ]),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(16.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Thời gian làm việc:',
                  //         style: TextStyle(
                  //           fontSize: 20.0,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       SizedBox(height: 8.0),
                  //       TimeWorkContainer(
                  //         timeWork: hospitaldetail.timeWork, // Replace with your actual TimeWork object
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    height: 300,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chuyên khoa',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Expanded(
                            child: ListView.builder(
                          itemCount: hospital.departments.length,
                          //separatorBuilder: (context, index) => SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            return Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text(
                                    '- ' + hospital.departments[index],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]));
                          },
                        ))
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cơ sở vật chất',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Expanded(
                            child: ListView.builder(
                          itemCount: hospital.infrastructure.length,
                          itemBuilder: (context, index) {
                            return Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text(
                                    '- ' + hospital.infrastructure[index],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]));
                          },
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
