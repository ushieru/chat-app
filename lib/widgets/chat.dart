import 'package:flutter/material.dart';
import 'package:stomp_lab/services/paynal_web_socket_service.dart';
import 'package:stomp_lab/models/contact.dart' as model_contact;
import 'package:stomp_lab/models/message.dart' as model_message;
import 'package:stomp_lab/widgets/message.dart';

class Chat extends StatelessWidget {
  Chat(this.contact, this.messages, {super.key});

  final model_contact.Contact contact;
  final List<model_message.Message> messages;
  final paynalWebSocketService = PaynalWebSocketService.getInstance();

  @override
  Widget build(BuildContext context) {
    final msgController = TextEditingController();
    return Column(children: [
      Container(
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        width: double.maxFinite,
        height: 50,
        color: Colors.blue,
        child: Text(contact.username,
            style: const TextStyle(color: Colors.white, fontSize: 20)),
      ),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) => Message(messages[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 5)),
      )),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: Row(children: [
          Expanded(child: TextFormField(controller: msgController)),
          const SizedBox(width: 20),
          ElevatedButton(
              onPressed: () {
                if (msgController.text.isEmpty) return;
                paynalWebSocketService.sendMessage(contact, msgController.text);
              },
              child: const Icon(Icons.send))
        ])),
      )
    ]);
  }
}
