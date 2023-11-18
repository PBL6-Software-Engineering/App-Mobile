import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/user.dart';

class UserInfoPage extends StatefulWidget {
  final User user;
  const UserInfoPage({required this.user});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  bool isEditing = false;

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
    if (isEditing) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return UserProfileFormDialog(
            onSaveChanges: () {
              // Xử lý sự kiện khi nhấn vào button "Lưu thay đổi"
              setState(() {
                isEditing = false;
              });
              Navigator.of(context).pop();
            },
            onCancel: () {
              // Xử lý sự kiện khi nhấn vào button "Huỷ"
              setState(() {
                isEditing = false;
              });
              Navigator.of(context).pop();
            },
            user: widget.user,
          );
        },
      );
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
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Center(
            child: widget.user.avatar != ''
                ? CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(widget.user.avatar),
                  )
                : CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/user.jpeg'),
                  ),
          ),
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
          UserInfoItem(label: 'Số Điện Thoại', value: widget.user.phone),
          UserInfoItem(label: 'Email', value: widget.user.email),
          UserInfoItem(
              label: 'Giới Tính', value: widget.user.gender.toString()),
          UserInfoItem(label: 'Ngày Sinh', value: widget.user.dateofbirth),
          UserInfoItem(label: 'Địa chỉ', value: widget.user.address),
          SizedBox(height: 32.0),
          // Button "Chỉnh sửa thông tin"
          Center(
            child: 
            ElevatedButton(
              onPressed:
                _toggleEdit
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
  final VoidCallback onSaveChanges;
  final VoidCallback onCancel;
  final User user;

  UserProfileFormDialog({required this.onSaveChanges, required this.onCancel, required this.user});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Set the initial values of the text fields
    nameController.text = user.name;
    phoneController.text = user.phone;
    emailController.text = user.email;
    genderController.text = user.gender.toString();
    addressController.text = user.address;
    dobController.text = user.dateofbirth;

    return AlertDialog(
      title: Text('Chỉnh sửa thông tin'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Tên',
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Số điện thoại',
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: genderController,
            decoration: InputDecoration(
              labelText: 'Giới tính',
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Địa chỉ',
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: dobController,
            decoration: InputDecoration(
              labelText: 'Ngày sinh',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: onSaveChanges,
          child: Text('Lưu thay đổi'),
        ),
        TextButton(
          onPressed: onCancel,
          child: Text('Huỷ'),
        ),
      ],
    );
  }
}
