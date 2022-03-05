import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewCluckButton extends StatefulWidget {
  const NewCluckButton({Key? key}) : super(key: key);

  @override
  _NewCluckButtonState createState() => _NewCluckButtonState();
}

class _NewCluckButtonState extends State<NewCluckButton> {
  bool getKeyboardState() {
    return (MediaQuery.of(context).viewInsets.bottom == 0 ||
        (MediaQuery.of(context).viewInsets.bottom > 0 &&
            MediaQuery.of(context).viewInsets.bottom <
                MediaQuery.of(context).size.height / 36));
  }

  @override
  Widget build(BuildContext context) {
    double size = 75;
    return SizedBox(
      height: size,
      width: size,
      child: getKeyboardState()
          ? FloatingActionButton(
              backgroundColor: Palette.white,
              onPressed: () {},
              child: Transform.scale(scale: 1.17, child:Icon(
                FontAwesomeIcons.plusCircle,
                size: size,
                color: Palette.cluckerRed,
              ),),
              elevation: 0,
              tooltip: 'New Cluck')
          : null,
    );
  }
}
