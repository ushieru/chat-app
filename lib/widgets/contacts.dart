import 'package:flutter/material.dart';
import 'package:stomp_lab/widgets/contact.dart';
import 'package:stomp_lab/models/contact.dart' as model;

class Contacts extends StatelessWidget {
  const Contacts(this.setCurrentContact, this.contacts, {super.key});

  final void Function(model.Contact) setCurrentContact;
  final List<model.Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const SizedBox(height: 100),
      for (var c in contacts) Contact(c, setCurrentContact)
    ]);
  }
}
