import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EndCard extends StatelessWidget {
  const EndCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width -
          MediaQuery.of(context).size.width / 5,
      child: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.egg,
                  size: 100,
                  color: Palette.cluckerRed.toMaterialColor().shade200),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'You\'ve reached the end!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Palette.offBlack.toMaterialColor().shade100,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                    maxLines: 2,
                  )),
            ]),
      ),
    );
  }
}
