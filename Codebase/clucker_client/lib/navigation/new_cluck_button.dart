import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewCluckButton extends StatelessWidget {
  const NewCluckButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          child: Icon(
            FontAwesomeIcons.plusCircle,
            size: 80,
            color: Palette.cluckerRed,
          ),
          elevation: 0,

          tooltip: 'New Cluck'),
    );
  }
}
