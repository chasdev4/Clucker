import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:clucker_client/navigation/new_cluck_button.dart';
import 'package:flutter/material.dart';

import 'components/clucker_app_bar.dart';
import 'components/user_avatar.dart';

class TestScreen extends StatelessWidget {

  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: const [
            Text('Test Text')
          ],
        ),
      ),
      bottomNavigationBar: const MainNavigationBar(),
      floatingActionButton: const NewCluckButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

}
