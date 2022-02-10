import 'package:clucker_client/splash.dart';
import 'package:clucker_client/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/palette.dart';

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
        primarySwatch: cluckerRed,
        primaryColor: cluckerRed.shade900,
      ),
      home: const TestScreen(),
    );
  }
}

