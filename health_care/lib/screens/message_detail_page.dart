import 'package:flutter/material.dart';
import 'package:health_care/components/message.dart';
import 'package:health_care/utils/config.dart';
//import 'package:health_care/components/button.dart';

class MessageDetail extends StatefulWidget {
  const MessageDetail({Key? key}) : super(key: key);

  @override
  _MessageDetailState createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Chat'),
        // ),
        body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://img2.thuthuatphanmem.vn/uploads/2019/01/04/hinh-anh-dep-co-gai-de-thuong_025103410.jpg'),
                  // Thay bằng avatar của người dùng
                ),
                SizedBox(width: 8),
                Text(
                  'Bac si Quoc', // Thay bằng tên của người dùng
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    // Hành động khi nhấp vào biểu tượng thông tin
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Text('Tin nhắn')
            // child: ListView.builder(
            //   itemCount: 20, // Số lượng tin nhắn
            //   itemBuilder: (BuildContext context, int index) {
            //     return ListTile(
            //       title: Text('Message $index'), // Thay bằng nội dung tin nhắn
            //     );
            //   },
            // ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Nhập tin nhắn...',
                      
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send,
                      color: Config
                          .blueColor), // Thay bằng biểu tượng gửi tin nhắn
                  onPressed: () {
                    // Xử lý logic gửi tin nhắn
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
