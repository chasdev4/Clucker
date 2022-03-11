import 'package:flutter/material.dart';
import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:clucker_client/navigation/new_cluck_button.dart';
import 'package:clucker_client/cluck_tests.dart';

CluckTests cluckTest = CluckTests();

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cluckNode = FocusNode();
    return Scaffold(
      appBar: const CluckerAppBar(
        username: 'TheCluckMan',
        appBarProfile: AppBarProfile.avatar,
        title: 'Feed',
      ),
      body: ListView(
        children: cluckTest.getCluckList(howManyClucks: 20),
      ),
      bottomNavigationBar:  MainNavigationBar(focusNode: cluckNode,),
      floatingActionButton:  NewCluckButton(focusNode: cluckNode,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
