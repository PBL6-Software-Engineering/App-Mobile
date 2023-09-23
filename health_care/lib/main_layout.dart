import 'package:flutter/material.dart';
import 'package:health_care/screens/appointment_page.dart';
import 'package:health_care/screens/home_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;
  final PageController _page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value) => {
              setState(() {
                currentPage = value;
              })
            }),
        children: const <Widget>[
          HomePage(),
          AppointmentPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.medication_sharp),
              label: 'Chuyên mục',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Đặt bác sĩ',
            ),
          ]),
    );
  }
}
