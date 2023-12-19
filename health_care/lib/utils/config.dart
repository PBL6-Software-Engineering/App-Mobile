import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Config {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
  }

  static get widthSize {
    return screenWidth;
  }

  static get heightSize {
    return screenHeight;
  }

  static const gapSmall = SizedBox(
    width: 10,
  );
  static final gapMedium = SizedBox(
    width: screenWidth! * .25,
  );

  static const spaceSmall = SizedBox(
    height: 25,
  );
  static final spaceMedium = SizedBox(
    height: screenHeight! * .025,
  );
  static final spaceBig = SizedBox(
    height: screenHeight! * .08,
  );

  static const outlinedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  static const focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(color: Colors.greenAccent),
  );

  static const errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(color: Colors.red),
  );

  static const primaryColor = Color(0xff2DBFC5);
  static const lightBlueColor = Color(0xff59D4E9);
  static const blueColor = Color(0xFF11b3cf);

  String formatTimeAgo(String timestamp) {
    // Parse the timestamp string
    DateTime dateTime = DateTime.parse(timestamp);

    // Calculate the time difference
    Duration difference = DateTime.now().difference(dateTime);

    // Define time intervals
    const int minutesPerHour = 60;
    const int hoursPerDay = 24;
    const int minutesPerDay = minutesPerHour * hoursPerDay;

    // Calculate time difference in various units
    int minutes = difference.inMinutes % minutesPerHour;
    int hours = difference.inHours % hoursPerDay;
    int days = difference.inDays;

    // Format the time ago
    if (days > 0) {
      return '${days} ngày trước';
    } else if (hours > 0) {
      return '${hours} giờ trước';
    } else if (minutes > 0) {
      return '${minutes} phút trước';
    } else {
      return 'Bây giờ';
    }
  }
}
