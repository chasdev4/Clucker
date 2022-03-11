import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:clucker_client/navigation/new_cluck_button.dart';
import 'package:flutter/material.dart';
import 'components/clucker_app_bar.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late FocusNode focusNode;
  late bool overlayVisible;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    overlayVisible = false;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: const CluckerAppBar(
        username: 'user',
        appBarProfile: AppBarProfile.noAvatar,
        title: "Feed",
      ),
      body: Center(
        child: Column(
              children: const [Text('Test Text')],
        ),
      ),
          bottomNavigationBar: MainNavigationBar(
            focusNode: focusNode,
          ),
          floatingActionButton: NewCluckButton(
              focusNode: focusNode,),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
    );
  }
}
