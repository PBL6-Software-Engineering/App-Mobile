import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/providers/auth_intercetor.dart';
import 'package:health_care/providers/auth_manager.dart';
import 'package:health_care/providers/google_sign_in.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/screens/booking_history_page.dart';
import 'package:health_care/screens/user_info.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/objects/user.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  SettingPage({
    Key? key,
  }) : super(key: key);
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with ChangeNotifier {
  User user = AuthManager.getUser();
  File? avatar;
  void initState() {
    super.initState();
    //onUpdateUser : updateUser(widget.user);
    //widget.onUpdateUser(widget.user);
  }

  void dispose() {
    // Gọi hàm performActionOnHomePage khi thoát khỏi trang settingpage
    super.dispose();
  }

  void updateUser(User updatedUser) {
    setState(() {
      user = updatedUser;
    });
  }

  void updateAvatar(File file) {
    setState(() {
      avatar = file;
    });
  }

  Future<void> _logOut(BuildContext context) async {
    final token = AuthManager.getToken();
    print('Token Logout: $token');

    if (token != null) {
      MessageDialog.showSuccess(context, 'Đăng xuất thành công!');
      AuthManager.clearToken();
      AuthManager.setUser(User(
          id: 0,
          name: '',
          email: '',
          phone: '',
          gender: 0,
          dateOfBirth: '',
          address: '',
          username: '',
          avatar: ''));
    } else {
      MessageDialog.showError(context, 'Bạn chưa đăng nhập!');
    }
    Navigator.of(context).pushNamed('login');
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: AuthManager.getToken() == null
          ? Center(
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện khi nhấn nút Đăng nhập
                  Navigator.of(context).pushNamed('login');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: 35, bottom: 10, right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        user.avatar != ''
                            ? CircleAvatar(
                                radius: Config.screenWidth! * 0.1,
                                backgroundImage: avatar != null
                                    ? FileImage(avatar!)
                                        as ImageProvider<Object>?
                                    : NetworkImage(user.avatar),
                              )
                            : CircleAvatar(
                                radius: Config.screenWidth! * 0.1,
                                backgroundImage: avatar != null
                                    ? FileImage(avatar!)
                                        as ImageProvider<Object>?
                                    : AssetImage('assets/images/user.jpeg'),
                              ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Config.gapSmall,

                            Text(
                              '  ${user.name}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow
                                  .ellipsis, // Hiển thị dấu "..." nếu text quá dài
                              maxLines: 1,
                            ),
                            // Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // children: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UserInfoPage(
                                        user: user,
                                        onUpdateUser: updateUser,
                                        onUpdateAvatar: updateAvatar),
                                  ),
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Thông tin cá nhân',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                  ),
                                ],
                              ),
                            ),
                            //],
                            //),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Config.blueColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      'Lịch sử đặt lịch hẹn',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BookingHistoryPage(
                                                index:
                                                    0, // Use 'index' instead of 'idex'
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.schedule,
                                                size: 60.0, color: Colors.blue),
                                            Text('Sắp đến',
                                                style:
                                                    TextStyle(fontSize: 16.0)),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BookingHistoryPage(
                                                index:
                                                    1, // Use 'index' instead of 'idex'
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.check_circle,
                                                size: 60.0,
                                                color: Colors.green),
                                            Text('Hoàn thành',
                                                style:
                                                    TextStyle(fontSize: 16.0)),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BookingHistoryPage(
                                                index:
                                                    2, // Use 'index' instead of 'idex'
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.list,
                                                size: 60.0,
                                                color: Colors.black),
                                            Text('Tất cả',
                                                style:
                                                    TextStyle(fontSize: 16.0)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // const ListTile(
                        //   leading: Icon(Icons.language),
                        //   title: Text('Ngôn ngữ'),
                        //   trailing: Icon(Icons.keyboard_arrow_right),
                        // ),
                        // const ListTile(
                        //   leading: Icon(Icons.notifications),
                        //   title: Text('Thông báo'),
                        //   trailing: Icon(Icons.keyboard_arrow_right),
                        // ),
                        // const ListTile(
                        //   leading: Icon(Icons.security),
                        //   title: Text('Bảo mật'),
                        //   trailing: Icon(Icons.keyboard_arrow_right),
                        // ),
                        ListTile(
                          leading: const Icon(Icons.exit_to_app),
                          title: const Text('Đăng xuất'),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () async {
                            await _logOut(context);
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            provider.googleLogout();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
