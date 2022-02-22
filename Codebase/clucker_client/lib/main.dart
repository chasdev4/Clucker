import 'package:clucker_client/pages/signup/signup_page.dart';
import 'package:clucker_client/splash.dart';
import 'package:clucker_client/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clucker',
      theme: ThemeData(
        primarySwatch: Palette.cluckerRed.toMaterialColor(),
        primaryColor: Palette.cluckerRed,
      ),
      home: const TestScreen(),
    );
  }
}

