import 'package:flutter/material.dart';
import 'package:health_care/screens/appointment_page.dart';
import 'package:health_care/screens/home_page.dart';
import 'package:health_care/screens/message_page.dart';
import 'package:health_care/screens/setting_page.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/screens/article_page.dart';
import 'package:health_care/objects/user.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;
  final PageController _page = PageController();
  UserService userservice = UserService();
  bool loading = true;
  User user = User(
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
    fetchUser();
  }

  void updateUser(User updatedUser) {
    setState(() {
      user = updatedUser;
    });
  }

  void fetchUser() async {
    try {
      loading = true;
      user = await userservice.fetchUser();
      setState(() {
        loading = false;
      });
      //print(hospitals);
    } catch (e) {
      print('Error fetch user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: <Widget>[
          HomePage(user: user),
          MessagePage(),
          AppointmentPage(),
          SettingPage(user: user, onUpdateUser: updateUser),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _page.animateToPage(page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Tin nhắn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication_sharp),
            label: 'Đặt lịch hẹn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }
}
