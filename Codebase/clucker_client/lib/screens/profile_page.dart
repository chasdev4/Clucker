import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/components/follow_button.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/tab_controls.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:clucker_client/models/user_profile_model.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../models/cluck_model.dart';
import '../navigation/main_navigation_bar.dart';
import '../navigation/new_cluck_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.userId, required this.avatarImage, required this.hue}) : super(key: key);

  final int userId;
  final String? avatarImage;
  final double hue;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late List<Widget> cluckWidgets;
  late ProfileData profileData;
  late SliverList cluckList;

  @override
  Widget build(BuildContext context) {
    final cluckNode = FocusNode();
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return ProfileHeader(
                          profileData: profileData,
                          avatarImage: widget.avatarImage,
                        );
                      }
                    }

                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 5),
                    );
                  },
                  future: getProfileDetails())),
          SliverToBoxAdapter(
              child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return cluckWidgets[index];
                            },
                            childCount: cluckWidgets.length,
                          ),
                        );
                      }
                    }

                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 5),
                    );
                  },
                  future: getClucks())),
        ],
      ),
      bottomNavigationBar: MainNavigationBar(focusNode: cluckNode),
      floatingActionButton: NewCluckButton(focusNode: cluckNode),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<Object?> getProfileDetails() async {
    final UserService userService = UserService();
    UserProfileModel userProfileModel = await userService.getUserProfileById(widget.userId);

    setState(() {
      profileData = ProfileData(
          userId: userProfileModel.id,
          username: userProfileModel.username,
          bio: userProfileModel.bio,
          hue: userProfileModel.hue,
          eggRating: userProfileModel.eggRating,
          joined: userProfileModel.joined);
    });

    return Future.delayed(const Duration(seconds: 2), () {
      return profileData;
    });
  }

  Future<Object?> getClucks() async {
    cluckWidgets.clear();

    final CluckService cluckService = CluckService();
    List<CluckModel> clucks = await cluckService.getProfileClucksById(widget.userId);

    for (int i = 0; i < clucks.length; i++) {
      cluckWidgets.add(CluckWidget(
        avatarImage: widget.avatarImage,
          hue: widget.hue,
          cluck: clucks[i],
          commentCount: clucks[i].commentCount));
    }

    return Future.delayed(const Duration(seconds: 2), () {
      return cluckWidgets;
    });
  }
}

class ProfileData {
  const ProfileData(
      {required this.userId,
      required this.username,
      required this.bio,
      required this.hue,
      required this.eggRating,
      required this.joined,
      requi});

  final int userId;
  final String username;
  final String bio;
  final double hue;
  final int eggRating;
  final DateTime joined;
}

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key, required this.profileData, required this.avatarImage}) : super(key: key);

  final ProfileData profileData;
  final String? avatarImage;

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

    return SliverAppBar(
      automaticallyImplyLeading: false,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: UserAvatar(
                        hue: widget.profileData.hue,
                        avatarImage: widget.avatarImage!,
                        username: widget.profileData.username,
                        userId: widget.profileData.userId,
                        avatarSize: AvatarSize.large,
                        onProfile: true,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: isUserOnOwnProfile()
                            ? null
                            : FollowButton(
                                buttonProfile: FollowButtonProfile.follow,
                          userId: widget.profileData.userId,
                              ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 22),
                        child: Text(
                          widget.profileData.username,
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
                              eggCountFormat
                                  .format(widget.profileData.eggRating),
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
                        'Joined ${joinDateFormat.format(widget.profileData.joined)}',
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
                      widget.profileData.bio,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 16,
                        color: Palette.black,
                      ),
                    ),
                  ),
                ),
                TabControls(
                  onPressedLeft: (){},
                  onPressedRight: (){},
                  isSearchTabs: false,
                  userId: widget.profileData.userId,
                  username: widget.profileData.username,
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
    String placeholderCurrentUser = 'TheCluckMan';
    return widget.profileData.username == placeholderCurrentUser;
  }
}
