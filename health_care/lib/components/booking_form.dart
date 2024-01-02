import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/components/button.dart';
import 'package:health_care/components/datetime_field.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/components/tab_bar_view.dart';
import 'package:health_care/objects/doctors.dart';
import 'package:health_care/objects/timework.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/screens/confirm_booking_page.dart';
import 'package:health_care/utils/config.dart';
import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  final int id;
  final String name;
  final String hospitalName;
  final String bookingType;
  const BookingForm(
      {required this.id,
      required this.name,
      required this.hospitalName,
      required this.bookingType});

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  Map<String, dynamic> selectedDayData =
      {}; // To store the index of the selected day
  List<MapEntry<String, dynamic>> sortedEntries = [];
  List<dynamic> selectedInterval = [];
  bool isLoading = true;

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
    isLoading = true;
    try {
      final response = await HttpProvider()
          .getData('api/time-work/${widget.bookingType}/${widget.id}');

      final responseData = json.decode(response.body);
      final data = responseData['data'];

      // Checking if the fetched data is a Map<String, dynamic>
      if (data is Map<String, dynamic>) {
        // Extracting the 'times' data from the nested structure
        final timesData = data['times'] as Map<String, dynamic>?;

        if (timesData != null) {
          // Updating the state with the new data
          setState(() {
            // Assigning the new data to a variable in the widget state
            bookingData = timesData;
          });
        }
      }
      isLoading = false;
    } catch (e) {
      // Handling errors, if any
      print('Error: $e');
    }
  }

  _bookingForm(int id, String date, List<dynamic> interval) async {
    var data = {
      "id_doctor": id,
      "time": {"date": date, "interval": interval}
    };
    isLoading = true;
    try {
      var res =
          await HttpProvider().postData(data, 'api/work-schedule/add-advise');
      var body = json.decode(res.body);
      print('object ${data}');
      if (res.statusCode == 201) {
        MessageDialog.showSuccess(context, body['message']);
      } else {
        if (body.containsKey('errors') && body['errors'] is List<String>) {
          MessageDialog.showError(context, body['errors'][0]);
        } else if (body.containsKey('message')) {
          MessageDialog.showError(context, body['message']);
        } else {
          MessageDialog.showError(context, "An error occurred.");
        }
      }
      isLoading = false;
    } catch (error) {
      MessageDialog.showError(context, "An error occurred: $error");
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

  List<MapEntry<String, dynamic>> sortBookingData(Map<String, dynamic>? data) {
    List<MapEntry<String, dynamic>> sortedEntries = [];

    if (data != null) {
      // Convert the Map entries to a list
      sortedEntries = data.entries.toList();

      // Sort the list based on the 'date' field
      sortedEntries.sort((a, b) {
        DateTime dateA = DateTime.parse(a.value['date']);
        DateTime dateB = DateTime.parse(b.value['date']);
        return dateA.compareTo(dateB);
      });
    }

    return sortedEntries;
  }

  Map<String, dynamic> getDayData(String dayKey) {
    if (bookingData != null) {
      // Iterate through bookingData to find the matching day data
      for (var entry in bookingData!.entries) {
        if (entry.key.toString() == dayKey.toString()) {
          return entry.value;
        }
      }
    }
    // Return an empty map or handle the case when no matching data is found
    return {};
  }

  @override
  void initState() {
    super.initState();
    fetchBooking();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    sortedEntries = sortBookingData(bookingData);
    print('object ${selectedInterval}');

    return Form(
        key: _formKey,
        child: !isLoading
            ? Container(
                color: Color(0xffE7F7FA),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    // InkWell(
                    //   onTap: () {
                    //     _selectDate(context);
                    //   },
                    //   child: DateTimeField(
                    //     label: 'Đặt lịch hẹn',
                    //     value: selectedDate != null
                    //         ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                    //         : '${DateFormat('dd/MM/yyyy').format(DateTime.now())} - ${DateFormat('dd/MM/yyyy').format(DateTime.now().add(const Duration(days: 7)))}',
                    //     readOnly: true,
                    //     onTap: () {
                    //       _selectDate(context);
                    //     },
                    //   ),
                    // ),
                    // Config.spaceSmall,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Align(
                    //       alignment: Alignment.topLeft,
                    //       child: InkWell(
                    //         child: Text(
                    //           'Lịch trống gần nhất',
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Spacer(),
                    //     Align(
                    //       alignment: Alignment.topRight,
                    //       child: InkWell(
                    //         onTap: () {
                    //           setState(() {
                    //             selectedDayData =
                    //                 getDayData(sortedEntries.first.key);
                    //           });
                    //         },
                    //         child: Text(
                    //           'Hôm nay',
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Config.spaceSmall,
                    Container(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: sortedEntries.length,
                        itemBuilder: (context, index) {
                          if (sortedEntries == null || sortedEntries.isEmpty) {
                            return Container();
                          }

                          if (index < 0 || index >= sortedEntries.length) {
                            return Container();
                          }

                          MapEntry<String, dynamic> entry =
                              sortedEntries[index];
                          String dayKey = entry.key;
                          Map<String, dynamic> dayData =
                              entry.value as Map<String, dynamic>;

                          String formattedDate = DateFormat('dd/MM/yyyy')
                              .format(DateTime.parse(dayData['date']));
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (dayData['enable'] == true) {
                                  setState(() {
                                    selectedDayData = getDayData(dayKey);
                                  });
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 25),
                              decoration: BoxDecoration(
                                color: dayData['enable'] == false
                                    ? Colors.grey.withOpacity(0.5).withOpacity(
                                        0.5) // Adjust the disabled color
                                    : selectedDayData == dayData
                                        ? Color(
                                            0xFFE3F2FF) // Adjust the color when tapped
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    formattedDate,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${dayData['space'] ?? 0} chỗ trống',
                                    style: TextStyle(
                                      color: dayData['enable'] == false
                                          ? Colors
                                              .black // Adjust the text color for disabled state
                                          : Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Config.spaceMedium,
                    Container(
                      height: 300,
                      child: TabBarScreen(
                        dayNameData: selectedDayData,
                        onIntervalSelected: (interval) {
                          selectedInterval = interval;
                        },
                      ),
                    ),
                    Config.spaceMedium,
                    Button(
                      height: 50,
                      width: Config.screenWidth,
                      title: 'TIẾP TỤC ĐẶT LỊCH',
                      disable: false,

                      // onPressed: () => _confirmBooking(context),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmBookingPage(
                            hospitalName: widget.hospitalName,
                            name: widget.name,
                            id: widget.id,
                            date: selectedDayData['date'],
                            interval: selectedInterval,
                            bookingType: widget.bookingType,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ));
  }
}
