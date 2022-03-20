import 'package:clucker_client/components/div.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/models/cluck_like_request.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/screens/comments_page.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';

enum CluckType { cluck, comment, cluckHeader }

class CluckWidget extends StatefulWidget {
  const CluckWidget(
      {Key? key,
      this.cluckType = CluckType.cluck,
      required this.cluck,
      this.commentButtonStatic = false,
      this.isVisible = true,
      this.commentCount = 0,
      this.onProfile = false,})
      : super(key: key);

  final CluckType cluckType;
  final CluckModel cluck;
  final bool commentButtonStatic;
  final int commentCount;
  final bool isVisible;
  final bool onProfile;

  @override
  _CluckWidgetState createState() => _CluckWidgetState();
}

class _CluckWidgetState extends State<CluckWidget> {
  final storage = const FlutterSecureStorage();
  final DateFormat timeStampDate = DateFormat.yMMMMd('en_US');
  final DateFormat timeStampTime = DateFormat('h:mm a');
  final FocusNode focusNode = FocusNode();

  DateTime now = DateTime.now();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              color: widget.cluckType != CluckType.comment
                  ? Palette.white
                  : Palette.mercuryGray.toMaterialColor().shade100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: widget.cluckType == CluckType.cluck
                            ? 0
                            : widget.cluckType == CluckType.comment
                                ? 15
                                : 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 6, bottom: 6, left: 20, right: 2),
                        child: UserAvatar(
                            username: widget.cluck.username,
                            userId: widget.cluck.userId,
                            hue: widget.cluck.hue,
                            onProfile: widget.onProfile,
                            avatarImage: '',
                            avatarSize: AvatarSize.small),
                      ),
                      Text(
                        widget.cluck.username,
                        style: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      Transform.translate(
                        offset: const Offset(-20, -5),
                        child: Text(
                          widget.cluckType == CluckType.cluckHeader
                              ? ''
                              : getTimeAgo(),
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Palette.offBlack.toMaterialColor().shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        bottom: 12,
                        right: 80,
                        left: widget.cluckType == CluckType.cluck
                            ? 0
                            : widget.cluckType == CluckType.comment
                                ? 15
                                : 30),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Text(
                      widget.cluck.body,
                      maxLines: 6,
                      style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      child: widget.cluckType != CluckType.cluckHeader
                          ? const Div()
                          : null),
                ],
              )),
          Positioned(
              bottom: 5,
              right: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      child: widget.cluckType != CluckType.comment
                          ? _CommentButton(
                              isStatic: widget.commentButtonStatic,
                              commentCount: widget.commentButtonStatic &&
                                      widget.commentCount > 0
                                  ? widget.commentCount - 2
                                  : widget.commentCount,
                              buttonSize: 25,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommentsPage(
                                            cluck: CluckWidget(
                                              cluck: widget.cluck,
                                              commentCount: widget.commentCount,
                                            ),
                                          )),
                                );
                              },
                            )
                          : null),
                  _EggControls(
                    cluckId: widget.cluck.id,
                    eggRating: widget.cluck.eggRating!,
                    buttonSize: 25,
                    currentRating: widget.cluck.currentRating,
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              )),
        ],
      ),
      Container(
          child: widget.cluckType == CluckType.cluckHeader
              ? Column(
                  children: [
                    Container(
                      color: widget.isVisible
                          ? Palette.lightGrey.toMaterialColor().shade300
                          : Colors.transparent,
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        color: widget.isVisible
                            ? Palette.white
                            : Palette.mercuryGray.toMaterialColor().shade100,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 13,
                            ),
                            Text(
                              timeStampDate.format(dateTimeToZone(zone: DateTime.now().timeZoneName, datetime: widget.cluck.posted)) +
                                  ' at ' +
                                  timeStampTime.format(dateTimeToZone(zone: DateTime.now().timeZoneName, datetime: widget.cluck.posted)),
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 13.44,
                                fontWeight: FontWeight.w500,
                                color: widget.isVisible
                                    ? Palette.offBlack
                                        .toMaterialColor()
                                        .shade400
                                    : Colors.transparent,
                              ),
                            )
                          ],
                        )),
                    Container(
                      color: widget.isVisible
                          ? Palette.lightGrey.toMaterialColor().shade300
                          : Colors.transparent,
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                    )
                  ],
                )
              : null)
    ]);
  }

  String getTimeAgo() {
    String value = '';
    Duration timeAgo = now.difference(widget.cluck.posted);

    if (timeAgo.inDays >= 365) {
      value = '${(timeAgo.inDays / 365).toStringAsFixed(0)}y';
    } else if (timeAgo.inDays >= 30) {
      value = '${(timeAgo.inDays / 30).toStringAsFixed(0)}mo';
    } else if (timeAgo.inDays >= 7) {
      value = '${(timeAgo.inDays / 7).toStringAsFixed(0)}w';
    } else if (timeAgo.inDays >= 1) {
      value = '${timeAgo.inDays}d';
    } else if (timeAgo.inHours >= 1) {
      value = '${timeAgo.inHours}h';
    } else if (timeAgo.inMinutes >= 1) {
      value = '${timeAgo.inMinutes}m';
    } else {
      value = '${timeAgo.inSeconds}s';
    }

    return value;
  }
}

