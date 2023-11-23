import 'package:flutter/material.dart';
import 'package:health_care/components/time_picker_field.dart';
import 'package:health_care/utils/config.dart';

class TabBarScreen extends StatefulWidget {
  final Map<String, dynamic> dayNameData;
  final Function(List<dynamic>) onIntervalSelected;

  const TabBarScreen(
      {Key? key, required this.dayNameData, required this.onIntervalSelected})
      : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  List<dynamic> selectedInterval = [];

  @override
  void initState() {
    super.initState();

    List<List<String>> getDividedTimes(
        Map<String, dynamic> dayData, String timeOfDay) {
      List<List<String>> dividedTimes = [];

      if (dayData != null &&
          dayData[timeOfDay] != null &&
          dayData[timeOfDay]['divided_times'] != null) {
        var timesData = dayData[timeOfDay]['divided_times'];
        if (timesData is List) {
          for (var timeRange in timesData) {
            if (timeRange is List && timeRange.length == 2) {
              dividedTimes.add(List<String>.from(timeRange));
            }
          }
        }
      }

      return dividedTimes;
    }

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
        backgroundColor: Color(0xffE7F7FA),
        elevation: 0,
        bottom: TabBar(
          tabs: [
            Tab(
              child: Text(
                'Sáng (${widget.dayNameData?['morning']?['divided_times']?.length ?? 0})',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Tab(
              child: Text(
                'Chiều (${widget.dayNameData['afternoon']?['divided_times']?.length ?? 0})',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Tab(
              child: Text(
                'Tối (${widget.dayNameData['night']?['divided_times']?.length ?? 0})',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
          controller: _tabController,
          isScrollable: true,
          labelPadding: EdgeInsets.symmetric(horizontal: 30),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 5,
              color: Colors.blue, // Adjust color as needed
            ),
          ),
          indicatorColor: Colors.blue,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TimePickerField(
            times: widget.dayNameData.isNotEmpty
                ? widget.dayNameData['morning']['divided_times']
                : [],
            onIntervalSelected: (interval) {
              setState(() {
                selectedInterval = interval;
                widget.onIntervalSelected(selectedInterval);
              });
            },
          ),
          TimePickerField(
            times: widget.dayNameData.isNotEmpty
                ? widget.dayNameData['afternoon']['divided_times']
                : [],
            onIntervalSelected: (interval) {
              setState(() {
                selectedInterval = interval;
                widget.onIntervalSelected(selectedInterval);
              });
            },
          ),
          TimePickerField(
            times: widget.dayNameData.isNotEmpty
                ? widget.dayNameData['night']['divided_times']
                : [],
            onIntervalSelected: (interval) {
              setState(() {
                selectedInterval = interval;
                widget.onIntervalSelected(selectedInterval);
              });
            },
          ),
        ],
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
