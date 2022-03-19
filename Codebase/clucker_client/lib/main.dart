import 'package:clucker_client/navigation/home.dart';
import 'package:clucker_client/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = const FlutterSecureStorage();
  bool loggedIn = false;
  late String? token = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              throw Exception('${snapshot.error}: ${snapshot.stackTrace}');
            } else if (snapshot.hasData) {
              return MaterialApp(
                title: 'Clucker',
                theme: ThemeData(
                  primarySwatch: Palette.cluckerRed.toMaterialColor(),
                  primaryColor: Palette.cluckerRed,
                ),
                home: loggedIn ? const Home() : const LoginPage(),
              );
            }
          }

          return const Center(
             child: CircularProgressIndicator(strokeWidth: 5),
           );
        },
        future: getLoginStatus());

  }

  Future<Object?> getLoginStatus() async {
    token = await storage.read(key: 'authorization');

    if (token != null && token!.startsWith('Bearer')) {
      loggedIn = true;
    }
      return loggedIn;

  }
}

