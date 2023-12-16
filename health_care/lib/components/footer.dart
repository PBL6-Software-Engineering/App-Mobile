import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/timework.dart';

class Footer extends StatelessWidget {

  Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
                        color: Config.blueColor,
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '© 2024 Health Care',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
  }
}
