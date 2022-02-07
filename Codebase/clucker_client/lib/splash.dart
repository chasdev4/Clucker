import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(
            image: AssetImage('assets/icons/clucker-icon.png'),
            width: 256,
            height: 256,
          ),
          Text(
            "Clucker",
            style:
                TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w900
                ),
          )
        ],
      ),
    );
  }
}
