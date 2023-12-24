import 'package:flutter/material.dart';
import 'package:health_care/screens/appointment_page.dart';
import 'package:health_care/screens/home_page.dart';
import 'package:health_care/screens/message_page.dart';
import 'package:health_care/screens/setting_page.dart';
import 'package:health_care/utils/config.dart';

class MainLayout extends StatefulWidget {
  final int initialPageIndex;

  const MainLayout({
    Key? key,
    required this.initialPageIndex,
  }) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int currentPage;
  late PageController _pageController;
  final List<Widget> pages = [
    HomePage(),
    MessagePage(),
    AppointmentPage(),
    SettingPage(),
  ];

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPageIndex;
    _pageController = PageController(initialPage: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _pageController.animateToPage(
              page,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
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
