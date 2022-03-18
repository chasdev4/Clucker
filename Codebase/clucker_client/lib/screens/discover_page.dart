import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              return RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  onRefresh: () async {
                    setState(() {
                      getDiscover();
                    });
                  },
                  child: Stack(
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
                  ));
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
    List<Widget> positiveClucks = [];
    List<Widget> negativeClucks = [];
    List<Widget> positiveUsers = [];
    List<Widget> negativeUsers = [];

    widgets = [positiveClucks, negativeClucks, positiveUsers, negativeUsers];

    return widgets;
  }
}
