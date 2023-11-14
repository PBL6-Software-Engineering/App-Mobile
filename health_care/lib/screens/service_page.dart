import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/objects/services.dart';
import 'package:health_care/main_layout.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:flutter_html/flutter_html.dart';

class ServicePage extends StatelessWidget {
  final Service service;

  ServicePage({required this.service});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                service.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    size: 16.0,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    'Giá dịch vụ: ' + service.price.toString() + ' vnđ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    Icons.local_hospital,
                    size: 16.0,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    service.hospital_name,
                    style: TextStyle(fontSize: 16.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin về dịch vụ',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Html(data: service.infor.aboutService),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quá trình chuẩn bị',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Html(data: service.infor.prepareProcess),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chi tiết dịch vụ',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Html(
                      data: service.infor.serviceDetails,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
