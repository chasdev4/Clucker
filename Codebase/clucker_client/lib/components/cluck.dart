import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EggControls extends StatefulWidget {
  const EggControls({Key? key, this.buttonSize = 25}) : super(key: key);

  final double buttonSize;

  @override
  _EggControlsState createState() => _EggControlsState();
}

class _EggControlsState extends State<EggControls> {
  // TODO: Update placeholder
  int eggCount = 123;

  List<bool> isSelected = [false, false];
  Color activeBackground = Palette.cluckerRed;
  Color activeForeground = Palette.cluckerRedLight;
  Color inactiveBackground = Palette.mercuryGray;
  Color inactiveForeground = Palette.lightGrey;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('$eggCount',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: widget.buttonSize - 14,
              color: Palette.cluckerRed)),
      ToggleButtons(
        onPressed: (int index) {
          setState(() {
            for (int buttonIndex = 0;
                buttonIndex < isSelected.length;
                buttonIndex++) {
              if (buttonIndex == index) {
                isSelected[buttonIndex] = !isSelected[buttonIndex];
              } else {
                isSelected[buttonIndex] = false;
              }
            }
            if ((index == 0 && isSelected[index] == true) ||
                (index == 1 && isSelected[index] == false)) {
              eggCount++;
            } else if ((index == 0 && isSelected[index] == false) ||
                (index == 1 && isSelected[index] == true)) {
              eggCount--;
            }
          });
        },
        isSelected: isSelected,
        children: [
          EggButton(
              FontAwesomeIcons.plus,
              isSelected[0] == false ? inactiveBackground : activeBackground,
              isSelected[0] == false ? inactiveForeground : activeForeground),
          EggButton(
              FontAwesomeIcons.minus,
              isSelected[1] == false ? inactiveBackground : activeBackground,
              isSelected[1] == false ? inactiveForeground : activeForeground),
        ],
        renderBorder: false,
        constraints: BoxConstraints.tight(
            Size(widget.buttonSize + 5, widget.buttonSize + 5)),
        fillColor: Colors.transparent,
      ),
    ]));
  }

  Stack EggButton(
      IconData symbol, Color backgroundColor, Color foregroundColor) {
    return Stack(
      children: [
        Icon(FontAwesomeIcons.egg,
            color: backgroundColor, size: widget.buttonSize),
        Positioned(
            bottom: 0.0001,
            right: 0.0001,
            child: Icon(symbol,
                color: foregroundColor, size: widget.buttonSize / 1.7))
      ],
    );
  }
}
