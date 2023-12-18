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
import 'package:health_care/objects/insurance.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/components/tag.dart';
import 'package:health_care/components/footer.dart';

import 'dart:math';

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
  InsuranceService insuranceService = InsuranceService();
  bool loading = true;
  bool loadingdoctors = true;
  bool loadingservices = true;
  bool isExpanded1 = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;
  List<Doctor> doctors = [];
  List<Service> services = [];
  List<Insurance> insurances = [];
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
    fetchInsurancesHospital();
    super.initState();
  }

  void fetchInsurancesHospital() async {
    try {
      insurances = await insuranceService.fetchInsurances(widget.id);
      //print(hospital);
    } catch (e) {
      print('Error fetch Hospital insurance: $e');
    }
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
                              maxLines: 2,
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
                      alignment: Alignment.centerLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TagContainer(tag: "Thông tin bệnh viện"),
                            SizedBox(height: 16),
                            Text(hospital.description,
                                style: TextStyle(fontSize: 16.0))
                          ])),
                  Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TagContainer(tag: "Đội ngũ bác sĩ"),
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
                                        child: Text(
                                          "Chưa cập nhật",
                                        ),
                                      ),
                          ])),
                  Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TagContainer(tag: "Hướng dẫn khám bệnh"),
                            SizedBox(height: 16),
                            Text(
                                "Nếu khách hàng muốn đến trị liệu và điều trị bệnh tại bệnh viện Đa khoa Vạn Phúc 1 có thể đặt lịch hẹn trước với bác sĩ. Nếu khách hàng chưa đặt lịch hẹn với bác sĩ thì thực hiện theo các bước sau: \n• Bước 1: Đến quầy lễ tân, bốc số và chờ theo thứ tự. \n• Bước 2: Vào gặp bác sĩ trao đổi tình trạng bệnh và làm một số kiểm tra (nếu có). \n• Bước 3: Đến quầy nhận thuốc và thanh toán chi phí khám chữa bệnh trước khi ra về.",
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])),
                  Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TagContainer(tag: "Dịch vụ nổi bật"),
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
                        TagContainer(tag: "Thời gian làm việc"),
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
                              TagContainer(tag: "Chuyên khoa"),
                              SizedBox(height: 16.0),
                              hospital.departments.length != 0
                                  ? ListView.builder(
                                      itemCount: isExpanded1
                                          ? hospital.departments.length
                                          : min(
                                              4,
                                              hospital.departments
                                                  .length), // Show only one item initially
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
                                    )
                                  : Center(child: Text('Chưa cập nhật')),
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
                  SizedBox(height: 8),
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
                              TagContainer(tag: 'Bảo hiểm'),
                              SizedBox(height: 16.0),
                              hospital.departments.length != 0
                                  ? ListView.builder(
                                      itemCount: isExpanded2
                                          ? insurances.length
                                          : min(
                                              4,
                                              insurances.length), // Show only one item initially
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Text(
                                          '• ' + insurances[index].name,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        );
                                      },
                                    )
                                  : Center(child: Text('Chưa cập nhật')),
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
                  SizedBox(height: 8),
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
                              TagContainer(tag: 'Cơ sở vật chất'),
                              SizedBox(height: 16.0),
                              hospital.departments.length != 0
                                  ? ListView.builder(
                                      itemCount: isExpanded3
                                          ? hospital.departments.length
                                          : min(
                                              4,
                                              hospital.departments
                                                  .length), // Show only one item initially
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
                                    )
                                  : Center(child: Text('Chưa cập nhật')),
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
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TagContainer(tag: "Hình thức thanh toán"),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Image.asset('assets/images/cash.png',
                                    width: 50, height: 50),
                                Text('Tiền mặt'),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Image.asset('assets/images/transfer.png',
                                    width: 50, height: 50),
                                Text('Chuyển khoản'),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Image.asset('assets/images/visa.png',
                                    width: 50, height: 50),
                                Text('Visa'),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Image.asset('assets/images/mastercard.png',
                                    width: 50, height: 50),
                                Text('Mastercard'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Config.spaceSmall,
                  Footer(),
                ],
              ),
            ),
    );
  }
}
