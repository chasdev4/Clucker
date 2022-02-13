import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:clucker_client/navigation/new_cluck_button.dart';
import 'package:clucker_client/header.dart';
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
            Text('Test Text')
          ],
        ),
      ),
      bottomNavigationBar: const MainNavigationBar(),
      floatingActionButton: NewCluckButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

}