import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/models/user_avatar_model.dart';
import 'package:clucker_client/models/temp_user_model.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:clucker_client/navigation/new_cluck_button.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final userService = UserService();
  final cluckService = CluckService();
  final cluckNode = FocusNode();
  late TempUserModel user;
  late List<CluckWidget> cluckWidgets;

  @override
  void initState() {
    super.initState();
    getUser();
    cluckWidgets = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getUser() {
    user = TempUserModel(
        9, 'username', 'email@email.org', 'bio', DateTime.now(), 0, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CluckerAppBar(
        username: user.username,
        userId: user.id,
        hue: user.hue,
        appBarProfile: AppBarProfile.avatar,
        title: 'Feed',
      ),
      body: FutureBuilder(
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
                return RefreshIndicator(
                  onRefresh: () async {
                    getFeed();
                  },
                  child: ListView.builder(
                    itemCount: cluckWidgets.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemExtent: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return cluckWidgets[index];
                    },
                  ),
                );
              }
            }

            return const Center(
              child: CircularProgressIndicator(strokeWidth: 5),
            );
          },
          future: getFeed()),
      bottomNavigationBar: MainNavigationBar(
        focusNode: cluckNode,
      ),
      floatingActionButton: NewCluckButton(
        focusNode: cluckNode,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<Object?> getFeed() async {
    List<CluckModel> clucks = await cluckService.getFeed();
    UserService userService = UserService();
    cluckWidgets.clear();

    for (int i = 0; i < clucks.length; i++) {
      UserAvatarModel userAvatar =
          await userService.getUserAvatarById(clucks[i].userId);

      cluckWidgets.add(CluckWidget(
        hue: userAvatar.hue,
        avatarImage: userAvatar.image!,
        cluck: clucks[i],
        commentCount: clucks[i].commentCount,
      ));
    }

    return Future.delayed(const Duration(seconds: 2), () {
      return clucks;
    });
  }
}
