import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/utils/api_constant.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/user.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/providers/auth_manager.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

class UserInfoPage extends StatefulWidget {
  User user;
  final Function(User) onUpdateUser;
  final Function(File) onUpdateAvatar;
  UserInfoPage(
      {required this.user,
      required this.onUpdateUser,
      required this.onUpdateAvatar});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  bool isEditing = false;
  User updatedUser = User(
    id: 0,
    name: '',
    username: '',
    email: '',
    phone: '',
    gender: 0,
    dateOfBirth: '',
    avatar: '',
    address: '',
  );
  void initState() {
    super.initState();
  }
  void _showNotificationDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  String convertDateFormat(String inputDate) {
    // Định dạng đầu vào: dd/mm/yyyy
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');

    // Định dạng đầu ra: yyyy/mm/dd
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');

    // Chuyển đổi ngày
    DateTime date = inputFormat.parse(inputDate);
    String outputDate = outputFormat.format(date);

    return outputDate;
  }

  void updateUser(User updatedUser) {
    setState(() {
      widget.user = updatedUser;
    });
  }
  void _toggleEdit() {
    setState(() {
      isEditing = true;
    });
    if (isEditing) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData(
              canvasColor: Colors.white,
            ),
            child: UserProfileFormDialog(
              user: widget.user,
              onUpdateUser: updateUser,
            ),
          );
        },
      );
    }
  }

  File? _image;

  Future _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      UserService userService = UserService();
      userService.uploadImage(File(pickedFile.path), widget.user);
      widget.onUpdateAvatar(_image!);

      MessageDialog.showSuccess(context, 'Cập nhật avatar thành công!');
    } else {
      MessageDialog.showError(context, 'Cập nhật avatar thất bại!');
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin cá nhân'),
        backgroundColor: Config.blueColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            widget.onUpdateUser(widget.user);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Center(
              child: GestureDetector(
            onTap: () {
              _getImage();
            },
            child: widget.user.avatar != ''
                ? CircleAvatar(
                    radius: 60,
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider<Object>?
                        : NetworkImage(widget.user.avatar),
                  )
                : CircleAvatar(
                    radius: 60,
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider<Object>?
                        : AssetImage('assets/images/user.jpeg'),
                  ),
          )),
          SizedBox(height: 16.0),
          Center(
            child: Text(
              widget.user.name,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          UserInfoItem(label: 'Số Điện Thoại:', value: widget.user.phone),
          UserInfoItem(label: 'Email:', value: widget.user.email),
          UserInfoItem(
              label: 'Giới Tính:',
              value: widget.user.gender == 1
                  ? "Nam"
                  : (widget.user.gender == 2 ? "Nữ" : "Không xác định")),
          UserInfoItem(label: 'Ngày Sinh:', value: widget.user.dateOfBirth),
          UserInfoItem(label: 'Địa chỉ:', value: widget.user.address),
          SizedBox(height: 32.0),
          // Button "Chỉnh sửa thông tin"
          Center(
            child: ElevatedButton(
              onPressed: _toggleEdit
              // Xử lý sự kiện khi nhấn vào button "Chỉnh sửa thông tin"
              ,
              child: Text('Chỉnh sửa thông tin'),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoItem extends StatelessWidget {
  final String label;
  final String value;

  UserInfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

class UserProfileFormDialog extends StatelessWidget {
  final User user;
  final Function(User) onUpdateUser;
  UserProfileFormDialog({required this.user, required this.onUpdateUser});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String selectedGender = '';
  //TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  void _showNotificationDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  String convertDateFormat(String inputDate) {
    // Định dạng đầu vào: dd/mm/yyyy
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');

    // Định dạng đầu ra: yyyy/mm/dd
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');

    // Chuyển đổi ngày
    DateTime date = inputFormat.parse(inputDate);
    String outputDate = outputFormat.format(date);

    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    // Set the initial values of the text fields
    HttpProvider httpProvider = HttpProvider();
    nameController.text = user.name;
    phoneController.text = user.phone;
    emailController.text = user.email;
    selectedGender =
        user.gender == 1 ? "Nam" : (user.gender == 2 ? "Nữ" : "Không xác định");
    //genderController.text = user.gender.toString();
    addressController.text = user.address;
    dobController.text = user.dateOfBirth;
    bool isLoading = false;

    return AlertDialog(
      title: Text('Chỉnh sửa thông tin'),
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.all(16.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold, // Kích thước font chữ mong muốn
            ),
            decoration: InputDecoration(
              labelText: 'Tên',
              labelStyle: TextStyle(
                color: Config.blueColor, // Màu sắc mong muốn cho nhãn
              ),
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: phoneController,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold, // Kích thước font chữ mong muốn
            ),
            decoration: InputDecoration(
              labelText: 'Số điện thoại',
              labelStyle: TextStyle(
                color: Config.blueColor, // Màu sắc mong muốn cho nhãn
              ),
            ),
          ),
          Config.spaceSmall,
          // TextFormField(
          //   controller: emailController,
          //   decoration: InputDecoration(
          //     enabled: false,
          //     labelText: 'Email',
          //     labelStyle: TextStyle(
          //       color: Config.blueColor, // Màu sắc mong muốn cho nhãn
          //     ),
          //   ),
          // ),
          //Config.spaceSmall,
          // TextFormField(
          //   controller: genderController,
          //   decoration: InputDecoration(
          //     labelText: 'Giới tính',
          //   ),
          // ),
          DropdownButtonFormField<String>(
            value: selectedGender,
            onChanged: (newValue) {
              selectedGender = newValue!;
            },
            decoration: InputDecoration(
              labelText: 'Giới tính',
              labelStyle: TextStyle(
                color: Config.blueColor, // Màu sắc mong muốn cho nhãn
              ),
            ),
            items: [
              DropdownMenuItem(
                value: 'Nam',
                child: Text('Nam'),
              ),
              DropdownMenuItem(
                value: 'Nữ',
                child: Text('Nữ'),
              ),
              DropdownMenuItem(
                value: 'Không xác định',
                child: Text('Không xác định'),
              ),
            ],
          ),
          Config.spaceSmall,
          TextFormField(
            controller: addressController,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold, // Kích thước font chữ mong muốn
            ),
            decoration: InputDecoration(
              labelText: 'Địa chỉ',
              labelStyle: TextStyle(
                color: Config.blueColor, // Màu sắc mong muốn cho nhãn
              ),
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: dobController,
            readOnly: true,
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (selectedDate != null) {
                // Định dạng ngày theo kiểu dd/MM/yyyy
                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(selectedDate);
                dobController.text = formattedDate;
              }
            },
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              labelText: 'Ngày sinh',
              labelStyle: TextStyle(
                color: Config.blueColor,
              ),
            ),
            // controller: dobController,
            // //inputFormatters: [
            //   //FilteringTextInputFormatter.allow(RegExp(r'^\d{2}/\d{2}/\d{4}$')),
            //   //_DateInputFormatter(),
            // //],
            // keyboardType: TextInputType.datetime,
            // style: TextStyle(
            //   fontSize: 15,
            //   fontWeight: FontWeight.bold, // Kích thước font chữ mong muốn
            // ),
            // decoration: InputDecoration(
            //   labelText: 'Ngày sinh',
            //   labelStyle: TextStyle(
            //     color: Config.blueColor, // Màu sắc mong muốn cho nhãn
            //   ),
            // ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            isLoading = true;
            var updatedProfile = {
              'name': nameController.text,
              'phone': phoneController.text,
              'username': user.username,
              'email': emailController.text,
              'gender': selectedGender == 'Nam'
                  ? 1
                  : (selectedGender == 'Nữ' ? 2 : 0),
              'address': addressController.text,
              'date_of_birth': convertDateFormat(dobController.text),
            };
            var response = await HttpProvider()
                .postData(updatedProfile, 'api/infor-user/update');
            print(updatedProfile);
            print(json.decode(response.body)['message']);

            // Đóng Dialog hiện tại
            if (response.statusCode == 200) {
              Navigator.of(context).pop();
              User new_user = User(
                id: user.id,
                name: nameController.text,
                username: user.username,
                email: user.email,
                phone: phoneController.text,
                gender: selectedGender == 'Nam'
                    ? 1
                    : (selectedGender == 'Nữ' ? 2 : 0),
                dateOfBirth: dobController.text,
                avatar: user.avatar,
                address: addressController.text,
              );
              AuthManager.setUser(await AuthManager.fetchUser());
              onUpdateUser(new_user);
              // Hiển thị thông báo bằng Dialog mới
              // _showNotificationDialogOk(
              //     context, json.decode(response.body)['message'], new_user);

              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => UserInfoPage(user: new_user),
              //   ),
              // );
            }
            isLoading = false;
            _showNotificationDialog(
                context, json.decode(response.body)['message']);
            //if (response.statusCode==200) Navigator.of(context).pop();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text('Lưu thay đổi'),
              isLoading == true
                  ? Center(child: CircularProgressIndicator())
                  : Text(''),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Đóng'),
        ),
      ],
    );
  }
}
