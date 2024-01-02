import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:health_care/components/button.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/components/custom_text_field.dart';

class ConfirmBookingPage extends StatefulWidget {
  final String hospitalName;
  final String name;
  final int id;
  final String date;
  final String bookingType;
  final List<dynamic> interval;

  const ConfirmBookingPage({
    required this.hospitalName,
    required this.name,
    required this.id,
    required this.date,
    required this.interval,
    required this.bookingType,
  });

  @override
  _ConfirmBookingStatePage createState() => _ConfirmBookingStatePage();
}

class _ConfirmBookingStatePage extends State<ConfirmBookingPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  String _selectedGender = 'Nam';
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _healthIssueController = TextEditingController();
  bool isLoading = false;

  _bookingForm(
    int id,
    String date,
    List<dynamic> interval,
    String name,
    String dateOfBirth,
    int gender,
    String email,
    String phone,
    String? address,
    String healthCondition,
  ) async {
    var data = {
      if (widget.bookingType == 'advise')
        "id_doctor": id
      else
        "id_hospital_service": id,
      "time": {"date": date, "interval": interval},
      "name_patient": name,
      "date_of_birth_patient": DateFormat('yyyy-MM-dd')
          .format(DateFormat('dd/MM/yyyy').parse(dateOfBirth)),
      "gender_patient": gender,
      "email_patient": email,
      "phone_patient": phone,
      "address_patient": address,
      "health_condition": healthCondition,
    };
    setState(() {
      isLoading = true;
    });

    try {
      var res = await HttpProvider()
          .postData(data, 'api/work-schedule/add-${widget.bookingType}');
      var body = json.decode(res.body);
      if (res.statusCode == 201) {
        MessageDialog.showSuccess(context, body['message']);
        Navigator.of(context).pushNamed('setting');
        isLoading = false;
      } else {
        if (body.containsKey('errors') && body['errors'] is List<String>) {
          MessageDialog.showError(context, body['errors'][0]);
        } else if (body.containsKey('message')) {
          MessageDialog.showError(context, body['message']);
        } else {
          MessageDialog.showError(context, "An error occurred.");
        }
      }
    } catch (error) {
      MessageDialog.showError(context, "An error occurred: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Xác nhận đặt lịch hẹn'),
        backgroundColor: Config.blueColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Bệnh viện: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(widget.hospitalName),
                      ],
                    ),
                    Config.spaceSmall,
                    Row(
                      children: [
                        Text('Địa chỉ bệnh viện: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Đà Nẵng - Việt Nam Pro'),
                      ],
                    ),
                    Config.spaceSmall,
                    Row(
                      children: [
                        Text(
                            widget.bookingType == 'advice'
                                ? 'Bác sĩ: '
                                : 'Dịch vụ: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(widget.name),
                      ],
                    ),
                    Config.spaceSmall,
                    Row(
                      children: [
                        Text('Lịch khám: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          '${widget.interval[0]} - ${widget.interval[1]}, ${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.date))}',
                        ),
                      ],
                    ),
                    Config.spaceSmall,
                    Center(
                      child: Text('Thông tin bệnh nhân',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    Config.spaceSmall,
                    Text(
                        '(*) Vui lòng cung cấp đầy đủ các thông tin của người đến khám theo mẫu bên dưới. Việc cung cấp đầy đủ thông tin sẽ giúp Quý khách tiết kiệm được thời gian làm hồ sơ khách hàng tại bệnh viện.',
                        style: TextStyle(color: Colors.red)),
                    Config.spaceSmall,
                    CustomTextField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      hintText: 'Nhập tên bệnh nhân',
                      labelText: 'Tên bệnh nhân',
                      prefixIcon: Icons.person,
                    ),
                    Config.spaceSmall,
                    CustomTextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      hintText: 'Nhập số điện thoại',
                      labelText: 'Số điện thoại',
                      prefixIcon: Icons.phone,
                    ),
                    Config.spaceSmall,
                    CustomTextField(
                      controller: _dobController,
                      keyboardType: TextInputType.text,
                      hintText: 'Nhập ngày sinh (dd/mm/yyyy)',
                      labelText: 'Ngày sinh',
                      prefixIcon: Icons.calendar_today,
                    ),
                    Config.spaceSmall,
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue!;
                        });
                      },
                      items: <String>['Nam', 'Nữ', 'Khác']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(fontSize: 13)),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Giới tính',
                        prefixIcon: Icon(Icons.people),
                        isDense: true, // Reduces the vertical padding
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12), // Adjust padding
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black87, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      elevation: 3, // Controls the shadow of the dropdown
                      icon: Icon(Icons
                          .arrow_drop_down), // Custom icon for the dropdown
                    ),
                    Config.spaceSmall,
                    CustomTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Nhập email',
                      labelText: 'Email',
                      prefixIcon: Icons.email_outlined,
                    ),
                    Config.spaceSmall,
                    CustomTextField(
                      controller: _addressController,
                      keyboardType: TextInputType.text,
                      hintText: 'Nhập địa chỉ liên hệ',
                      labelText: 'Địa chỉ liên hệ',
                      prefixIcon: Icons.location_on,
                      isEmail: true,
                    ),
                    Config.spaceSmall,
                    CustomTextField(
                      controller: _healthIssueController,
                      keyboardType: TextInputType.multiline,
                      hintText: 'Nhập vấn đề sức khỏe',
                      labelText: 'Vấn đề sức khỏe',
                      prefixIcon: Icons.health_and_safety,
                    ),
                    Config.spaceSmall,
                    Row(
                      children: [
                        Expanded(
                          child: Button(
                            height: 50,
                            title: 'Huỷ',
                            fontSize: 13,
                            backgroundColor: Colors.white70,
                            foregroundColor: Colors.black87,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            disable: false,
                          ),
                        ),
                        Config.gapSmall,
                        Expanded(
                          child: Button(
                            height: 50,
                            fontSize: 13,
                            title: 'Xác nhận đặt lịch',
                            onPressed: () {
                              _bookingForm(
                                widget.id,
                                widget.date,
                                widget.interval,
                                _nameController.text,
                                _dobController.text,
                                _selectedGender == 'Nam'
                                    ? 1
                                    : (_selectedGender == 'Nữ' ? 0 : 2),
                                _emailController.text,
                                _phoneController.text,
                                _addressController.text,
                                _healthIssueController.text,
                              );
                            },
                            disable: false,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
