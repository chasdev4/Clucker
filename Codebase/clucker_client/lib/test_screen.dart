import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:clucker_client/navigation/new_cluck_button.dart';
import 'package:flutter/material.dart';

import 'components/clucker_app_bar.dart';
import 'components/user_avatar.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final GlobalKey cluckGlobalKey = GlobalKey<_TestScreenState>();

  late FocusNode cluckFocusNode;
  late bool keyboardExpanded;
  late bool overlayVisible;

  @override
  void initState() {
    super.initState();
    cluckFocusNode = FocusNode();
    keyboardExpanded = false;
    overlayVisible = false;
  }

  @override
  void dispose() {
    cluckFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      if (MediaQuery.of(context).viewInsets.bottom == 0) {
        keyboardExpanded = false;
      } else {
        true;
      }
          return !overlayVisible;
        },
        child: Scaffold(
          appBar: const CluckerAppBar(
            title: "Feed",
            actions: [
              UserAvatar(
                avatarImage: 'assets/icons/chicken.jpg',
              )
            ],
          ),
          body: Center(
            child: Column(
              children: const [Text('Test Text')],
            ),
          ),
          bottomNavigationBar: MainNavigationBar(
            focusNode: cluckFocusNode,
          ),
          floatingActionButton: NewCluckButton(
            key: cluckGlobalKey,
              focusNode: cluckFocusNode,
              setOverlayState: (bool overlayState) {
                  overlayVisible = overlayState;

              }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ));
  }
}
