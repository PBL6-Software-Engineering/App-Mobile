import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/objects/hospitals.dart';

class HospitalPage extends StatefulWidget {
  final int id;
  const HospitalPage({required this.id});

  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> with SingleTickerProviderStateMixin{
  HospitalService hospitalService = HospitalService(); 
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
      times: {      
      },
      enable: 1,
      note: "",
    ),
    departments: [],
  );

  void initState(){
    fetchHospital();
    super.initState();
  }
  void fetchHospital () async {
    try {
      hospital = await hospitalService.fetchHospitalDetail(widget.id);
      print(hospital);
      setState(() {
      });
    } catch (e) {
      print('Error fetch Hospital at page: $e');
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
                    backgroundImage: NetworkImage(
                      hospital.avatar,
                    )
                  ),
                  SizedBox(width: 16.0),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 100,
                    ),
                    child: Text(
                      hospital.name,
                      style: TextStyle(fontSize: 20.0,),
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
                  Text(
                    hospital.description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Trang thiết bị',
            //         style: TextStyle(
            //           fontSize: 20.0,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       SizedBox(height: 8.0),      
            //       Container(
            //         child: ListView.builder(
            //           itemCount: 4,//4hospital.infrastructure.length,
            //           itemBuilder: (context, index) {
            //             return ListTile(
            //               leading: Icon(Icons.check_circle),
            //               title: Text(hospital.infrastructure[index]),
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container chứa tiêu đề thông tin nổi bậ
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

