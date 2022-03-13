import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:clucker_client/components/text_box.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

late StreamSubscription<bool> keyboardSubscription;

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key, required this.focusNode, required this.cluck})
      : super(key: key);
  final FocusNode focusNode;
  final CluckWidget cluck;

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final cluckService = CluckService();
  late TextEditingController cluckController;
  late KeyboardVisibilityController keyboardVisibilityController;
  late bool pageHasBeenBuilt = false;

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
      _updateBarHeight();
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    cluckController.dispose();
    pageHasBeenBuilt = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Stack(children: [
          FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: comments.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return comments[index];
                        });
                  }
                }

                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 5),
                );
              },
              future: getComments()),
          FittedBox(
              child: Container(
                  color: Palette.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      CluckWidget(
                        commentButtonStatic: true,
                        cluckType: CluckType.cluckHeader,
                        cluck: widget.cluck.cluck,
                        //TODO: commentCount
                        commentCount: 0,
                      ),
                    ],
                  ))),
              Positioned(
                    top: 75,
                    left: 5,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: RawMaterialButton(
                        child: Icon(
                          CupertinoIcons.back,
                          color: Palette.offBlack,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
              ),
          Column(children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  barHeight -
                  MediaQuery.of(context).viewInsets.bottom,
              child: widget.focusNode.hasFocus
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _updateBarHeight();
                          if (keyboardVisibilityController.isVisible) {
                            widget.focusNode.unfocus();
                          }
                        });
                      },
                    )
                  : null,
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
                            Padding(
                                padding: EdgeInsets.only(
                                    top: widget.focusNode.hasFocus ? 5 : 7.5),
                                child: TextBox(
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
        ]));
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

  Future<Object?> getComments() async {
    comments = [];

    if (!pageHasBeenBuilt) {
      pageHasBeenBuilt = true;
      comments.insert(
          0,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CluckWidget(
                cluckType: CluckType.cluckHeader,
                isVisible: false,
                cluck: widget.cluck.cluck,
                //TODO: commentCount
                commentCount: 0,
              )
            ],
          ));
      comments.add(const SizedBox(
        height: 75,
      ));
    }
    List<CluckModel> commentData =
        await cluckService.getCommentsByCluckId(widget.cluck.cluck.cluckId);

    if (commentData.isNotEmpty) {
      for (int i = 0; i < commentData.length; i++) {
        comments.add(
            CluckWidget(cluck: commentData[i], cluckType: CluckType.comment));
      }
    } else {
      comments = [];
    }

    return comments;
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
