import 'dart:async';

import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/models/cluck_post_request.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:http/http.dart';

late StreamSubscription<bool> keyboardSubscription;

class NewCluckButton extends StatefulWidget {
  const NewCluckButton({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

  @override
  _NewCluckButtonState createState() => _NewCluckButtonState();
}

class _NewCluckButtonState extends State<NewCluckButton> {
  late TextEditingController cluckController;
  late KeyboardVisibilityController keyboardVisibilityController;

  late int numNewLines;
  late bool overlayVisible;
  double barHeight = 218;
  late OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();
    keyboardVisibilityController = KeyboardVisibilityController();
    cluckController = TextEditingController();
    numNewLines = 0;
    overlayVisible = false;
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!keyboardVisibilityController.isVisible) {
        widget.focusNode.unfocus();
      }

      _updateBarHeight();
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    cluckController.dispose();
    super.dispose();
  }

  bool getKeyboardState() {
    return ((MediaQuery.of(context).viewInsets.bottom >= 0 &&
        MediaQuery.of(context).viewInsets.bottom <
            MediaQuery.of(context).size.height / 36));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (overlayVisible) {
            overlayEntry.remove();
            setState(() {
              overlayVisible = false;
            });
            return overlayVisible;
          }
          return true;
        },
        child: SizedBox(
          height: 70,
          width: 70,
          child: getKeyboardState() && overlayVisible == false
              ? FloatingActionButton(
                  backgroundColor: Palette.white,
                  onPressed: () {
                    _showOverlay(context);
                    widget.focusNode.requestFocus();
                    _updateBarHeight(override: true);
                  },
                  child: Transform.scale(
                      scale: 1.17,
                      child: Icon(
                        FontAwesomeIcons.plusCircle,
                        size: 70,
                        color: Palette.cluckerRed,
                      )),
                  elevation: 0,
                  tooltip: 'New Cluck')
              : null,
        ));
  }

  void _showOverlay(BuildContext context) async {
    final cluckService = CluckService();
    OverlayState? overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(builder: (context) {
      return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Column(children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  barHeight -
                  MediaQuery.of(context).viewInsets.bottom,
              child: RawMaterialButton(
                fillColor: Palette.black.toMaterialColor().shade300,
                splashColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    _updateBarHeight();
                    if (!keyboardVisibilityController.isVisible) {
                      overlayEntry.remove();
                      overlayVisible = false;
                      cluckController.text = '';
                    } else {
                      widget.focusNode.unfocus();
                    }
                  });
                },
              ),
            ),
          ),
          Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: barHeight - 1,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    spreadRadius: 1,
                    offset: const Offset(0, -1.45),
                    color: Palette.mercuryGray.toMaterialColor().shade400)
              ]),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: barHeight,
                  color: Palette.white,
                  child: Material(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(
                                  widget.focusNode.hasFocus ? 3 : 13),
                              width: MediaQuery.of(context).size.width - 50,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            widget.focusNode.hasFocus ? 10 : 0),
                                    child: const Text(
                                      'New Cluck',
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  const SizedBox(),
                                  widget.focusNode.hasFocus
                                      ? IconButton(
                                          onPressed: () {
                                            overlayEntry.remove();
                                            overlayVisible = false;
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.times,
                                            size: 26,
                                            color: Palette.offBlack,
                                          ))
                                      : const SizedBox(),
                                ],
                              )),
                          TextBox(
                              textBoxProfile: TextBoxProfile.cluckField,
                              controller: cluckController,
                              focusNode: widget.focusNode,
                              extraFunction: () async {
                                Response postStatus = await cluckService.postCluck(
                                    CluckPostRequest(
                                        cluckController.text,
                                        //TODO: Add signed in User's name and Id
                                        'username', 1,
                                        DateTime.now(), 0, 0));
                              },
                              onTap: () {
                                setState(() {
                                  barHeight = 218;
                                });
                              }),
                        ],
                      )),
                ),
              ],
            ),
          ]),
        ]);
      });
    });

    overlayVisible = true;
    overlayState?.insert(overlayEntry);
  }

  int countNewLines() {
    numNewLines = 0;
    if (cluckController.text.isNotEmpty) {
      for (int i = 0; i < cluckController.text.length; i++) {
        if (cluckController.text[i] == '\n') {
          numNewLines++;
        }
      }
    }
    return numNewLines;
  }

  void _updateBarHeight({bool override = false}) {
    if (keyboardVisibilityController.isVisible || override == true) {
      barHeight = 218;
    } else {
      barHeight = countNewLines() <= 1
          ? 125
          : countNewLines() >= 7
              ? 218
              : (((numNewLines + 1) * 19.285) + 90);
    }
  }
}
