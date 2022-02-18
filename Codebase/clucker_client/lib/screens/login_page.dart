import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Clucker',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Column(
              children: const <Widget> [
                SizedBox(
                  height: 25,
                ),
                CircleAvatar(
                  radius: 125,
                  backgroundImage: AssetImage('assets/icons/clucker_logo_1024x1024.png'),
                ),
                Text('Login'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
