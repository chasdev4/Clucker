import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:clucker_client/navigation/new_cluck_button.dart';
import 'package:clucker_client/components/header.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {

  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWithAvatar('Feed'),
      body: Center(
        child: Column(
          children: const [
            Divider(
              color: Colors.red,
              height: 6,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            TextBox('test', true),
            SearchBox(),
          ],
        ),
      ),
      bottomNavigationBar: const MainNavigationBar(),
      floatingActionButton: NewCluckButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

}
