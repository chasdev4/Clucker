import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/components/follow_button.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/tab_controls.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/models/user_profile_model.dart';
import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:clucker_client/navigation/new_cluck_button.dart';
import 'package:clucker_client/screens/edit_profile_page.dart';
import 'package:clucker_client/screens/followers_page.dart';
import 'package:clucker_client/screens/login_page.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:clucker_client/components/end_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.profileData}) : super(key: key);

  final ProfileData profileData;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cluckNode = FocusNode();
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        ProfileHeader(
          profileData: widget.profileData,
        ),
        ProfileBody(userId: widget.profileData.userId),
      ]),
      bottomNavigationBar: MainNavigationBar(
        focusNode: cluckNode,
        sendIndex: (value) {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: NewCluckButton(
        fetchFeedPageAgain: () {
          return false;
        },
        userId: widget.profileData.userId,
        username: widget.profileData.username,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final cluckService = CluckService();
  static const pageSize = 15;

  final PagingController<int, CluckModel> _pagingController = PagingController(
    firstPageKey: 0,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final userService = UserService();
      UserProfileModel userProfileModel =
          await userService.getUserProfileById(widget.userId);

      final cluckModels = await cluckService.getProfileClucksById(
          widget.userId, pageSize, pageKey);

      for (int i = 0; i < cluckModels.length; i++) {
        cluckModels[i]
            .update(userProfileModel.hue, userProfileModel.avatarImage);
      }

      final isLastPage = cluckModels.length < pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(cluckModels);
      } else {
        _pagingController.appendPage(cluckModels, ++pageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => PagedSliverList<int, CluckModel>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<CluckModel>(
        noMoreItemsIndicatorBuilder: (context) {
          return const EndCard();
        },
        animateTransitions: true,
        itemBuilder: (context, item, index) => CluckWidget(
          cluck: item,
        ),
      ));

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key, required this.profileData}) : super(key: key);

  final ProfileData profileData;

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

    late List<String> profileOptions = [
      widget.profileData.deactivateFollowButton ? 'Edit Profile' : 'Block',
      'Settings',
      'Log Out'
    ];

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
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1),
                      child: UserAvatar(
                        hue: widget.profileData.hue,
                        avatarImage: widget.profileData.avatarImage!,
                        username: widget.profileData.username,
                        userId: widget.profileData.userId,
                        avatarSize: AvatarSize.large,
                        onProfile: true,
                      ),
                    ),
                    Transform.translate(
                        offset: Offset(0, SizeConfig.blockSizeHorizontal * 5),
                        child: FollowButton(
                          buttonProfile: FollowButtonProfile.follow,
                          userId: widget.profileData.userId,
                          deactivate: widget.profileData.deactivateFollowButton,
                          isActive: widget.profileData.isFollowed,
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
                  onPressedLeft: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FollowersPage(
                                userId: widget.profileData.userId,
                                username: widget.profileData.username,
                                pageContext: PageContext.following)));
                  },
                  onPressedRight: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FollowersPage(
                                userId: widget.profileData.userId,
                                username: widget.profileData.username,
                                pageContext: PageContext.followers)));
                  },
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
                        case 'Edit Profile':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                  refresh: () {
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => ProfilePage(profileData: widget.profileData)),);
                                  },
                                    username: widget.profileData.username,
                                    userId: widget.profileData.userId,
                                    bio: widget.profileData.bio)),
                          );
                          break;
                        case 'Block':
                          //TODO: Block user
                          break;
                        case 'Settings':
                          //TODO: Go to Settings
                          break;
                        case 'Log Out':
                          const storage = FlutterSecureStorage();
                          storage.deleteAll();
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
                      return profileOptions.map((String choice) {
                        if (choice == 'Log Out') {
                          textStyle = TextStyle(color: Palette.cluckerRed);
                        } else {
                          textStyle = TextStyle(color: Palette.black);
                        }

                        return PopupMenuItem<String>(
                          value: choice,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: Text(
                                choice,
                                style: textStyle,
                              )),
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
    bool forceNewLine = false;
    String tempLastWord = '';

    for (int i = 0; i < bio.length; i++) {
      if (forceNewLine) {
        forceNewLine = false;
        bioLine += tempLastWord + ' ';
      }
      if (bioLineLength + bio[i].length < 40) {
        bioLine += bio[i];
        if (i != bio.length - 1) {
          bioLine += ' ';
        }
        bioLineLength = bioLine.length;
      } else {
        forceNewLine = true;
      }
      if (bioLineLength > 39 || i == bio.length - 1 || forceNewLine) {
        if (forceNewLine) {
          tempLastWord = bio[i];
        }
        body.add(lineBuilder(bioLine));
        bioLine = '';
        bioLineLength = 0;
      }
    }
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

class ProfileData {
  const ProfileData(
      {required this.userId,
      required this.username,
      required this.bio,
      required this.hue,
      required this.avatarImage,
      required this.followersCount,
      required this.followingCount,
      required this.eggRating,
      required this.joined,
      required this.isFollowed,
      required this.deactivateFollowButton});

  final int userId;
  final String username;
  final String bio;
  final double hue;
  final String? avatarImage;
  final int followersCount;
  final int followingCount;
  final int eggRating;
  final String joined;
  final bool isFollowed;
  final bool deactivateFollowButton;
}
