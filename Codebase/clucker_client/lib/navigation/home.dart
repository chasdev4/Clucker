import 'package:clucker_client/models/user_self_model.dart';
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
  final cluckNode = FocusNode();

  late HomePageDetails details;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Container(color: Colors.white, child: Text(
                  '${snapshot.error}... ${snapshot.stackTrace}',
                  style: const TextStyle(fontSize: 18),
                ),)
              );
            } else if (snapshot.hasData) {
              return _Hub(details: details);
            }
          }

          return const SplashScreen();
        },
        future: getHomePageDetails());
  }

  Future<Object?> getHomePageDetails() async {
    UserService userService = UserService();
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
  const _Hub({Key? key, required this.details}) : super(key: key);

  final HomePageDetails details;

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
      appBar: pageIndex != 2 ? CluckerAppBar(
        username: widget.details.currentUser.username,
        userId: widget.details.currentUser.id,
        //hue: user.hue,
        hue: 0,
        // avatarImage: currentUser.avatarImage,
        avatarImage: '',
        appBarProfile: AppBarProfile.avatar,
        title: title,
      ) : null,
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


class HomePageDetails {
  const HomePageDetails({required this.currentUser, required this.pages});
  final UserSelfModel currentUser;
  final List<Widget> pages;
}

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Discover!', style: TextStyle(fontSize: 30),));
  }
}


class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Notifications!', style: TextStyle(fontSize: 30),));
  }
}


