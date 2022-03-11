import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  State<StatefulWidget> createState() {
    return _MainNavigationBar();
  }
}

class _MainNavigationBar extends State<MainNavigationBar> {
  final Color activeColor = Palette.cluckerRed;
  final Color inactiveColor = Palette.offBlack;
  List<bool> isSelected = [true, false, false, false];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return !widget.focusNode.hasFocus ? BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 2.5,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          index = 0;
                          updateList();
                        });
                      },
                      icon: const Icon(FontAwesomeIcons.home),
                      tooltip: 'Feed',
                      color: isSelected[0] == true ? activeColor : inactiveColor,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          index = 1;
                          updateList();
                        });
                      },
                      icon: const Icon(FontAwesomeIcons.solidCompass),
                      tooltip: 'Discover',
                      color: isSelected[1] == true ? activeColor : inactiveColor,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        index = 2;
                        updateList();
                      });
                    },
                    icon: const Icon(FontAwesomeIcons.search),
                    tooltip: 'Search',
                    color: isSelected[2] == true ? activeColor : inactiveColor,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        index = 3;
                        updateList();
                      });
                    },
                    icon: const Icon(FontAwesomeIcons.solidBell),
                    tooltip: 'Notifications',
                    color: isSelected[3] == true ? activeColor : inactiveColor,
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    ) : const BottomAppBar();
  }

  void updateList() {
    for (int buttonIndex = 0;
    buttonIndex < isSelected.length;
    buttonIndex++) {
      if (buttonIndex == index) {
        isSelected[buttonIndex] = true;
      } else {
        isSelected[buttonIndex] = false;
      }
    }
  }
}
