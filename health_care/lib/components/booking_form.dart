import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/components/button.dart';
import 'package:health_care/components/datetime_field.dart';
import 'package:health_care/components/tab_bar_view.dart';
import 'package:health_care/objects/doctors.dart';
import 'package:health_care/objects/timework.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/utils/config.dart';
import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  final int id;
  const BookingForm({required this.id});

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  int selectedDayIndex = 0; // To store the index of the selected day

  Map<String, String> dayNames = {
    'sunday': 'Chủ Nhật',
    'monday': 'Thứ Hai',
    'tuesday': 'Thứ Ba',
    'wednesday': 'Thứ Tư',
    'thursday': 'Thứ Năm',
    'friday': 'Thứ Sáu',
    'saturday': 'Thứ Bảy'
  };

  Map<String, dynamic>? bookingData = {};

  Future<void> fetchBooking() async {
    try {
      final response =
          await HttpProvider().getData('/api/time-work/advise/${widget.id}');
      print('id: ${widget.id}');

      final responseData = json.decode(response.body);
      final data = responseData['data'];

      // Checking if the fetched data is a Map<String, dynamic>
      if (data is Map<String, dynamic>) {
        // Updating the state with the new data
        setState(() {
          // Assigning the new data to a variable in the widget state
          bookingData = data;
        });
      }
      print('bokking data ${bookingData}, ${widget.id}');
    } catch (e) {
      // Handling errors, if any
      print('Error: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 7)),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Config.primaryColor,
                backgroundColor: Colors.white,
                dialogBackgroundColor: Colors.white,
              ),
              child: child!,
            );
          },
        )) ??
        DateTime.now();

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBooking();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Form(
      key: _formKey,
      child: Container(
        color: Color(0xffE7F7FA),
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        alignment: Alignment.topLeft,
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: DateTimeField(
                label: 'Đặt lịch hẹn',
                value: selectedDate != null
                    ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                    : '${DateFormat('dd/MM/yyyy').format(DateTime.now())} - ${DateFormat('dd/MM/yyyy').format(DateTime.now().add(const Duration(days: 7)))}',
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
              ),
            ),
            Config.spaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (selectedDayIndex == 0)
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      child: Text(
                        'Lịch trống gần nhất',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = 0;
                      });
                    },
                    child: Text(
                      'Hôm nay',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Config.spaceSmall,
            Container(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  String dayKey = bookingData!.keys.toList()[index];
                  Map<String, dynamic> dayData = bookingData![dayKey] ?? {};
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index; // Set the selected day index
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                      decoration: BoxDecoration(
                        color: selectedDayIndex == index
                            ? Color(0xFFE3F2FF)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dayNames[dayKey] ?? 'Unknown',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            dayData['enable'] == true
                                ? 'Có lịch'
                                : 'Không có lịch',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${dayData['space']} chỗ trống',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
