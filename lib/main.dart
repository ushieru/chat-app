import 'package:flutter/material.dart';
import 'package:stomp_lab/routes/chat_route.dart';
import 'package:stomp_lab/routes/login_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginRoute.routeName: (context) => const LoginRoute(),
          ChatRoute.routeName: (context) => const ChatRoute(),
        },
        initialRoute: LoginRoute.routeName);
  }
}
