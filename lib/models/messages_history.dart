import 'package:stomp_lab/models/contact.dart';
import 'package:stomp_lab/models/message.dart';

class MessagesHistory {
  static MessagesHistory? _messagesHistory;

  final Map<String, List<Message>> _messages = {};

  MessagesHistory._();

  factory MessagesHistory.getInstance() {
    return _messagesHistory ??= MessagesHistory._();
  }

  List<Message> getMessages(Contact contact) {
    return _messages[contact.id] ?? [];
  }

  void addMessage(String toContact, Message message) {
    if (!_messages.containsKey(toContact)) _messages[toContact] = [];
    _messages[toContact]!.insert(0, message);
  }
}
