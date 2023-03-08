import 'package:flutter/material.dart';
import 'package:stomp_lab/models/contact.dart' as model;

class Contact extends StatelessWidget {
  const Contact(this.contact, this.setCurrentContact, {super.key});

  final void Function(model.Contact) setCurrentContact;
  final model.Contact contact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.maxFinite,
        height: 40,
        child: ElevatedButton(
            onPressed: () => setCurrentContact(contact),
            child: Row(children: [
              CircleAvatar(child: Text(contact.username[0])),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(contact.username)))
            ])));
  }
}
