import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care/components/history_card.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/utils/config.dart';

class BookingHistoryPage extends StatefulWidget {
  final int index;

  const BookingHistoryPage({Key? key, required this.index}) : super(key: key);

  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = [
    Tab(
      child: Text(
        'Sắp đến (0)',
        style: TextStyle(fontSize: 12.0), // Set the font size
      ),
    ),
    Tab(
      child: Text(
        'Hoàn thành (0)',
        style: TextStyle(fontSize: 12.0), // Set the font size
      ),
    ),
    Tab(
      child: Text(
        'Đặt chỗ',
        style: TextStyle(fontSize: 12.0), // Set the font size
      ),
    ),
  ];

  List<Widget> buildHistoryCards(List<dynamic> dataList, String status,
      {bool isConfirm = false}) {
    return dataList
        .map((data) =>
            HistoryCard(data: data, status: status, isConfirm: isConfirm))
        .toList();
  }

  Future<Map<String, dynamic>> fetchBookingHistory({
    String search = '',
    int paginate = 6,
    int page = 1,
    String is_service = '', // 'advise' OR 'service' OR ''
    String typesort = 'time', // new , name , price , time
    bool sortlatest = true, // true , false
    String start_date = '',
    String end_date = '',
    String status = '',
    String is_confirm = 'both',
  }) async {
    try {
      final response = await HttpProvider().getData(
        'api/work-schedule/user?search=$search&page=$page&paginate=$paginate&sortlatest=$sortlatest&is_service=$is_service&typesort=$typesort&start_date=$start_date&end_date=$end_date&status=$status&is_confirm=$is_confirm',
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final data = responseData['data'];
        print('data $data');
        return data is Map<String, dynamic> ? data : {};
      } else {
        print(
            'Error fetch booking history - Status Code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error fetch booking history: $e');
      return {};
    }
  }

  @override
  void initState() {
    _tabController = TabController(
        length: _tabs.length, vsync: this, initialIndex: widget.index);
    super.initState();
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
        backgroundColor: Config.blueColor,
        title: Text(
          "Lịch sử đặt lịch hẹn",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              controller: _tabController,
              tabs: _tabs,
              labelColor: Config.blueColor,
              indicatorColor: Config.blueColor,
              unselectedLabelColor: Colors.black,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                FutureBuilder<Map<String, dynamic>>(
                  future: fetchBookingHistory(status: 'upcoming'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData ||
                        snapshot.data == null ||
                        (snapshot.data!['data'] as List).isEmpty) {
                      // Display alternative content when there is no data
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/calendar.svg',
                            width: 80.0,
                            height: 80.0,
                          ),
                          Config.spaceSmall,
                          Text(
                            'Không có lịch hẹn sắp đến',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Config.spaceSmall,
                          Text(
                            'Đừng lo lắng. Đặt lịch hẹn với một chuyên gia gần đó',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Update the tab text with the count
                      _tabs[0] = Tab(
                        child: Text(
                          'Sắp đến (${snapshot.data?['total']})',
                          style: TextStyle(
                              fontSize: 12.0), // Set the desired font size
                        ),
                      );
                      return SingleChildScrollView(
                        child: Column(
                          children: buildHistoryCards(
                              snapshot.data?['data'], 'upcoming'),
                        ),
                      );
                    }
                  },
                ),
                FutureBuilder<Map<String, dynamic>>(
                  future:
                      fetchBookingHistory(status: 'complete', is_confirm: '1'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData ||
                        snapshot.data == null ||
                        (snapshot.data!['data'] as List).isEmpty) {
                      // Display alternative content when there is no data
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/calendar.svg',
                            width: 80.0,
                            height: 80.0,
                          ),
                          Config.spaceSmall,
                          Text(
                            'Không có lịch hẹn đã hoàn thành',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Lịch hẹn đã hoàn thành của bạn sẽ xuất hiện ở đây',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Update the tab text with the count
                      _tabs[1] = Tab(
                        child: Text(
                          'Hoàn thành (${snapshot.data?['total']})',
                          style: TextStyle(
                              fontSize: 12.0), // Set the desired font size
                        ),
                      );
                      return SingleChildScrollView(
                        child: Column(
                          children: buildHistoryCards(
                              snapshot.data!['data'], 'complete',
                              isConfirm: true),
                        ),
                      );
                    }
                  },
                ),
                FutureBuilder<Map<String, dynamic>>(
                  future:
                      fetchBookingHistory(status: 'complete', is_confirm: '0'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData ||
                        snapshot.data == null ||
                        (snapshot.data!['data'] as List).isEmpty) {
                      // Display alternative content when there is no data
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/calendar.svg',
                            width: 80.0,
                            height: 80.0,
                          ),
                          Config.spaceSmall,
                          Text(
                            'Không có lịch hẹn đặt chỗ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Hãy đặt lịch hẹn của bạn ngay!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Update the tab text with the count
                      _tabs[2] = Tab(
                        child: Text(
                          'Đặt chỗ ',
                          style: TextStyle(
                              fontSize: 12.0), // Set the desired font size
                        ),
                      );
                      return SingleChildScrollView(
                        child: Column(
                          children: buildHistoryCards(
                              snapshot.data!['data'], 'complete'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
