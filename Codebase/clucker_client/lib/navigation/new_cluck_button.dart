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
    return SizedBox(
      height: 80,
      width: 80,
      child: getKeyboardState() ? FloatingActionButton(
              backgroundColor: Palette.white,
              onPressed: () {
                setState(() {});
              },
              child: Icon(
                FontAwesomeIcons.plusCircle,
                size: 80,
                color: Palette.cluckerRed,
              ),
              elevation: 0,
              tooltip: 'New Cluck') : null,
    );
  }
}
