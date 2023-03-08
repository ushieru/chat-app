import 'package:flutter/material.dart';
import 'package:stomp_lab/models/message.dart' as model_message;
import 'package:stomp_lab/services/paynal_web_socket_service.dart';

class Message extends StatelessWidget {
  Message(this.message, {super.key});

  final model_message.Message message;
  final paynalWebSocketService = PaynalWebSocketService.getInstance();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment:
            paynalWebSocketService.paynalWebSocket.session == message.from
                ? Alignment.centerRight
                : Alignment.bottomLeft,
        width: double.maxFinite,
        child: Container(
            constraints: const BoxConstraints(maxWidth: 300),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: paynalWebSocketService.paynalWebSocket.session ==
                        message.from
                    ? Colors.blue.shade100
                    : Colors.grey,
                borderRadius: BorderRadius.circular(5)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(message.username,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(message.message),
              )
            ])));
  }
}
