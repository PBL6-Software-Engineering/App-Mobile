import 'package:flutter/material.dart';
import 'package:health_care/objects/services.dart';
import 'package:health_care/screens/service_page.dart';

class ServiceComponent extends StatelessWidget {
  final Service service;

  ServiceComponent({required this.service});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServicePage(service: service),
            ),
          );
        },
        child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(
                color: Color(0xFF0B8AA0),
                width: 8.0,
              ),
              right: BorderSide(
                color: Color(0xFF11B3CF),
                width: 2.0,
              ),
              top: BorderSide(
                color: Color(0xFF11B3CF),
                width: 2.0,
              ),
              bottom: BorderSide(
                color: Color(0xFF11B3CF),
                width: 2.0,
              ),
            ),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            service.name,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Icon(
                Icons.attach_money,
                size: 16.0,
              ),
              SizedBox(width: 4.0),
              Text(
                'Giá dịch vụ: '+ service.price.toString() +' vnđ',
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
        ],
      ),
    )
    );
  }
}