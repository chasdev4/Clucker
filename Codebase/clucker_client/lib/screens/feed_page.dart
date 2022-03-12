import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/models/cluck.dart';
import 'package:clucker_client/models/user.dart';
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
  late User user;
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
    user = User(100, 'usernamer', 'usernamer@gmail.com', DateTime.now(), 1, 1, 1);
  }

  @override
  Widget build(BuildContext context) {
    final cluckNode = FocusNode();
    return Scaffold(
      appBar: CluckerAppBar(
        username: user.username,
        appBarProfile: AppBarProfile.avatar,
        title: 'Feed',
      ),
      body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );

              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: cluckWidgets.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return cluckWidgets[index];
                    });
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
    List<Cluck> clucks = await cluckService.getClucks();
    cluckWidgets.clear();

    for (int i = 0; i < clucks.length; i++) {
      cluckWidgets.add(CluckWidget(cluck: clucks[i], comments: await cluckService.getComments(clucks[i].id)));
    }

    print('Data len: ${clucks.length}, Widget len: ${cluckWidgets.length}');

    return Future.delayed(const Duration(seconds: 2), () {
      return clucks;
    });
  }
}
