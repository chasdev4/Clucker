import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/components/follow_button.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/tab_controls.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:clucker_client/models/user_profile_model.dart';
import 'package:clucker_client/screens/login_page.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../models/cluck_model.dart';
import '../navigation/main_navigation_bar.dart';
import '../navigation/new_cluck_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(
      {Key? key,
      required this.userId,
      this.avatarImage = '',
      required this.hue})
      : super(key: key);

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
    final cluckNode = FocusNode();
    return FutureBuilder(
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
              return Scaffold(
                body: CustomScrollView(slivers: <Widget>[
                  ProfileHeader(
                    profileData: profileData,
                    avatarImage: widget.avatarImage ?? '',
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return RefreshIndicator(
                            onRefresh: () async {
                              getProfileDetails();
                            },
                            child: cluckWidgets[index]);
                      },
                      childCount: cluckWidgets.length,
                    ),
                  )
                ]),
                bottomNavigationBar: MainNavigationBar(focusNode: cluckNode),
                floatingActionButton: NewCluckButton(focusNode: cluckNode),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
              );
            }
          }

          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(strokeWidth: 5),
          ));
        },
        future: getProfileDetails());
  }

  Future<Object?> getProfileDetails() async {
    cluckWidgets.clear();

    final CluckService cluckService = CluckService();
    List<CluckModel> clucks =
        await cluckService.getProfileClucksById(widget.userId);

    for (int i = 0; i < clucks.length; i++) {
        cluckWidgets.add(CluckWidget(
            avatarImage: widget.avatarImage,
            hue: widget.hue,
            cluck: clucks[i],
            //TODO: update commentCount
            commentCount: 0));
      //commentCount: clucks[i].commentCount));
    }

    final UserService userService = UserService();
    UserProfileModel userProfileModel =
        await userService.getUserProfileById(widget.userId);

    const storage = FlutterSecureStorage();
    String? currentUserId = await storage.read(key: 'id');
    bool isUserOnOwnProfile = userProfileModel.id.toString() == currentUserId;

    profileData = ProfileData(
        userId: userProfileModel.id,
        username: userProfileModel.username,
         bio: userProfileModel.bio,
        hue: 0,
        // hue: userProfileModel.hue,
        followersCount: userProfileModel.followersCount,
        followingCount: userProfileModel.followingCount,
        eggRating: userProfileModel.eggRating,
        joined: userProfileModel.joined,
        cluckWidgets: cluckWidgets,
        isUserOnOwnProfile: isUserOnOwnProfile);

    return Future.delayed(const Duration(seconds: 2), () {
      return profileData;
    });
  }
}

class ProfileData {
  const ProfileData(
      {required this.userId,
      required this.username,
      required this.bio,
      required this.hue,
      required this.followersCount,
      required this.followingCount,
      required this.eggRating,
      required this.joined,
      required this.cluckWidgets,
      required this.isUserOnOwnProfile});

  final int userId;
  final String username;
  final String bio;
  final double hue;
  final int followersCount;
  final int followingCount;
  final int eggRating;
  final String joined;
  final List<Widget> cluckWidgets;
  final bool isUserOnOwnProfile;
}

class ProfileHeader extends StatefulWidget {
  const ProfileHeader(
      {Key? key, required this.profileData, required this.avatarImage})
      : super(key: key);

  final ProfileData profileData;
  final String? avatarImage;

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  late List<Widget> body = [];

  @override
  void initState() {
    super.initState();
    getBio();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
      elevation: 6,
      backgroundColor: Palette.white,
      snap: true,
      pinned: false,
      collapsedHeight: 70,
      stretch: false,
      expandedHeight: SizeConfig.blockSizeHorizontal * 25 +
          (body.isEmpty || bioLength() == 0
              ? SizeConfig.blockSizeHorizontal * 39
              : body.length == 1
                  ? SizeConfig.blockSizeHorizontal * 47
                  : body.length == 2
                      ? SizeConfig.blockSizeHorizontal * 51
                      : body.length == 3
                          ? SizeConfig.blockSizeHorizontal * 55
                          : 0),
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * (5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
                      child: UserAvatar(
                        hue: widget.profileData.hue,
                        avatarImage: widget.avatarImage!,
                        username: widget.profileData.username,
                        userId: widget.profileData.userId,
                        avatarSize: AvatarSize.large,
                        onProfile: true,
                      ),
                    ),
                    Transform.translate(
                        offset: Offset(0, SizeConfig.blockSizeHorizontal * 5),
                        child: widget.profileData.isUserOnOwnProfile
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
                            fontSize: SizeConfig.blockSizeHorizontal * 7,
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
                                fontSize: SizeConfig.blockSizeHorizontal * 3.9,
                                fontWeight: FontWeight.w400,
                                color: Palette.cluckerRed,
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(0, -2),
                              child: Stack(
                                children: [
                                  Icon(FontAwesomeIcons.egg,
                                      color: Palette.cluckerRed,
                                      size:
                                          SizeConfig.blockSizeHorizontal * 3.9),
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
                        'Joined ${joinDateFormat.format(DateTime.parse(widget.profileData.joined))}',
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 4,
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
                      height: body.isEmpty || bioLength() == 0
                          ? 0
                          : body.length == 1
                              ? SizeConfig.blockSizeHorizontal * 8
                              : body.length == 2
                                  ? SizeConfig.blockSizeHorizontal * 12
                                  : body.length == 3
                                      ? SizeConfig.blockSizeHorizontal * 16
                                      : 0,
                      child: Column(
                        children: body,
                      )),
                ),
                TabControls(
                  onPressedLeft: () {},
                  onPressedRight: () {},
                  height: SizeConfig.blockSizeHorizontal * 13,
                  followerCount: widget.profileData.followersCount,
                  followingCount: widget.profileData.followingCount,
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
                          //TODO: Test log out
                          const storage = FlutterSecureStorage();
                          storage.delete(key: 'authentication');
                          while (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );

                          break;
                      }
                    },
                    iconSize: 30,
                    itemBuilder: (BuildContext context) {
                      TextStyle textStyle = const TextStyle();
                      return widget.profileData.isUserOnOwnProfile
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

  int bioLength() {
    return widget.profileData.bio.length;
  }

  void getBio() {
    List<String> bio = widget.profileData.bio.split(' ');
    String bioLine = '';
    int bioLineLength = 0;

    for (int i = 0; i < bio.length; i++) {
      bioLine += bio[i];
      if (i != bio.length - 1) {
        bioLine += ' ';
      }
      bioLineLength = bioLine.length;
      if (bioLineLength > 39 || i == bio.length - 1) {
        body.add(lineBuilder(bioLine));
        bioLine = '';
        bioLineLength = 0;
      }
    }

    print('${body.length}');
  }

  Widget lineBuilder(String str) {
    return Row(children: [
      Text(
        str,
        maxLines: 1,
        style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 4.4,
          color: Palette.black,
        ),
      )
    ]);
  }
}
