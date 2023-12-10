import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimePickerField extends StatefulWidget {
  final List<dynamic> times;
  final void Function(List<dynamic>) onIntervalSelected;

  TimePickerField({required this.times, required this.onIntervalSelected});

  @override
  _TimePickerFieldState createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  int selectedIndex = -1;
  List<dynamic> interval = [];

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        height: 180,
        child: Wrap(
          spacing: 15, // Horizontal spacing between items
          runSpacing: 15, // Vertical spacing between rows
          children: widget.times.isNotEmpty
              ? List.generate(widget.times.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // Toggle selection when tapped
                        if (index == selectedIndex) {
                          selectedIndex = -1; // Unselect if already selected
                          interval.clear(); // Clear the interval
                        } else {
                          selectedIndex = index; // Select the interval
                          interval = List<dynamic>.from(widget.times[index]);
                          widget.onIntervalSelected(interval);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 100,
                      decoration: BoxDecoration(
                        color: index == selectedIndex
                            ? Config.primaryColor
                            : Color(0xFFE3F2FF),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${widget.times[index][0]} - ${widget.times[index][1]}',
                          style: TextStyle(
                            color: index == selectedIndex
                                ? Colors.white
                                : Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                })
              : [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/calendar.svg',
                        width: 80.0,
                        height: 80.0,
                      ),
                      Config.spaceSmall,
                      Text(
                        'Vui lòng chọn một buổi khác trong ngày',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
        ),
      ),
    );
  }
}
