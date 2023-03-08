import 'package:flutter/material.dart';
import 'package:stomp_lab/services/paynal_web_socket_service.dart';
import 'package:stomp_lab/routes/chat_route.dart';

class LoginRoute extends StatelessWidget {
  const LoginRoute({super.key});

  static const routeName = '/login-route';

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: double.maxFinite,
            height: double.maxFinite,
            child: SizedBox(
                height: 200,
                width: 400,
                child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Form(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                              TextFormField(
                                  controller: usernameController,
                                  decoration: const InputDecoration(
                                      hintText: 'Username')),
                              ElevatedButton(
                                  onPressed: () {
                                    PaynalWebSocketService.getInstance(
                                        username: usernameController.text);
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        ChatRoute.routeName, (route) => false);
                                  },
                                  child: const Text('submit'))
                            ])))))));
  }
}
