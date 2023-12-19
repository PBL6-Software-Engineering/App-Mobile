import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/providers/chat_service.dart';
import 'package:health_care/utils/api_constant.dart';
import 'package:health_care/utils/config.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessageDetail extends StatefulWidget {
  final Map<String, dynamic> conversation;

  MessageDetail({
    required this.conversation,
  });

  @override
  _MessageDetailState createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  bool isLoading = true;
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://backend-chat-socket-production.up.railway.app:443'),
  );

  // String linkSocket = ApiConstant.linkSocket;

  Future<void> fetchMessages() async {
    try {
      // Fetch messages
      final dynamic messageData = await ChatService()
          .getMessages(widget.conversation['conversationId']);

      if (messageData != null && messageData.containsKey('data')) {
        final loadedMessages = messageData['data'];

        if (loadedMessages is Map<String, dynamic>) {
          final messagesList = loadedMessages['messages'];

          if (messagesList is List) {
            final typedMessages = List<Map<String, dynamic>>.from(messagesList);

            setState(() {
              _messages = typedMessages;
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            throw Exception('Invalid data format for messages');
          }
        } else {
          // Handle unexpected data format
          setState(() {
            isLoading = false;
          });
          throw Exception('Invalid data format for messages');
        }
      } else {
        // Handle missing 'data' property
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load messages - Invalid response format');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error in fetchMessages: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> sendMessage(String messageText) async {
    try {
      if (messageText.trim().isNotEmpty) {
        // Prepare the message object
        final Map<String, dynamic> msgSocket = {
          'user': widget.conversation['user'],
          'admin': widget.conversation['admin'],
          'conversationId': widget.conversation['conversationId'],
          'message': messageText,
          'isUserSend': true,
        };

        // Convert the message object to a JSON string
        var payload = {'event': 'message', 'data': jsonEncode(msgSocket)};

        // Send message through WebSocket
        _channel.sink.add(payload);

        print('Message sent successfully: $msgSocket');

        setState(() {
          // Add the message to the local messages list
          _messages.add(msgSocket);
          _textController.clear();
        });
      } else {
        _textController.clear();
      }
    } catch (e) {
      // Handle any exceptions
      print('Error in sendMessage: $e');
    }
  }

  void handleIncomingMessage(dynamic message) {
    try {
      // Parse the incoming message
      print('Received Message: $message');

      final Map<String, dynamic> msgSocket = jsonDecode(message);

      // Check if the conversationId matches the current conversation
      if (msgSocket['conversationId'] ==
          widget.conversation['conversationId']) {
        setState(() {
          // Add the message to the local messages list
          _messages.add(msgSocket);
        });
      }
    } catch (e) {
      print('Error handling incoming message: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMessages();

    // Listen for incoming messages
    _channel.stream.listen(
      (message) {
        print('Received raw message: $message'); // Add this line for debugging
        handleIncomingMessage(message);
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
      onDone: () {
        print('WebSocket connection closed');
      },
    );
    // Add this closing parenthesis
  }

  @override
  void dispose() {
    // Close the WebSocket channel when the widget is disposed
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.lightBlueColor,
        elevation: 1,
        title: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.conversation['admin']
                        ['avatar'] ??
                    'https://img2.thuthuatphanmem.vn/uploads/2019/01/04/hinh-anh-dep-co-gai-de-thuong_025103410.jpg'),
              ),
              SizedBox(width: 8),
              Text(
                widget.conversation['admin']['name'] ?? 'Đang cập nhật',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  // Handle action when tapping the info icon
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 8.0,
            bottom: 8.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    // print('MESSAGE: ${message}');

                    // Add null checks for isUserSend and isAdminSend
                    final isUserSend = message['isUserSend'] ?? false;
                    final isAdminSend = message['isAdminSend'] ?? false;

                    return Row(
                      mainAxisAlignment: isUserSend
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        if (isAdminSend)
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(widget
                                    .conversation['admin']['avatar'] ??
                                'https://img2.thuthuatphanmem.vn/uploads/2019/01/04/hinh-anh-dep-co-gai-de-thuong_025103410.jpg'),
                          ),
                        Config.gapSmall,
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: (isUserSend)
                                ? Colors.blue.shade500
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            message['message'],
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign:
                                (isUserSend) ? TextAlign.right : TextAlign.left,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // TODO: Send an image
                    },
                    icon: Icon(Icons.attach_file),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: 'Nhập tin nhắn...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            String message = _textController.text.trim();
                            if (message.isNotEmpty) {
                              sendMessage(message);
                            }
                          },
                          icon: Icon(Icons.send),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
