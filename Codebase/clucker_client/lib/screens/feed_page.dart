import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final storage = const FlutterSecureStorage();
  final userService = UserService();
  final cluckService = CluckService();
  final cluckNode = FocusNode();
  late List<CluckWidget> cluckWidgets;

  @override
  void initState() {
    super.initState();
    cluckWidgets = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error}. ${snapshot.stackTrace}',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                return
                  RefreshIndicator(
                  onRefresh: () async {
                    getFeed();
                  },
                  child: ListView(children: cluckWidgets)

                );
              }
            }

            return const Center(
              child: CircularProgressIndicator(strokeWidth: 5),
            );
          },
          future: getFeed());
  }

  Future<Object?> getFeed() async {
    String? token = await storage.read(key: 'authorization');
    List<CluckModel> clucks = await cluckService.getFeed(token!);
    //UserService userService = UserService();
    cluckWidgets.clear();

    for (int i = 0; i < clucks.length; i++) {
      // UserAvatarModel userAvatar =
      //     await userService.getUserAvatarById(clucks[i].userId);

        cluckWidgets.add(CluckWidget(
          //TODO: update hue
          // hue: userAvatar.hue,
          hue: 0,
          //TODO: update avatarImage
          // avatarImage: userAvatar.image!,
          avatarImage: '',
          cluck: clucks[i],
          commentCount: 0,
          //TODO: update commentCount
          //commentCount: clucks[i].commentCount,
        ));
    }

    return Future.delayed(const Duration(seconds: 2), () {
      return clucks;
    });
  }
}
