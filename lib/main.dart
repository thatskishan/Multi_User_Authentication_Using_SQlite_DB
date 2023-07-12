import 'package:flutter/material.dart';
import 'package:multi_user_app/view/screen/login_screen.dart';
import 'package:multi_user_app/view/screen/sign_up.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff3C37FF),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Login(),
        'sign_up': (context) => const SignUp(),
      },
    ),
  );
}
