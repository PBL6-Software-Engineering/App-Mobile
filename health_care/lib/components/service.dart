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
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white,
             border: Border.all(
               color: Colors.blue,
               width: 4,
             ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: service.thumbnail != '' ? 
                  Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(service.thumbnail),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ) : 
                  Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/service.dart'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Center(
                  child: Container(
                    height: 65,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        service.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
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
              ],
            ),
          ),
        ));
  }
}
