import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/components/booking_form.dart';
import 'package:health_care/components/timework.dart';
import 'package:health_care/objects/doctors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:health_care/objects/hospitals.dart';
import 'package:health_care/objects/timework.dart';
import 'package:health_care/objects/rating.dart';
import 'package:health_care/components/rating.dart';
import 'dart:math';

class DoctorPage extends StatefulWidget {
  final int id;
  const DoctorPage({required this.id});

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  DoctorService doctorService = DoctorService();
  bool loading = true;
  DoctorDetail doctor = DoctorDetail(
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
    dateOfBirth: '',
    experience: 0,
    gender: 1,
    searchNumber: 0,
    hospital: Hospitalinfor(
      id: 1,
      name: '',
    ),
    timeWork: TimeWork(
      id: 1,
      idHospital: 1,
      times: {},
      enable: 1,
      note: "",
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
      numberRating: 4,
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
  bool isExpanded1 = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;
  bool isExpanded4 = false;
  bool isExpanded5 = false;

  void initState() {
    fetchDoctor();
    super.initState();
  }

  void fetchDoctor() async {
    try {
      loading = true;
      doctor = await doctorService.fetchDoctorDetail(widget.id);
      setState(() {
        loading = false;
      });
      // print(doctor.timeWork.times['monday']?.afternoon?.date);
    } catch (e) {
      print('Error fetch doctor page: $e');
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
                children: [
                  // Container chứa ảnh và thông tin bác sĩ

                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        doctor.avatar != ''
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(doctor.avatar),
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    AssetImage('assets/images/doctor.jpg'),
                              ),
                        SizedBox(width: 16.0),
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  235), // Giới hạn chiều rộng tối đa của đoạn text ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(height: 16),
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: 235,
                                ),
                                child: Text(
                                  'Chuyên khoa: ' + doctor.department.name,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Đoạn text chứa tên bệnh viện và địa chỉ
                  Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_hospital,
                              size: 24.0,
                            ),
                            SizedBox(width: 8.0),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width - 100,
                              ),
                              child: Text(
                                'Đang làm việc tại ' + doctor.hospital.name,
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
                                doctor.email,
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
                                doctor.phone,
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
                              Icons.local_activity,
                              size: 24.0,
                            ),
                            SizedBox(width: 8.0),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width - 100,
                              ),
                              child: Text(
                                doctor.address,
                                style: TextStyle(fontSize: 18.0),
                                softWrap: true,
                              ),
                            ),
                          ],
                        )
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
                            child: TimeWorkContainer(timeWork: doctor.timeWork))
                      ],
                    ),
                  ),

                  // Container chứa tiêu đề thông tin nổi bật
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
                                'Điểm nổi bật nhất',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              doctor.inforExtend.prominent.length !=0 ?
                              ListView.builder(
                                itemCount: isExpanded1
                                    ? doctor.inforExtend.prominent.length
                                    : min(2,doctor.inforExtend.prominent.length), // Show only one item initially
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final prominent =
                                      doctor.inforExtend.prominent[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '• ' + prominent.title,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        prominent.subtitle.join(', '),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                    ],
                                  );
                                },
                              ): Center(
                                child: Text('Chưa cập nhật')
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
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin cơ bản',
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
                                'Kinh nghiệm làm việc',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              doctor.inforExtend.workExperience.length!=0 ?
                              ListView.builder(
                                itemCount: isExpanded2
                                    ? doctor.inforExtend.workExperience.length
                                    : min(2,doctor.inforExtend.workExperience.length), // Show only one item initially
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final experience =
                                      doctor.inforExtend.workExperience[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '• ' + experience.title,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        experience.subtitle.join(', '),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                    ],
                                  );
                                },
                              ): Center(
                                child: Text('Chưa cập nhật')
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
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded3 = !isExpanded3;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Quá trình đào tạo',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              doctor.inforExtend.trainingProcess.length !=0 ?
                              ListView.builder(
                                itemCount: isExpanded3
                                    ? doctor.inforExtend.trainingProcess.length
                                    : min(2, doctor.inforExtend.trainingProcess.length), // Show only one item initially
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final trainingProcess =
                                      doctor.inforExtend.trainingProcess[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '• ' + trainingProcess.title,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        trainingProcess.subtitle.join(', '),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                    ],
                                  );
                                },
                              ): Center(
                                child: Text('Chưa cập nhật')
                              )
                              ,
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded3 = !isExpanded3;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              isExpanded3 ? 'Thu gọn' : 'Xem thêm...',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded4 = !isExpanded4;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Giải thưởng và ghi nhận',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              doctor.inforExtend.awardsRecognition.length !=0 ?
                              ListView.builder(
                                itemCount: isExpanded4
                                    ? doctor
                                        .inforExtend.awardsRecognition.length
                                    : min(2,doctor.inforExtend.awardsRecognition.length), // Show only one item initially
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final awardsRecognition = doctor
                                      .inforExtend.awardsRecognition[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '• ' + awardsRecognition.title,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        awardsRecognition.subtitle.join(', '),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                    ],
                                  );
                                },
                              ): Center(
                                child: Text('Chưa cập nhật')
                              )
                              ,
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded4 = !isExpanded4;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              isExpanded4 ? 'Thu gọn' : 'Xem thêm...',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded5 = !isExpanded5;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Đánh gía khách hàng',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                              
                                  children: List.generate(5, (index) {
                                    if (index < doctor.rating.numberRating) {
                                      return Icon(Icons.star,
                                          color: Colors.yellow);
                                    } else {
                                      return Icon(Icons.star, color: Colors.grey);
                                    }
                                  }),
                                ),
                                SizedBox(width: 16.0),
                                Text('(' + doctor.rating.countRating.toString()+ ' đánh giá)')
                                ]
                              ),
                              SizedBox(height: 16.0),
                              doctor.rating.ratings.length != 0 ?
                              ListView.builder(
                                itemCount: isExpanded5
                                    ? doctor
                                        .rating.ratings.length
                                    : min(2, doctor.rating.ratings.length), // Show only one item initially
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final rating = doctor
                                      .rating.ratings[index];
                                  return RatingComponent(
                                    rating : rating
                                  );
                                },
                              ):
                              Center(
                                child: Text('Chưa có đánh giá nào'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded5 = !isExpanded5;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              isExpanded5 ? 'Thu gọn' : 'Xem thêm...',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: BookingForm(id: doctor.idDoctor, name: doctor.name),
                  ),
                ],
              ),
            ),
    );
  }
}
