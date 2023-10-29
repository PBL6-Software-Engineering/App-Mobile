import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({Key? key}) : super(key: key);

  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> with SingleTickerProviderStateMixin{

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
                        'https://muanhanhhon.com/wp-content/uploads/2019/09/benh-vien.jpg'),
                  ),
                  SizedBox(width: 16.0),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 100,
                    ),
                    child: Text(
                      'Bệnh viện đa khoa Đà Nẵng',
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
                      '54 Nguyễn Lưong Bằng, Liên Chiểu, Đà Nẵng',
                      style: TextStyle(fontSize: 18.0),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
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
            // Expanded(
            //   child:DefaultTabController(
            //     length: 3,
            //     child: Column(
            //       children: [
            //         TabBar(
            //           tabs: [
            //             Tab(text: 'Thông tin'),
            //             Tab(text: 'Dịch vụ'),
            //             Tab(text: 'Bác sĩ'),
            //           ],
            //         ),
            //         Expanded(
            //           child: TabBarView(
            //             children: [
            //               HospitalInfor(),
            //               HospitalService(),
            //               HospitalDoctor(),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class HospitalInfor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin'),
      ),
      body: Container(
        child: Center(
          child: Text('Trang thông tin'),
        ),
      ),
    );
  }
}

class HospitalService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dịch vụ'),
      ),
      body: Container(
        child: Center(
          child: Text('Trang dịch vụ'),
        ),
      ),
    );
  }
}

class HospitalDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bác sĩ'),
      ),
      body: Container(
        child: Center(
          child: Text('Trang bác sĩ'),
        ),
      ),
    );
  }
}

