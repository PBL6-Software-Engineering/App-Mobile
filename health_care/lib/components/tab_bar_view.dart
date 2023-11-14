import 'package:flutter/material.dart';
import 'package:health_care/components/time_picker_field.dart';
import 'package:health_care/utils/config.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);
  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  List<String> morningTimes = [];
  List<String> eveningTimes = [];
  List<String> nightTimes = [];

  List<Widget> myTabViews = [];

  late List<Tab> myTabs;

  @override
  void initState() {
    super.initState();

    morningTimes = [
      '08:00 - 08:30',
      '08:30 - 09:00',
      '09:00 - 09:30',
      '09:30 - 10:00',
      '10:00 - 10:30',
      '10:30 - 11:00',
      '11:00 - 11:30',
      '11:30 - 12:00',
    ];

    eveningTimes = [
      '13:00 - 13:30',
      '13:30 - 14:00',
      '14:00 - 14:30',
      '14:30 - 15:00',
      '15:00 - 15:30',
      '15:30 - 16:00',
      '16:00 - 16:30',
      '16:30 - 17:00',
    ];

    nightTimes = [];

    myTabs = <Tab>[
      Tab(
        child: Text(
          'Sáng (${morningTimes.length})',
          style: TextStyle(fontSize: 18),
        ),
      ),
      Tab(
        child: Text(
          'Chiều (${eveningTimes.length})',
          style: TextStyle(fontSize: 18),
        ),
      ),
      Tab(
        child: Text(
          'Tối (${nightTimes.length})',
          style: TextStyle(fontSize: 18),
        ),
      )
    ];

    myTabViews = [
      TimePickerField(times: morningTimes),
      TimePickerField(times: eveningTimes),
      TimePickerField(times: nightTimes),
    ];

    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
        backgroundColor: Color(0xffE7F7FA),
        elevation: 0,
        bottom: TabBar(
          labelColor: Config.lightBlueColor,
          unselectedLabelColor: Colors.black,
          tabs: myTabs,
          controller: _tabController,
          isScrollable: true,
          labelPadding: EdgeInsets.symmetric(horizontal: 30),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 5,
              color: Config.lightBlueColor,
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xffE7F7FA),
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: TabBarView(
          controller: _tabController,
          children: myTabViews,
        ),
      ),
    );
  }
}

class KeepAliveWrapper extends StatefulWidget {
  final Widget child;
  const KeepAliveWrapper(this.child);

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
