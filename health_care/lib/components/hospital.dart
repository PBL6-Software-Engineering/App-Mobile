import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/hospitals.dart';
import 'package:health_care/screens/hospital_page.dart';
import 'package:health_care/components/button.dart';

class HospitalContainer extends StatelessWidget {
  final Hospital hospital;
  const HospitalContainer({
    Key? key,
    required this.hospital,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HospitalPage(id: hospital.id),
          ),
        );
      },
      child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(hospital.avatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                hospital.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 20),
              SizedBox(width: 4),
              Text(
                hospital.address,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone, size: 20),
              SizedBox(width: 4),
              Text(
                hospital.phone,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            hospital.description,
            style: TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis, // Hiển thị dấu "..." nếu text quá dài
            maxLines: 2,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {
          //         // Xử lý khi nhấn vào nút "tư vấn"
          //       },
          //       child: Text('Tư vấn'),
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         // Xử lý khi nhấn vào nút "Đặt lịch hẹn"
          //       },
          //       child: Text('Đặt lịch'),
          //     ),
          //   ],
          // ),
        ],
      ),
    )
    );
  }
}