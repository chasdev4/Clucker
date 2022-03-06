import 'package:clucker_client/cluck_tests.dart';
import 'package:clucker_client/components/cluck.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key, required this.cluck}) : super(key: key);

  final Cluck cluck;
  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late List<Widget> comments;

  @override
  void initState() {
    super.initState();
    comments = [];
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
    return Scaffold(
        body: Stack(
      children: [
        ListView(
          children: comments,
        ),
        FittedBox(
            child: Container(
                color: Palette.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
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
      ],
    ));
  }
}
