import 'package:clucker_client/components/cluck.dart';
import 'package:clucker_client/components/follow_button.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/tab_controls.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../navigation/main_navigation_bar.dart';
import '../navigation/new_cluck_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    final cluckNode = FocusNode();
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          ProfileHeader(username: username),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Cluck(
                  postDate: DateTime.now(),
                  cluckText: 'Test',
                  eggCount: 20,
                  username: username,
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar:  MainNavigationBar(focusNode: cluckNode),
      floatingActionButton:  NewCluckButton(focusNode: cluckNode),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    const List<String> _profileOptionTexts = [
      'Edit Profile',
      'Settings',
      'Log Out'
    ];

    const List<String> _blockOptionText = ['Block'];

    final NumberFormat eggCountFormat = NumberFormat.decimalPattern('en_us');
    final DateFormat joinDateFormat = DateFormat('MMM dd, yyyy');

    int placeholderEggCount = 1234512345;
    DateTime placeholderJoinDate = DateTime.now();
    String placeholderDescription =
        'Save time. Live faster. Follow our profile for new job postings! Or visit our website at example.com';

    return SliverAppBar(
      elevation: 0,
      backgroundColor: Palette.white,
      snap: true,
      pinned: false,
      collapsedHeight: 70,
      stretch: false,
      expandedHeight: MediaQuery.of(context).size.height * 0.3725,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.066,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    UserAvatar(
                        username: widget.username,
                        avatarSize: AvatarSize.large,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: isUserOnOwnProfile() ? null : const FollowButton(
                          buttonProfile: FollowButtonProfile.follow,
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 22),
                        child: Text(
                          widget.username,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Palette.black,
                          ),
                        ))
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${eggCountFormat.format(placeholderEggCount)}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Palette.cluckerRed,
                              ),
                            ),
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
                            )
                          ]),
                      Text(
                        'Joined ${joinDateFormat.format(placeholderJoinDate)}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Palette.offBlack.toMaterialColor().shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text(
                      placeholderDescription,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 16,
                        color: Palette.black,
                      ),
                    ),
                  ),
                ),
                TabControls(
                  isSearchTabs: false,
                  username: widget.username,
                )
              ],
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.066 + 1,
                right: 0,
                child: PopupMenuButton(
                    onSelected: (String selection) {
                      switch (selection) {
                        case 'Block':
                          //TODO: Block user
                          break;
                        case 'Edit Profile':
                          //TODO: Go to edit profile page
                          break;
                        case 'Settings':
                          //TODO: Go to Settings
                          break;
                        case 'Log Out':
                          //TODO: Log user out of Clucker
                          break;
                      }
                    },
                    iconSize: 30,
                    itemBuilder: (BuildContext context) {
                      TextStyle textStyle = const TextStyle();
                      return (isUserOnOwnProfile())
                          ? _profileOptionTexts.map((String choice) {
                              if (choice == 'Log Out') {
                                textStyle =
                                    TextStyle(color: Palette.cluckerRed);
                              } else {
                                textStyle = TextStyle(color: Palette.black);
                              }

                              return PopupMenuItem<String>(
                                value: choice,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: Text(
                                      choice,
                                      style: textStyle,
                                    )),
                              );
                            }).toList()
                          : _blockOptionText.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                    }))
          ],
        ),
      ),
    );
  }

  bool isUserOnOwnProfile() {
    String placeholderCurrentUser = 'user';
    return widget.username == placeholderCurrentUser;
  }
}
