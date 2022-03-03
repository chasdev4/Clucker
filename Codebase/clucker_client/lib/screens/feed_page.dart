import 'package:flutter/material.dart';
import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:clucker_client/navigation/new_cluck_button.dart';
import 'package:clucker_client/components/cluck.dart';
import 'package:clucker_client/cluck_tests.dart';

CluckTests cluckTest = CluckTests();

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CluckerAppBar(
        title: 'test feed',
        actions: [
          UserAvatar(
            avatarImage: 'assets/icons/chicken.jpg',
          ),
        ],
      ),
      body: ListView(
        children: cluckTest.getCluckList(howManyClucks: 10),
      ),
      bottomNavigationBar: const MainNavigationBar(),
      floatingActionButton: const NewCluckButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
