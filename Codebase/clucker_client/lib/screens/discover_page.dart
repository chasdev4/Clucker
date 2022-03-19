import 'package:clucker_client/components/account_widget.dart';
import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/models/user_account_model.dart';
import 'package:clucker_client/models/user_avatar_model.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late List<List<Widget>> widgets = [];
  int discoverPageIndex = 0;
  late List<IconData> icons = [
    CupertinoIcons.arrowtriangle_up_fill,
    CupertinoIcons.arrowtriangle_down_fill
  ];

  final List<String> discoverFilters = ['Good', 'Bad'];
  late String discoverText = discoverFilters[0];
  late bool selection = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
              return Stack(
                    children: [
                      ListView(children: widgets[discoverPageIndex]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          MaterialButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(icons[selection ? 0 : 1]),
                                  Text(discoverFilters[selection ? 0 : 1]),
                                  SizedBox(width: SizeConfig.blockSizeHorizontal * 0.5,)
                                ],
                              ),
                              onPressed: () {
                                setState(() {
                                  selection = !selection;
                                });
                              })
                      ],)

                    ],
                  );
            }
          }

          return const Center(
            child: CircularProgressIndicator(strokeWidth: 5),
          );
        },
        future: getDiscover());
  }

  Future<Object?> getDiscover() async {
    //TODO: Grab lists
    List<CluckModel> positiveCluckModels = [];
    List<CluckModel> negativeCluckModels = [];
    List<UserAccountModel> positiveUserModels = [];
    List<UserAccountModel> negativeUserModels = [];

    List<Widget> positiveClucks = [];
    List<Widget> negativeClucks = [];
    List<Widget> positiveUsers = [];
    List<Widget> negativeUsers = [];

    for (int i = 0; i < positiveCluckModels.length; i++) {
      if (i < positiveUserModels.length) {
        positiveUsers.add(AccountWidget(
            accountWidgetProfile: AccountWidgetProfile.discover,
            userAccountModel: positiveUserModels[i]));
        negativeUsers.add(AccountWidget(
            accountWidgetProfile: AccountWidgetProfile.discover,
            userAccountModel: negativeUserModels[i]));
      }
      final userService = UserService();
      UserAvatarModel userAvatar =
      await userService.getUserAvatarById(positiveCluckModels[i].userId);

      positiveClucks.add(CluckWidget(cluck: positiveCluckModels[i], hue: userAvatar.hue, avatarImage: userAvatar.image));

      userAvatar =
      await userService.getUserAvatarById(negativeCluckModels[i].userId);

      negativeClucks.add(CluckWidget(cluck: negativeCluckModels[i], hue: userAvatar.hue, avatarImage: userAvatar.image));
    }

    widgets = [positiveClucks, negativeClucks, positiveUsers, negativeUsers];

    return widgets;
  }
}
