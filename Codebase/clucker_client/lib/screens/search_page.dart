import 'package:clucker_client/components/follow_button.dart';
import 'package:clucker_client/components/tab_controls.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/palette.dart';
import '../navigation/main_navigation_bar.dart';
import '../navigation/new_cluck_button.dart';
import '../utilities/count_format.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchNode = FocusNode();
  final cluckNode = FocusNode();
  late List<Widget> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchResults.add(const UserResult(
        username: 'username',
        description:
            'This is an example of a profile d es cr ip tio n, but it does not want to fit it this box for some odd peculiar reason'));
  }

  @override
  void dispose() {
    searchNode.dispose();
    cluckNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 150,
              bottom: const TabControls(
                isSearchTabs: true,
              ),
              backgroundColor: Palette.white,
              title: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  TextBox(
                      textBoxProfile: TextBoxProfile.searchField,
                      focusNode: searchNode),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ))),
      body: searchResults.isEmpty
          ? Center(
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
            ))
          : ListView(children: searchResults),
      bottomNavigationBar: MainNavigationBar(
        focusNode: cluckNode,
      ),
      floatingActionButton: NewCluckButton(focusNode: cluckNode),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class UserResult extends StatelessWidget {
  const UserResult(
      {Key? key, required this.username, required this.description})
      : super(key: key);
  final String username;
  final String description;
  final int placeholderFollowerCount = 12345;
  final int placeholderEggCount = 6789;

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
                  username: username,
                  onProfile: false,
                  avatarSize: AvatarSize.small),
            ),
            Text(
              username,
              style: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            FollowButton(buttonProfile: FollowButtonProfile.followSmall)
          ],
        ),
        Transform.translate(
            offset: Offset(0, -4),
            child: Container(
              width: MediaQuery.of(context).size.width - 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${countFormat(placeholderFollowerCount)} Followers',
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
                        countFormat(placeholderEggCount),
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
            description,
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