class _CommentButton extends StatefulWidget {
  const _CommentButton(
      {Key? key,
      required this.commentCount,
      required this.buttonSize,
      required this.onPressed,
      this.isStatic = false})
      : super(key: key);
  final int commentCount;
  final double buttonSize;
  final Function onPressed;
  final bool isStatic;

  @override
  _CommentButtonState createState() => _CommentButtonState();
}

class _CommentButtonState extends State<_CommentButton> {
  @override
  Widget build(BuildContext context) {
    const double padding = 7.1;

    return Flexible(
        child: Column(children: [
      Transform.translate(
          offset: const Offset(0, -8.1),
          child: Text(
              widget.commentCount != 0 ? widget.commentCount.toString() : '',
              style: TextStyle(
                  height: 0,
                  fontWeight: FontWeight.w900,
                  fontSize: 11.4,
                  color: Palette.cluckerRed))),
      SizedBox(
          width: widget.buttonSize + padding + 5,
          height: widget.buttonSize + padding,
          child: !widget.isStatic
              ? RawMaterialButton(
                  onPressed: () => widget.onPressed(),
                  splashColor: widget.isStatic
                      ? Colors.transparent
                      : Palette.cluckerRedLight.toMaterialColor().shade800,
                  child: commentIcon())
              : commentIcon())
    ]));
  }

  Icon commentIcon() {
    return Icon(FontAwesomeIcons.solidCommentDots,
        color:
            widget.commentCount == 0 ? Palette.mercuryGray : Palette.cluckerRed,
        size: widget.buttonSize);
  }
}

class _EggControls extends StatefulWidget {
  const _EggControls(
      {Key? key,
      required this.cluckId,
      required this.eggRating,
      required this.buttonSize,
      required this.currentRating})
      : super(key: key);

  final String cluckId;
  final double buttonSize;
  final int eggRating;
  final int currentRating;

  @override
  _EggControlsState createState() => _EggControlsState();
}

class _EggControlsState extends State<_EggControls> {
  final Color activeBackground = Palette.cluckerRed;
  final Color activeForeground = Palette.cluckerRedLight;
  final Color inactiveBackground = Palette.mercuryGray;
  final Color inactiveForeground = Palette.lightGrey;

  late List<bool> isSelected;
  late List<bool> previousSelection;
  late int eggCount = widget.eggRating;

  @override
  void initState() {
    super.initState();
    switch (widget.currentRating) {
      case 1:
        isSelected = [true, false];
        previousSelection = [false, false];
        break;
      case 0:
        isSelected = [false, false];
        previousSelection = [false, false];
        break;
      case -1:
        isSelected = [false, true];
        previousSelection = [false, false];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Column(children: [
      Text(eggCount != 0 ? eggCount.toString() : '',
          style: TextStyle(
              height: 0,
              fontWeight: FontWeight.w900,
              fontSize: 11.4,
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

            final cluckService = CluckService();

            if ((index == 0 && isSelected[index]) ||
                (index == 1 && !isSelected[index])) {
              eggCount++;
              if (!isSelected[0] && !isSelected[1]) {
                cluckService.removeEggToCluck(cluckId: widget.cluckId);
               } else {
                cluckService.addEggToCluck(
                    request: CluckLikeRequest(cluckId: widget.cluckId));
              }
            } else if ((index == 0 && isSelected[index] == false) ||
                (index == 1 && isSelected[index] == true)) {
              eggCount--;
              if (!isSelected[0] && !isSelected[1]) {
                cluckService.addEggToCluck(
                    request: CluckLikeRequest(cluckId: widget.cluckId));
              } else {
                cluckService.removeEggToCluck(cluckId: widget.cluckId);
              }
            }

            if (index == 1 && previousSelection[0] == true) {
              eggCount--;
              cluckService.removeEggToCluck(cluckId: widget.cluckId);
            } else if (index == 0 && previousSelection[1] == true) {
              eggCount++;
              cluckService.addEggToCluck(
                  request: CluckLikeRequest(cluckId: widget.cluckId));
            }
          });
        },
        isSelected: isSelected,
        children: [
          eggButton(
              FontAwesomeIcons.plus,
              isSelected[0] == false ? inactiveBackground : activeBackground,
              isSelected[0] == false ? inactiveForeground : activeForeground),
          eggButton(
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

  Stack eggButton(
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
