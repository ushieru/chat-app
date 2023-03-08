import 'dart:async';

import 'package:paynal/paynal.dart';
import 'package:stomp_lab/models/contact.dart';
import 'package:stomp_lab/models/message.dart';
import 'package:stomp_lab/models/messages_history.dart';

class PaynalWebSocketService {
  PaynalWebSocketService._(this.username)
      : paynalWebSocket =
            PaynalWebSocket('ws://127.0.0.1:15674/ws', 'guest', 'guest');

  factory PaynalWebSocketService.getInstance(
      {String? username = '00_paynal_00'}) {
    return _paynalWebSocketService ??= PaynalWebSocketService._(username!);
  }

  static PaynalWebSocketService? _paynalWebSocketService;
  final PaynalWebSocket paynalWebSocket;
  final messageHistory = MessagesHistory.getInstance();
  final String username;
  final List<String> newContactIds = [];
  final List<String> subscriptionsIds = [];
  Timer? onlinePing;

  void sendMessage(Contact contactReceiver, String body) {
    paynalWebSocket.send('/topic/chat-${contactReceiver.id}',
        headers: {
          "content-type": "text/plain",
          'from': paynalWebSocket.session,
          'to': contactReceiver.id,
          'username': username
        },
        body: body);
  }

  void setupOnlinePing() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      onlinePing = timer;
      paynalWebSocket.send('/topic/users', headers: {
        "content-type": "text/plain",
        'username': username,
        'id': paynalWebSocket.session
      });
    });
  }

  void setupNewContactOnline(void Function(Contact newContact) callback) {
    paynalWebSocket.subscribe('/topic/users', (frame) {
      final id = frame.headers['id']!;
      final username = frame.headers['username']!;
      final contact = Contact(id, username);
      if (newContactIds.contains(id)) return;
      newContactIds.add(id);
      callback(contact);
    });
  }

  void subscribeToContact(Contact contact,
      void Function(Contact contactSender, Message message) callback) {
    final topic = '/topic/chat-${contact.id}';
    if (subscriptionsIds.contains(topic)) return;
    paynalWebSocket.subscribe(topic, (frame) {
      final from = frame.headers['from']!;
      final to = frame.headers['to']!;
      final username = frame.headers['username']!;
      final newMessage = Message(from, username, to, frame.body);
      final idHistoryContact = to == paynalWebSocket.session ? from : to;
      messageHistory.addMessage(idHistoryContact, newMessage);
      callback(Contact(from, username), newMessage);
    });
    subscriptionsIds.add(topic);
  }
}
