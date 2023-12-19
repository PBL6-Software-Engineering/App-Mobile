// import 'package:flutter/material.dart';

// class MessageBubble extends StatelessWidget {
//   final Message message;

//   const MessageBubble({Key? key, required this.message}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 4),
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color:
//             message.senderUserId == 'yourUserId' ? Colors.blue : Colors.green,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         message.content,
//         style: TextStyle(
//           color: Colors.white,
//         ),
//         textAlign: message.senderUserId == 'yourUserId'
//             ? TextAlign.right
//             : TextAlign.left,
//       ),
//     );
//   }
// }

// class Message {
//   final String senderUserId;
//   final String content;

//   Message({required this.senderUserId, required this.content});
// }
