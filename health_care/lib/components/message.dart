import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/screens/message_detail_page.dart';


class MessageComponent extends StatelessWidget {
  final name;
  final avatar;
  final lastmessage;
  final time;
  MessageComponent(
      {required this.name,
      required this.avatar,
      required this.lastmessage,
      required this.time});
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MessageDetail(),
            ),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(avatar),
          ),
          title: Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  lastmessage,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  time,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ));
  }
}
