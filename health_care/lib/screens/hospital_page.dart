import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/objects/hospitals.dart';
import 'package:health_care/objects/timework.dart';
import 'package:health_care/components/timework.dart';
import 'package:health_care/components/doctor.dart';
import 'package:health_care/components/service.dart';
import 'package:health_care/components/timework.dart';
import 'package:health_care/objects/doctors.dart';
import 'package:health_care/objects/services.dart';

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
  ServiceService serviceService = ServiceService();
  DoctorService doctorService = DoctorService();
  bool loading = true;
  bool loadingdoctors = true;
  bool loadingservices = true;
  bool isExpanded1 = false;
  bool isExpanded2 = false;
  List<Doctor> doctors = [];
  List<Service> services = [];
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
    fetchServicesHospital();
    super.initState();
  }

  void fetchHospital() async {
    try {
      loading = true;
      hospital = await hospitalService.fetchHospitalDetail(widget.id);
      //print(hospital);
      setState(() {
        loading = false;
      });
    } catch (e) {
      print('Error fetch Hospital Detail: $e');
    }
  }

  void fetchDoctorsHospital() async {
    try {
      loadingdoctors = true;
      doctors = await doctorService.fetchDoctorsHospital(widget.id);
      print(doctors.length);
      setState(() {
        loadingdoctors = false;
      });
    } catch (e) {
      print('Error fetch doctors hospital: $e');
    }
  }

  void fetchServicesHospital() async {
    try {
      loadingservices = true;
      services = await serviceService.fetchServicesHospital(widget.id);
      print(doctors.length);
      setState(() {
        loadingservices = false;
      });
    } catch (e) {
      print('Error fetch servcice hospital: $e');
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  size: 24.0,
                                ),
                                SizedBox(width: 8.0),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 100,
                                  ),
                                  child: Text(
                                    hospital.address,
                                    style: TextStyle(fontSize: 18.0),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 24.0,
                                ),
                                SizedBox(width: 8.0),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 100,
                                  ),
                                  child: Text(
                                    hospital.email,
                                    style: TextStyle(fontSize: 18.0),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 24.0,
                                ),
                                SizedBox(width: 8.0),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 100,
                                  ),
                                  child: Text(
                                    hospital.phone,
                                    style: TextStyle(fontSize: 18.0),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ])),
                  Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Đội ngũ bác sĩ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16),
                            loadingdoctors == true
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : doctors.length != 0
                                    ? Container(
                                        padding: EdgeInsets.all(16.0),
                                        height: 360,
                                        child: Expanded(
                                            child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: doctors.length,
                                          itemBuilder: (context, index) {
                                            return DoctorContainer(
                                                doctor: doctors[index]);
                                          },
                                        )))
                                    : Center(
                                        child: Text("Chưa cập nhật"),
                                      ),
                          ])),
                  Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dịch vụ nổi bật',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16),
                            loadingservices == true
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : services.length != 0
                                    ? Container(
                                        padding: EdgeInsets.all(16.0),
                                        height: 340,
                                        child: Expanded(
                                            child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: services.length,
                                          itemBuilder: (context, index) {
                                            return ServiceComponent(
                                                service: services[index]);
                                          },
                                        )))
                                    : Center(
                                        child: Text("Chưa cập nhật"),
                                      ),
                          ])),
                  Container(
                    height: 550,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thời gian làm việc',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Expanded(
                            child:
                                TimeWorkContainer(timeWork: hospital.timeWork))
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded1 = !isExpanded1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Chuyên khoa',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              ListView.builder(
                                itemCount: isExpanded1
                                    ? hospital.departments.length
                                    : 4, // Show only one item initially
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Text(
                                    '• ' + hospital.departments[index],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded1 = !isExpanded1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              isExpanded1 ? 'Thu gọn' : 'Xem thêm...',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                
                              ),
                            ),
                          )),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded2 = !isExpanded2;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Cơ sở vật chất',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  
                                ),
                              ),
                              SizedBox(height: 16.0),
                              ListView.builder(
                                itemCount: isExpanded2
                                    ? hospital.departments.length
                                    : 4, // Show only one item initially
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Text(
                                    '• ' + hospital.departments[index],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded2 = !isExpanded2;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              isExpanded2 ? 'Thu gọn' : 'Xem thêm...',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
