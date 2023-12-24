import 'package:flutter/material.dart';
import 'package:health_care/objects/user.dart';
import 'package:health_care/providers/auth_manager.dart';
import 'package:health_care/providers/chat_service.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/screens/message_detail_page.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late Future<User> userData;
  List<Map<String, dynamic>> conversations = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchConversations();
  }

  Future<void> fetchConversations() async {
    try {
      // Fetch user data
      userData = AuthManager.fetchUser();

      // Wait for the user data to be available
      final user = await userData;

      // Check if ChatService().getConversations(user.id) has data
      final chatData = await ChatService().getConversations(user.id.toString());

      if (chatData != null && chatData.containsKey('data')) {
        // Access the 'data' property of chatData
        final loadedConversations = chatData['data'];

        // Explicitly cast each element to Map<String, dynamic>
        final typedConversations =
            List<Map<String, dynamic>>.from(loadedConversations);

        // Update the state using setState
        setState(() {
          conversations = typedConversations;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = true;
        });
        throw Exception(
            'Failed to load conversations - Invalid response format');
      }
    } catch (e) {
      print('Error in fetchConversations: $e');
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Đoạn chat'),
        backgroundColor: Config.blueColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).pushNamed('booking-search');
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 5.0),
            //     width: Config.screenWidth! * 0.9,
            //     decoration: BoxDecoration(
            //       color: Config.primaryColor.withOpacity(.1),
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     child: Row(
            //       children: [
            //         IconButton(
            //           icon: Icon(Icons.search),
            //           onPressed: () {
            //             Navigator.of(context).pushNamed('booking-search');
            //           },
            //         ),
            //         Text('Tìm kiếm đoạn chat'),
            //       ],
            //     ),
            //   ),
            // ),

            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: Future.value(conversations),
                  builder: (context, snapshot) {
                    if (isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.data != null) {
                      List<Map<String, dynamic>> conversationData =
                          snapshot.data!;
                      // Process the conversationData and update your UI
                      return ListView.builder(
                        itemCount: conversationData.length,
                        itemBuilder: (context, index) {
                          final conversation = conversationData[index];
                          final name =
                              conversation['admin']['name'] ?? "Người tư vấn";
                          final avatar = conversation['admin']['avatar'];
                          final lastMessage = conversation['lastMessage'];
                          final time = conversation['updatedAt'];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MessageDetail(
                                    conversation: conversation,
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(avatar)),
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
                                    flex: 1,
                                    child: Text(
                                      lastMessage,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      Config().formatTimeAgo(time),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                          child: Text('Không có cuộc trò chuyện nào!'));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
