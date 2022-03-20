import 'package:clucker_client/components/follow_button.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/tab_controls.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:clucker_client/models/user_result_model.dart';
import 'package:clucker_client/utilities/count_format.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.userId, required this.username})
      : super(key: key);

  final int userId;
  final String username;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late bool startedSearch;

  var searchPages = [
    const _StartSearchPage(),
    const _UserResultPage(),
    const _CluckResultPage(),
    const _NoResultsFoundPage()
  ];
  final searchNode = FocusNode();
  final cluckNode = FocusNode();
  final searchController = TextEditingController();
  late List<Widget> searchResults = [];
  late int searchPageIndex;

  @override
  void initState() {
    super.initState();
    searchPageIndex = 0;
    startedSearch = false;
  }

  @override
  void dispose() {
    searchPageIndex = 0;
    startedSearch = false;
    searchNode.dispose();
    cluckNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 150,
            backgroundColor: Palette.white,
            title: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                TextBox(
                  textBoxProfile: TextBoxProfile.searchField,
                  focusNode: searchNode,
                  extraFunction: () {
                    setState(() {
                      if (searchController.text.isEmpty && !startedSearch) {
                        searchPageIndex = 0;
                      } else {
                        startedSearch = true;
                        if (searchPageIndex == 1) {
                          //TODO: Populate Cluck Results in the method below
                          getClucks();
                        } else if (searchPageIndex == 2) {
                          //TODO: Populate User Results
                        } else {
                          searchPageIndex = 1;
                          getClucks();
                        }
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
            bottom: TabControls(
              height: SizeConfig.blockSizeHorizontal * 13,
              onPressedLeft: () {
                if (startedSearch) {
                  setState(() {
                    searchPageIndex = 1;
                  });
                }
              },
              onPressedRight: () {
                if (startedSearch) {
                  setState(() {
                    searchPageIndex = 2;
                  });
                }
              },
              isSearchTabs: true,
            ),
          )),
      body: searchPages[searchPageIndex],
    );
  }

  void getClucks() {
    throw UnimplementedError('Create the method to retrieve clucks');
  }
}

class _StartSearchPage extends StatelessWidget {
  const _StartSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Icon(FontAwesomeIcons.search,
              color: Palette.cluckerRed.toMaterialColor().shade400,
              size: MediaQuery.of(context).size.width / 2.5),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text('Start typing to search...',
                style: TextStyle(
                  color: Palette.cluckerRed.toMaterialColor().shade600,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ))),
      ],
    ));
  }
}

class _CluckResultPage extends StatefulWidget {
  const _CluckResultPage({Key? key}) : super(key: key);

  @override
  _CluckResultPageState createState() => _CluckResultPageState();
}

class _CluckResultPageState extends State<_CluckResultPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
    );
  }
}

class _UserResultPage extends StatefulWidget {
  const _UserResultPage({Key? key}) : super(key: key);

  @override
  _UserResultPageState createState() => _UserResultPageState();
}

class _UserResultPageState extends State<_UserResultPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.green,
    );
  }
}

class _NoResultsFoundPage extends StatelessWidget {
  const _NoResultsFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.7,
          child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                  'assets/icons/no_results_found_icon_512x512.png')),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text('No results found...',
                style: TextStyle(
                  color: Palette.offBlack.toMaterialColor().shade300,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ))),
      ],
    ));
  }
}

class _UserResultWidget extends StatelessWidget {
  const _UserResultWidget({
    Key? key,
    required this.userResult,
  }) : super(key: key);
  final UserResultModel userResult;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 6, bottom: 6, left: 20, right: 2),
              child: UserAvatar(
                  userId: userResult.id,
                  onProfile: false,
                  username: userResult.username,
                  hue: userResult.hue,
                  avatarSize: AvatarSize.small),
            ),
            Text(
              userResult.username,
              style: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            FollowButton(
              buttonProfile: FollowButtonProfile.followSmall,
              userId: userResult.id,
              isActive: false,
            )
          ],
        ),
        Transform.translate(
            offset: const Offset(0, -4),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${countFormat(userResult.followersCount)} Followers',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Palette.offBlack.toMaterialColor().shade700,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, -2),
                        child: Stack(
                          children: [
                            Icon(FontAwesomeIcons.egg,
                                color: Palette.cluckerRed, size: 16),
                            Positioned(
                                bottom: 0.0001,
                                right: 0.0001,
                                child: Icon(FontAwesomeIcons.plus,
                                    color: Palette.cluckerRedLight,
                                    size: 16 / 1.7))
                          ],
                        ),
                      ),
                      Text(
                        countFormat(userResult.eggRating),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Palette.cluckerRed.toMaterialColor().shade700,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
        Container(
          padding: const EdgeInsets.only(
            bottom: 12,
          ),
          width: MediaQuery.of(context).size.width - 60,
          child: Text(
            userResult.bio,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 17,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          color: Palette.lightGrey.toMaterialColor().shade400,
          height: 2.5,
          width: MediaQuery.of(context).size.width - 15 * 2,
        ),
      ],
    );
  }
}
