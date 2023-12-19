import 'dart:convert';

import 'package:health_care/providers/auth_manager.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/utils/api_constant.dart';
import 'package:http/http.dart' as http;

// Replace with your chat API link

class ChatService {
  // final BehaviorSubject<Map<String, dynamic>> _conversation =
  //     BehaviorSubject<Map<String, dynamic>>();
  // Observable<Map<String, dynamic>> get conversation => _conversation.stream;

  // IO.Socket socket;
  // final http.Client _httpClient = http.Client();

  // ChatService() {
  //   socket = IO.io('your_socket_server_url', <String, dynamic>{
  //     'transports': ['websocket'],
  //     'autoConnect': false,
  //   });

  //   socket.connect();
  // }
  String linkApiChat = ApiConstant.linkApiChat;
  final HttpProvider _httpProvider = HttpProvider();

  Future<Map<String, dynamic>> getConversations(String id,
      {String type = 'user'}) async {
    try {
      final response = await _httpProvider
          .getMessageData('$linkApiChat/conversations?id=$id&type=$type');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to load conversations - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in getConversations: $e');
      throw Exception('Failed to load conversations - $e');
    }
  }

  Future<Map<String, dynamic>> getMessages(
    String conversationId, {
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _httpProvider.getMessageData(
        '$linkApiChat/messages?conversationId=$conversationId&skip=$skip&limit=$limit',
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load messages - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in getMessages: $e');
      throw Exception('Failed to load messages - $e');
    }
  }

  // void sendMessage(Map<String, dynamic> msg) {
  //   socket.emit('message', msg);
  // }

  // Stream<Map<String, dynamic>> getMessageSocket() {
  //   return Observable(socket.on('message')).map((data) => data[0]);
  // }

  // Stream<Map<String, dynamic>> getConversationSocket() {
  //   return Observable(socket.on('conversation')).map((data) => data[0]);
  // }

  // void setConversation(Map<String, dynamic> conversation) {
  //   _conversation.add(conversation);
  // }

  // Observable<Map<String, dynamic>> getConversation() {
  //   return conversation;
  // }
}
