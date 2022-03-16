import 'package:clucker_client/models/user_self_model.dart';
import 'package:clucker_client/screens/feed_page.dart';
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

  var pages = [];

  late UserSelfModel currentUser;
  late int pageIndex;

  @override
  void initState() {
    super.initState();
    pageIndex = 0;
  }

  @override
  void dispose() {
    pageIndex = 0;
    super.dispose();
  }

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
              return Scaffold(
                  appBar: CluckerAppBar(
                    username: currentUser.username,
                    userId: currentUser.id,
                    //hue: user.hue,
                    hue: 0,
                   // avatarImage: currentUser.avatarImage,
                    avatarImage: '',
                    appBarProfile: AppBarProfile.avatar,
                    title: 'Feed',
                  ),
                  body: const FeedPage(),
                bottomNavigationBar: MainNavigationBar(
                  focusNode: cluckNode,
                ),
                floatingActionButton: NewCluckButton(
                  focusNode: cluckNode,
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              );
            }
          }

          return const SplashScreen();
        },
        future: getCurrentUser());
  }

  Future<Object?> getCurrentUser() async {
    UserService userService = UserService();
    currentUser = await userService.getSelf();

    storage.write(key: 'id', value: currentUser.id.toString());

    return currentUser;
  }
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


class Discover extends StatelessWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Discover!', style: TextStyle(fontSize: 30),));
  }
}

