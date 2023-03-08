import 'package:flutter/material.dart';
import 'package:stomp_lab/services/paynal_web_socket_service.dart';
import 'package:stomp_lab/widgets/chat.dart';
import 'package:stomp_lab/widgets/contacts.dart';
import 'package:stomp_lab/models/messages_history.dart';
import 'package:stomp_lab/models/contact.dart';

class ChatRoute extends StatefulWidget {
  const ChatRoute({super.key});

  static const routeName = '/chat-route';

  @override
  State<ChatRoute> createState() => _ChatRouteState();
}

class _ChatRouteState extends State<ChatRoute> {
  List<Contact> contacts = [Contact('general', 'General')];
  Contact currentContact = Contact('general', 'General');
  final messageHistory = MessagesHistory.getInstance();
  final paynalWebSocketService = PaynalWebSocketService.getInstance();

  @override
  void initState() {
    super.initState();

    paynalWebSocketService.setupOnlinePing();

    paynalWebSocketService.subscribeToContact(Contact('general', 'General'),
        (contactSender, message) {
      if (currentContact.id == 'general' && mounted) {
        /// Force Refresh
        setState(() {});
      }
    });

    paynalWebSocketService.setupNewContactOnline((newContact) {
      paynalWebSocketService.subscribeToContact(newContact,
          (contactSender, message) {
        if ((message.from == currentContact.id ||
                message.to == currentContact.id) &&
            mounted) {
          /// Force Refresh
          setState(() {});
        }
      });
      if (newContact.id != paynalWebSocketService.paynalWebSocket.session) {
        setState(() => contacts.add(newContact));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = messageHistory.getMessages(currentContact);
    return Scaffold(
        body: Row(children: [
      Container(
        color: Colors.blue,
        width: 250,
        height: double.maxFinite,
        child: Contacts(
            (newCurrentContact) =>
                setState(() => currentContact = newCurrentContact),
            contacts),
      ),
      Expanded(child: Chat(currentContact, messages))
    ]));
  }
}
