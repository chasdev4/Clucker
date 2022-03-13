import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:flutter/material.dart';

enum PageContext {
  followers,
  following
}

class FollowersPage extends StatelessWidget {
  const FollowersPage({Key? key, required this.userId, required this.username, required this.pageContext}) : super(key: key);

  final int userId;
  final String username;
  final PageContext pageContext;

  List<Widget> getFollowers() {
    List<Widget> followers = [];

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
        username: username,
        userId: userId,
        appBarProfile: AppBarProfile.followers,
        title: title,
        fontSize: 24,
      ),
      body: ListView(
        children: getFollowers()
      ),
    );
  }
}
