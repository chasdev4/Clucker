import 'package:clucker_client/cluck_tests.dart';
import 'package:clucker_client/components/cluck.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

late StreamSubscription<bool> keyboardSubscription;

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key, required this.focusNode, required this.cluck})
      : super(key: key);
  final FocusNode focusNode;
  final Cluck cluck;

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late TextEditingController cluckController;
  late KeyboardVisibilityController keyboardVisibilityController;

  late int numNewLines;
  double barHeight = 75;
  late List<Widget> comments;

  @override
  void initState() {
    super.initState();
    keyboardVisibilityController = KeyboardVisibilityController();
    cluckController = TextEditingController();
    numNewLines = 0;
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!keyboardVisibilityController.isVisible) {
        widget.focusNode.unfocus();
      }
      comments = [];
      _updateBarHeight();
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    cluckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    comments = widget.cluck.comments;
    comments.insert(
        0,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Cluck(
              postDate: widget.cluck.postDate,
              cluckType: CluckType.cluckHeader,
              isVisible: false,
              cluckText: widget.cluck.cluckText,
              username: widget.cluck.username,
              eggCount: widget.cluck.eggCount,
              comments: widget.cluck.comments,
            )
          ],
        ));
    comments.add(SizedBox(height: 75,));

    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return WillPopScope(
          onWillPop: () async {
            //TODO: prevent pop
            print('onWillPop');
            comments.removeAt(0);
            comments.removeAt(comments.length - 1);
            return true;
          },
          child: Scaffold(
              body: Stack(children: [
            ListView(
              children: widget.cluck.comments,
            ),
            FittedBox(
                child: Container(
                    color: Palette.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Cluck(
                            postDate: widget.cluck.postDate,
                            commentButtonStatic: true,
                            cluckType: CluckType.cluckHeader,
                            cluckText: widget.cluck.cluckText,
                            comments: widget.cluck.comments,
                            username: widget.cluck.username,
                            eggCount: widget.cluck.eggCount)
                      ],
                    ))),
            Column(children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    barHeight -
                    MediaQuery.of(context).viewInsets.bottom,
                child: widget.focusNode.hasFocus ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _updateBarHeight();
                      if (keyboardVisibilityController.isVisible) {
                        widget.focusNode.unfocus();
                      }
                    });
                  },
                ) : null,
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
                              Padding(padding: EdgeInsets.only(top: widget.focusNode.hasFocus ? 5 : 7.5), child: TextBox(
                                  textBoxProfile: TextBoxProfile.commentField,
                                  controller: cluckController,
                                  focusNode: widget.focusNode,
                                  onTap: () {
                                    setState(() {
                                      barHeight = 168;
                                    });
                                  })),
                            ],
                          )),
                    ),
                  ],
                ),
              ]),
            ])
          ])));
    });
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
      barHeight = 168;
    } else {
      barHeight = countNewLines() <= 1
          ? 75
          : countNewLines() >= 7
              ? 168
              : (((numNewLines + 1) * 19.285) + 40);
    }
  }
}