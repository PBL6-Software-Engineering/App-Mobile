import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/objects/doctors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:health_care/objects/hospitals.dart';

class DoctorPage extends StatefulWidget {
  final int id;
  const DoctorPage({required this.id});

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  DoctorService doctorService = DoctorService();
  DoctorDetail doctor= DoctorDetail(
    id: 0,
    email: '',
    username: '',
    name: '',
    phone: '',
    address: '',
    avatar: '',
    isAccept: 1,
    role: '',
    idDoctor: 0,
    idDepartment: 0,
    idHospital: 0,
    isConfirm: 1,
    provinceCode: 0,
    dateOfBirth: DateTime(1,1,2000),
    experience: 0,
    gender: 1,
    searchNumber: 0,
    hospital: Hospitalinfor(
      id: 1,
      name:'',
    ),
    inforExtend: InforExtend(
      id: 1,
      idDoctor: 1,
      prominent: [],
      information: '',
      strengths: [],
      workExperience: [],
      trainingProcess: [],
      language: [],
      awardsRecognition: [],
      researchWork: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    rating: Rating(
      countRating: 100,
      numberRating: 4.5,
      countDetails: RatingDetails(
        oneStar: 10,
        twoStar: 20,
        threeStar: 30,
        fourStar: 25,
        fiveStar: 15,
      ),
      ratings: [],
    ),
    department: Department(
      id: 1,
      name: '',
      description: '',
      thumbnail: '',
      searchNumber: 50,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  );

  void initState(){
    fetchDoctor();
    //print('ok');
    //print(doctor[1].address);
    super.initState();
  }
  void fetchDoctor () async {
    try {
      doctor = await doctorService.fetchDoctorDetail(widget.id);
      setState(() {
      });
    } catch (e) {
      print('Error: $e');
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
        title: SvgPicture.asset(
                './assets/icons/logo.svg',
                width: 50.0,
                height: 50.0,
              ),       
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container chứa ảnh và thông tin bác sĩ
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(doctor.avatar),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Chuyên khoa: ' + doctor.department.name,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      // Row(
                      //   children: [
                      //     ElevatedButton(
                      //       onPressed: () {
                      //         // Xử lý khi nhấn nút nhắn tin
                      //       },
                      //       child: Text('Tư vấn'),
                      //     ),
                      //     SizedBox(width: 8.0),
                      //     ElevatedButton(
                      //       onPressed: () {
                      //         // Xử lý khi nhấn nút đặt lịch hẹn
                      //       },
                      //       child: Text('Đặt lịch hẹn'),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),

            // Đoạn text chứa tên bệnh viện và địa chỉ
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.local_hospital,
                    size: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 100,
                    ),
                    child: Text(
                      'Đang làm việc tại '+ doctor.hospital.name,
                      style: TextStyle(fontSize: 18.0),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(16.0),
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
                      doctor.address,
                      style: TextStyle(fontSize: 18.0),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),

            // Container chứa tiêu đề thông tin nổi bật
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông tin nổi bật:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),      
                  Html(
                      data: doctor.inforExtend.information,
                  ),
                ],
              ),
            ),

            // Kinh nghiệm làm việc
            // Container(
            //   padding: EdgeInsets.all(16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Kinh nghiệm làm việc',
            //         style: TextStyle(
            //           fontSize: 20.0,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       SizedBox(height: 8.0),
            //       Text(
            //         doctor.experience.toString() + ' năm làm việc',
            //         style: TextStyle(fontSize: 16.0),
            //       ),
            //     ],
            //   ),
            // ),

            // Giờ làm việc trong tuần
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thời gian làm việc:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        leading: Text('Thứ 2:'),
                        title: Text('8:00 AM - 5:00 PM'),
                      ),
                      ListTile(
                        leading: Text('Thứ 3:'),
                        title: Text('9:00 AM - 6:00 PM'),
                      ),
                      ListTile(
                        leading: Text('Thứ 4:'),
                        title: Text('8:30 AM - 4:30 PM'),
                      ),
                      ListTile(
                        leading: Text('Thứ 5:'),
                        title: Text('10:00 AM - 7:00 PM'),
                      ),
                      ListTile(
                        leading: Text('Thứ 6:'),
                        title: Text('8:00 AM - 5:00 PM'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
