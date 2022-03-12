import 'package:flutter/material.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/screens/feed_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clucker',
      theme: ThemeData(
        primarySwatch: Palette.cluckerRed.toMaterialColor(),
        primaryColor: Palette.cluckerRed,
      ),
      home: const LoginPage(),
    );
  }
}

