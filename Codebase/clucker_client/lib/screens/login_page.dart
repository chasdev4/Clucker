import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget> [
              Image(
                image: AssetImage(
                    'assets/icons/clucker_logo_256x256.png'
                ),
              ),
              Text(
                'Clucker',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 45,
                  fontWeight: FontWeight.w700,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
