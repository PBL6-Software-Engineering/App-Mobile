import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/providers/auth_intercetor.dart';
import 'package:health_care/providers/auth_manager.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/screens/user_info.dart';
import 'package:health_care/utils/config.dart';

class SettingPage extends StatelessWidget {
  Future<void> _logOut(BuildContext context) async {
    try {
      var res = await HttpProvider().getData('api/user/logout');
      var body = json.decode(res.body);

      if (res.statusCode == 200) {
        AuthManager.clearToken();
        MessageDialog.showSuccess(context, body['message']);
        Navigator.of(context).pushNamed('login');
      } else {
        MessageDialog.showError(context, body['message']);
      }
    } catch (error) {
      MessageDialog.showError(context, "Đã xảy ra lỗi khi đăng xuất.");
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 35, bottom: 10, right: 20, left: 20),
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
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/user_avatar.png'),
                    radius: 25,
                  ),
                  Config.gapSmall,
                  Column(
                    children: <Widget>[
                      Text(
                        'Tên Người Dùng',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UserInfoPage(),
                                ),
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Thông tin cá nhân',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.schedule,
                                        size: 60.0, color: Colors.blue),
                                    Text('Sắp đến',
                                        style: TextStyle(fontSize: 16.0)),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.cancel,
                                        size: 60.0, color: Colors.red),
                                    Text('Đã huỷ',
                                        style: TextStyle(fontSize: 16.0)),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.list,
                                        size: 60.0, color: Colors.green),
                                    Text('Tất cả',
                                        style: TextStyle(fontSize: 16.0)),
                                  ],
                                ),
                              ],
                            ),
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
                  const ListTile(
                    leading: Icon(Icons.language),
                    title: Text('Ngôn ngữ'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  const ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Thông báo'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  const ListTile(
                    leading: Icon(Icons.security),
                    title: Text('Bảo mật'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Đăng xuất'),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () async {
                      await _logOut(context);
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
