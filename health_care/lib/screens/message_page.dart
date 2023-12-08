import 'package:flutter/material.dart';
import 'package:health_care/components/message.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/screens/message_detail_page.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  backgroundColor: Color(0xFF59D4E9)),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('booking-search');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                width: Config.screenWidth! * 0.9,
                decoration: BoxDecoration(
                  color: Config.primaryColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.of(context).pushNamed('booking-search');
                      },
                    ),
                    Text('Tìm kiếm đoạn chat'),
                  ],
                ),
              ),
            ),
            Expanded(child: ListView(
              children: [
                MessageComponent(
                    name: 'Bac si Quoc',
                    avatar:
                        'https://img2.thuthuatphanmem.vn/uploads/2019/01/04/hinh-anh-dep-co-gai-de-thuong_025103410.jpg',
                    lastmessage: 'hello',
                    time: '11:30'),
                MessageComponent(
                    name: 'Bac si Quoc',
                    avatar:
                        'https://img2.thuthuatphanmem.vn/uploads/2019/01/04/hinh-anh-dep-co-gai-de-thuong_025103410.jpg',
                    lastmessage: 'hello',
                    time: '11:30')
              ],
            )
            )
          ])
    ));
  }
}
