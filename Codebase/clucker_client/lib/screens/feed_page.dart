import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/models/user_avatar_model.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  late List<Widget> cluckWidgets;

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
              throw Exception('${snapshot.error}: ${snapshot.stackTrace}');
            } else if (snapshot.hasData) {
              return RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  onRefresh: () async {
                    setState(() {
                      getFeed();
                    });
                  },
                  child: ListView(children: cluckWidgets));
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
    UserService userService = UserService();
    cluckWidgets.clear();

    for (int i = 0; i < clucks.length; i++) {
       UserAvatarModel userAvatar =
           await userService.getUserAvatarById(clucks[i].userId);
      cluckWidgets.add(CluckWidget(
         hue: userAvatar.hue,
        avatarImage: userAvatar.image ?? '',
        cluck: clucks[i],
        commentCount: clucks[i].commentCount!,
      ));
    }

    /*TODO: Update the below conditional to only show the end widget when there's nothing left to retrieve
    i.e.:  if (cluckWidgets.length > 2 && putLogicHere())
                                       ^^^^^^^^^^^^^^^^^
     */
    if (cluckWidgets.length > 2) {
      cluckWidgets.add(SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height / 3,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.egg,
                    size: 100,
                    color: Palette.cluckerRed
                        .toMaterialColor()
                        .shade200),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'You\'ve reached the end!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Palette.offBlack
                              .toMaterialColor()
                              .shade100,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                      maxLines: 2,
                    )),
              ]),
        ),
      ));
    }
      return Future.delayed(const Duration(seconds: 2), () {
        return clucks;
      });
    }
}
