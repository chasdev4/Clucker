import 'dart:convert';

import 'package:clucker_client/components/account_widget.dart';
import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:flutter/material.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage({Key? key}) : super(key: key);

  List<Widget> getFollowers() {
    List<Widget> followers = [];
    followers.add(AccountWidget(username: '12345678901234567890'));

    for (int i = 0; i < 20; i++) {
      followers.add(AccountWidget(username: 'Cluckerbot_${(i + 19) * 110 + (i * 117)}'));
    }

    return followers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CluckerAppBar(
        appBarProfile: AppBarProfile.followers,
        title: "12345678901234567890's\nFollowers",
        fontSize: 24,
      ),
      body: ListView(
        children: getFollowers()
      ),
    );
  }
}
