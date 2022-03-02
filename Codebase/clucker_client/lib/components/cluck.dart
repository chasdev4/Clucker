import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clucker_client/components/user_avatar.dart';

class Cluck extends StatefulWidget {
  Cluck(
      {Key? key,
      required this.username,
      required this.cluckText,
      required this.eggCount})
      : super(key: key);

  final String cluckText;
  final String username;
  int eggCount;

  @override
  _CluckState createState() => _CluckState();
}

class _CluckState extends State<Cluck> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const UserAvatar(
              avatarImage: 'assets/icons/chicken.jpg',
            ),
            Text(
                widget.username,
              style: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            const Text(
                'Time',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40,
            ),
            Text(
              widget.cluckText,
              style: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
              ),
            ),
            const Spacer(),
            EggControls(eggCount: widget.eggCount),
          ],
        ),
        const Divider(

        ),
      ],
    );
  }
}

class EggControls extends StatefulWidget {
  EggControls({Key? key, required this.eggCount, this.buttonSize = 25})
      : super(key: key);

  final double buttonSize;
  int eggCount;

  @override
  _EggControlsState createState() => _EggControlsState();
}

class _EggControlsState extends State<EggControls> {
  List<bool> isSelected = [false, false];
  List<bool> previousSelection = [false, false];
  Color activeBackground = Palette.cluckerRed;
  Color activeForeground = Palette.cluckerRedLight;
  Color inactiveBackground = Palette.mercuryGray;
  Color inactiveForeground = Palette.lightGrey;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(widget.eggCount.toString(),
          style: TextStyle(
              height: 0,
              fontWeight: FontWeight.w900,
              fontSize: widget.buttonSize - 14,
              color: Palette.cluckerRed)),
      ToggleButtons(
        onPressed: (int index) {
          setState(() {
            previousSelection[0] = isSelected[0];
            previousSelection[1] = isSelected[1];
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
              widget.eggCount++;
            } else if ((index == 0 && isSelected[index] == false) ||
                (index == 1 && isSelected[index] == true)) {
              widget.eggCount--;
            }

            if (index == 1 && previousSelection[0] == true) {
              widget.eggCount--;
            } else if (index == 0 && previousSelection[1] == true) {
              widget.eggCount++;
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
