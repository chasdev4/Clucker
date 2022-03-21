import 'package:clucker_client/models/user_self_model.dart';
import 'package:clucker_client/screens/discover_page.dart';
import 'package:clucker_client/screens/feed_page.dart';
import 'package:clucker_client/screens/search_page.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:clucker_client/splash.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:clucker_client/navigation/new_cluck_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final storage = const FlutterSecureStorage();
  late FeedPage feedPage;
  late bool fetchFeedPageAgain = false;

  late HomePageDetails details;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                  child: Container(
                color: Colors.white,
                child: Text(
                  '${snapshot.error}... ${snapshot.stackTrace}',
                  style: const TextStyle(fontSize: 18),
                ),
              ));
            } else if (snapshot.hasData) {
              return _Hub(
                details: details,
                refreshFeedPage: (value) {
                  setState(() {
                    feedPage = value;
                  });
                },
              );
            }
          }

          return const SplashScreen();
        },
        future: getHomePageDetails());
  }

  Future<Object?> getHomePageDetails() async {
    UserService userService = UserService();
    feedPage = FeedPage(
      fetchAgain: fetchFeedPageAgain,
    );

    UserSelfModel currentUser = await userService.getSelf();

    storage.write(key: 'id', value: currentUser.id.toString());
    storage.write(key: 'username', value: currentUser.username);

    List<Widget> pages = [
      const FeedPage(),
      const DiscoverPage(),
      SearchPage(userId: currentUser.id, username: currentUser.username),
      const NotificationsPage(),
    ];

    details = HomePageDetails(currentUser: currentUser, pages: pages);

    return details;
  }
}

class _Hub extends StatefulWidget {
  const _Hub({Key? key, required this.details, required this.refreshFeedPage})
      : super(key: key);

  final HomePageDetails details;
  final Function refreshFeedPage;

  @override
  _HubState createState() => _HubState();
}

class _HubState extends State<_Hub> {
  late int pageIndex;
  late String title;
  final cluckNode = FocusNode();

  @override
  void initState() {
    super.initState();
    pageIndex = 0;
    title = 'Feed';
  }

  @override
  void dispose() {
    pageIndex = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pageIndex != 2
          ? CluckerAppBar(
              username: widget.details.currentUser.username,
              userId: widget.details.currentUser.id,
              hue: widget.details.currentUser.hue,
              avatarImage: widget.details.currentUser.avatarImage,
              appBarProfile: AppBarProfile.avatar,
              title: title,
            )
          : null,
      body: widget.details.pages[pageIndex],
      bottomNavigationBar: MainNavigationBar(
        sendIndex: (index) {
          setState(() {
            pageIndex = index;
            switch (index) {
              case 0:
                title = 'Feed';
                break;
              case 1:
                title = 'Discover';
                break;
              case 2:
                title = '';
                break;
              case 3:
                title = 'Notifications';
                break;
            }
          });
        },
        focusNode: cluckNode,
      ),
      floatingActionButton: NewCluckButton(
          userId: widget.details.currentUser.id,
          username: widget.details.currentUser.username,
          fetchFeedPageAgain: (value) {
            if (value) {
              widget.refreshFeedPage(const FeedPage(
                fetchAgain: true,
              ));
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class HomePageDetails {
  const HomePageDetails({required this.currentUser, required this.pages});
  final UserSelfModel currentUser;
  final List<Widget> pages;
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Notifications!',
      style: TextStyle(fontSize: 30),
    ));
  }
}
