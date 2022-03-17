import 'package:clucker_client/components/account_widget.dart';
import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:clucker_client/models/user_account_model.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:flutter/material.dart';

enum PageContext { followers, following }

class FollowersPage extends StatefulWidget {
  const FollowersPage(
      {Key? key,
      required this.userId,
      required this.username,
      required this.pageContext})
      : super(key: key);

  final int userId;
  final String username;
  final PageContext pageContext;

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  final userService = UserService();
  List<Widget> followers = [];
  late String title;

  @override
  void initState() {
    super.initState();
    title = widget.username + '\'';

    if (widget.username[widget.username.length - 1] != 's') {
      title += 's';
    }

    if (widget.username.length > 9) {
      title += '\n';
    } else {
      title += ' ';
    }

    switch (widget.pageContext) {
      case PageContext.followers:
        title += 'Followers';
        break;
      case PageContext.following:
        title += 'Following';
        break;
    }
  }

  Future<Object?> getFollowers() async {
    List<UserAccountModel> userAccounts = await userService.getFollowers(
        id: widget.userId, pageContext: widget.pageContext);

    for (int i = 0; i < userAccounts.length; i++) {
      followers.add(AccountWidget(
          accountWidgetProfile: AccountWidgetProfile.follower,
          userAccountModel: userAccounts[i]));
    }

    return followers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFollowers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              return Scaffold(
                  appBar: CluckerAppBar(
                    username: widget.username,
                    userId: widget.userId,
                    appBarProfile: AppBarProfile.followers,
                    title: title,
                    fontSize: 24,
                  ),
                  body: RefreshIndicator(
                    onRefresh: () async {
                      getFollowers();
                    },
                    child: ListView.builder(
                      itemCount: followers.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemExtent: 50,
                      itemBuilder: (BuildContext context, int index) {
                        return followers[index];
                      },
                    ),
                  ));
            }
          }

          return const Scaffold(
            body: Center(child: CircularProgressIndicator(strokeWidth: 5)),
          );
        });
  }
}
