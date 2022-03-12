import 'package:clucker_client/components/account_widget.dart';
import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:clucker_client/models/user.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:flutter/material.dart';

enum PageContext {
  followers,
  following
}

class FollowersPage extends StatelessWidget {
  const FollowersPage({Key? key, required this.user, required this.pageContext}) : super(key: key);

  final User user;
  final PageContext pageContext;

  List<Widget> getFollowers() {
    List<Widget> followers = [];

    return followers;
  }

  @override
  Widget build(BuildContext context) {

    String title = user.username + '\'';

    if (user.username[user.username.length - 1] != 's') {
      title += 's';
    }

    if (user.username.length > 9) {
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
        user: user,
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
