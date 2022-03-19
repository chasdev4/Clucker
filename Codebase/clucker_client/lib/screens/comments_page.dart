import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/models/comment_post_request.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:clucker_client/components/text_box.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

late StreamSubscription<bool> keyboardSubscription;

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key, required this.cluck})
      : super(key: key);
  final CluckWidget cluck;

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final storage = const FlutterSecureStorage();
  final cluckNode = FocusNode();
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
    comments = [];
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!keyboardVisibilityController.isVisible) {
        cluckNode.unfocus();
      }
      _updateBarHeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                throw Exception('${snapshot.error}: ${snapshot.stackTrace}');
              } else if (snapshot.hasData && comments.isNotEmpty) {
                return RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.onEdge,
                    edgeOffset: SizeConfig.blockSizeHorizontal * 35,
                    displacement: SizeConfig.blockSizeHorizontal * 30,
                    child: ListView.builder(
                        itemCount: comments.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return comments[index];
                        }),
                    onRefresh: () async {
                      setState(() {
                        getComments();
                      });
                    });
              } else if (comments.isEmpty) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CluckWidget(
                          hue: widget.cluck.hue,
                          avatarImage: widget.cluck.avatarImage,
                          cluckType: CluckType.cluckHeader,
                          isVisible: false,
                          cluck: widget.cluck.cluck,
                          commentCount: widget.cluck.commentCount,
                        ),
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.solidCommentDots,
                                  size: 100,
                                  color: Palette.cluckerRed
                                      .toMaterialColor()
                                      .shade200),
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Be the first to post a\ncomment on this cluck',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Palette.offBlack
                                            .toMaterialColor()
                                            .shade100,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                    maxLines: 2,
                                  )),
                            ]),
                        const SizedBox(
                          height: 75,
                        )
                      ],
                    ));
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
                   SizedBox(
                    height: MediaQuery.of(context).size.height * .05 + (MediaQuery.of(context).size.aspectRatio < (9/16) ? MediaQuery.of(context).size.height * .02 : 0),
                  ),
                  CluckWidget(
                    commentButtonStatic: true,
                    cluckType: CluckType.cluckHeader,
                    cluck: widget.cluck.cluck,
                    commentCount: widget.cluck.commentCount,
                    hue: widget.cluck.hue,
                    avatarImage: widget.cluck.avatarImage,
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
          child: cluckNode.hasFocus
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _updateBarHeight();
                      if (keyboardVisibilityController.isVisible) {
                        cluckNode.unfocus();
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
                                top: cluckNode.hasFocus ? 5 : 7.5),
                            child: TextBox(
                                textBoxProfile: TextBoxProfile.commentField,
                                controller: cluckController,
                                focusNode: cluckNode,
                                extraFunction: () async {
                                  String? username =
                                      await storage.read(key: 'username');
                                  String? id = await storage.read(key: 'id');
                                  Response response = await cluckService
                                      .postComment(CommentPostRequest(
                                          cluckId: widget.cluck.cluck.id,
                                          body: cluckController.text,
                                          username: username!,
                                          userId: int.parse(id!),
                                          eggRating: 0));
                                  if (response.statusCode == 201) {
                                    setState(() {
                                      cluckController.text = '';
                                      cluckNode.unfocus();
                                      getComments();
                                    });
                                  }
                                },
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
    List<Widget> commentWidgets = [];

    List<CluckModel> commentData =
        await cluckService.getCommentsByCluckId(widget.cluck.cluck.id);

    if (commentData.isNotEmpty) {
      for (int i = 0; i < commentData.length; i++) {
        commentWidgets.add(CluckWidget(
            cluck: commentData[i],
            cluckType: CluckType.comment,
            avatarImage: widget.cluck.avatarImage,
            hue: widget.cluck.hue));
      }


        pageHasBeenBuilt = true;
        commentWidgets.insert(
            0,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CluckWidget(
                  cluckType: CluckType.cluckHeader,
                  isVisible: false,
                  cluck: widget.cluck.cluck,
                  commentCount: widget.cluck.commentCount,
                  hue: widget.cluck.hue,
                  avatarImage: widget.cluck.avatarImage,
                )
              ],
            ));
        commentWidgets.add(const SizedBox(
          height: 75,
        ));
      }


    comments = commentWidgets;

   // commentWidgets.clear();

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
