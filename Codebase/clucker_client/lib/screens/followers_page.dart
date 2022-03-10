import 'dart:convert';

import 'package:clucker_client/components/account_widget.dart';
import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:flutter/material.dart';

enum PageContext {
  followers,
  following
}

class FollowersPage extends StatelessWidget {
  const FollowersPage({Key? key, required this.username, required this.pageContext}) : super(key: key);

  final String username;
  final PageContext pageContext;

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
    String title = username + '\'';

    if (username[username.length - 1] != 's') {
      title += 's';
    }

    if (username.length > 9) {
      title += '\n';
    }
    else {
      title += ' ';
    }

    switch (pageContext) {
      case PageContext.followers:
        title += 'Followers';
        break;
      case PageContext.following:
        title += 'Following';
        break;
    }

    return Scaffold(
      appBar: CluckerAppBar(
        appBarProfile: AppBarProfile.followers,
        username: username,
        title: title,
        fontSize: 24,
      ),
      body: ListView(
        children: getFollowers()
      ),
    );
  }
}
