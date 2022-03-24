import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/models/comment_post_request.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:clucker_client/components/text_box.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:clucker_client/components/page_card.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

late StreamSubscription<bool> keyboardSubscription;

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key, required this.cluck}) : super(key: key);
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
      CommentsBody(
        cluckModel: widget.cluck.cluck,
      ),
      FittedBox(
          child: Container(
              color: Palette.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05 +
                        (MediaQuery.of(context).size.aspectRatio < (9 / 16)
                            ? MediaQuery.of(context).size.height * .02
                            : 0),
                  ),
                  CluckWidget(
                    commentButtonStatic: true,
                    cluckType: CluckType.cluckHeader,
                    cluck: widget.cluck.cluck,
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
      ]),
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

class CommentsBody extends StatefulWidget {
  const CommentsBody({Key? key, required this.cluckModel}) : super(key: key);

  final CluckModel cluckModel;
  @override
  _CommentsBodyState createState() => _CommentsBodyState();
}

class _CommentsBodyState extends State<CommentsBody> {
  final cluckService = CluckService();
  static const pageSize = 15;

  final PagingController<int, CluckModel> _pagingController = PagingController(
    firstPageKey: 0,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final comments = await cluckService.getCommentsByCluckId(
          widget.cluckModel.id, pageSize, pageKey);
      final userService = UserService();

      comments.insert(0, widget.cluckModel);

      for (int i = 0; i < comments.length; i++) {
        final avatarData =
            await userService.getUserAvatarById(comments[i].userId);
        comments[i].update(avatarData.hue, avatarData.image ?? '');
      }

      final isLastPage = comments.length < pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(comments);
      } else {
        _pagingController.appendPage(comments, ++pageKey);
      }
    } catch (error) {
      _pagingController.error = error;
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
    triggerMode: RefreshIndicatorTriggerMode.anywhere,
      edgeOffset: 100,
      displacement: 200,
      onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
      child: PagedListView<int, CluckModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CluckModel>(
           noItemsFoundIndicatorBuilder: (context) {
            if (widget.cluckModel.commentCount! > 2) {
              return const PageCard(cardType: CardType.endCard, commentsPage: true,);
            }
            return Container();
          },
          animateTransitions: true,
            noMoreItemsIndicatorBuilder: (context) {
            return const PageCard(cardType: CardType.noComments);
            },
          itemBuilder: (context, item, index) {
            if (index == 0) {
              return CluckWidget(
                cluck: widget.cluckModel,
                cluckType: CluckType.cluckHeader,
                commentButtonStatic: true,
                isVisible: false,
                onProfile: true,
              );
            }
            return CluckWidget(
              cluck: item,
              cluckType: CluckType.comment,
            );
          }
        ),
      ));

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
