import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/components/end_card.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/models/user_result_model.dart';
import 'package:clucker_client/screens/profile_page.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:clucker_client/utilities/count_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CluckResultsPage extends StatefulWidget {
  const CluckResultsPage(
      {Key? key,
      this.term = '',
      required this.returnIndex,
      this.fetchAgain = false})
      : super(key: key);
  final String term;
  final Function returnIndex;
  final bool fetchAgain;

  @override
  _CluckResultsPageState createState() => _CluckResultsPageState();
}

class _CluckResultsPageState extends State<CluckResultsPage> {
  final cluckService = CluckService();
  final userService = UserService();
  static const pageSize = 15;

  final PagingController<int, CluckModel> _pagingCluckController =
      PagingController(
    firstPageKey: 0,
  );

  @override
  void initState() {
    _pagingCluckController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingCluckController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final cluckModels = await cluckService.getCluckResults(
          size: pageSize, page: pageKey, term: widget.term);
      if (cluckModels.isEmpty) {
        widget.returnIndex(3);
      } else {
        final userService = UserService();

        for (int i = 0; i < cluckModels.length; i++) {
          final avatarData =
              await userService.getUserAvatarById(cluckModels[i].userId);
          cluckModels[i].update(avatarData.hue, avatarData.image ?? '');
        }

        final isLastPage = cluckModels.length < pageSize;

        if (isLastPage) {
          _pagingCluckController.appendLastPage(cluckModels);
        } else {
          _pagingCluckController.appendPage(cluckModels, ++pageKey);
        }
      }
    } catch (error) {
      _pagingCluckController.error = error;
    }
  }

  Future<void> refresh() {
    return Future.sync(() => _pagingCluckController.refresh());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fetchAgain) {
      refresh();
    }
    return RefreshIndicator(
        onRefresh: () => refresh(),
        child: PagedListView<int, CluckModel>(
          pagingController: _pagingCluckController,
          builderDelegate: PagedChildBuilderDelegate<CluckModel>(
            noMoreItemsIndicatorBuilder: (context) {
              return const EndCard();
            },
            animateTransitions: true,
            itemBuilder: (context, item, index) => CluckWidget(
              cluck: item,
            ),
          ),
        ));
  }
}

class UserResultsPage extends StatefulWidget {
  const UserResultsPage(
      {Key? key,
      this.term = '',
      required this.returnIndex,
      this.fetchAgain = false})
      : super(key: key);
  final String term;
  final Function returnIndex;
  final bool fetchAgain;

  @override
  _UserResultsPageState createState() => _UserResultsPageState();
}

class _UserResultsPageState extends State<UserResultsPage> {
  final userService = UserService();
  static const pageSize = 15;

  final PagingController<int, UserResultModel> _pagingUserController =
      PagingController(
    firstPageKey: 0,
  );

  @override
  void initState() {
    _pagingUserController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingUserController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final userResultModels = await userService.getUserResults(
          size: pageSize, page: pageKey, term: widget.term);
      if (userResultModels.isEmpty) {
        widget.returnIndex(3);
      } else {
        final isLastPage = userResultModels.length < pageSize;

        if (isLastPage) {
          _pagingUserController.appendLastPage(userResultModels);
        } else {
          _pagingUserController.appendPage(userResultModels, ++pageKey);
        }
      }
    } catch (error) {
      _pagingUserController.error = error;
    }
  }

  Future<void> refresh() {
    return Future.sync(() => _pagingUserController.refresh());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fetchAgain) {
      refresh();
    }
    return RefreshIndicator(
        onRefresh: () => refresh(),
        child: PagedListView<int, UserResultModel>(
          pagingController: _pagingUserController,
          builderDelegate: PagedChildBuilderDelegate<UserResultModel>(
            noMoreItemsIndicatorBuilder: (context) {
              return const EndCard();
            },
            animateTransitions: true,
            itemBuilder: (context, item, index) => _UserResultWidget(
              userResult: item,
            ),
          ),
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
                  avatarImage: userResult.avatarImage ?? '',
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
              SizedBox(
                width: 40,
                height: 40,
                child: RawMaterialButton(
                  child: Icon(
                    CupertinoIcons.forward,
                    color: Palette.offBlack,
                  ),
                  onPressed: () async {
                    final userService = UserService();
                    String? currentUser = await userService.storage.read(key: 'id');
                    final profile = await userService.getUserProfileById(userResult.id);

                    final profileData = ProfileData(
                        userId: profile.id,
                        username: profile.username,
                        bio: profile.bio,
                        hue: profile.hue,
                        avatarImage: profile.avatarImage,
                        followersCount: profile.followersCount,
                        followingCount: profile.followingCount,
                        eggRating: profile.eggRating,
                        joined: profile.joined,
                        isFollowed: profile.isFollowed,
                        deactivateFollowButton: (currentUser == profile.id.toString()));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(profileData: profileData),
                        ));
                  },
                ),
              ),
            const SizedBox(width: 15,)
            // FollowButton(
            //   buttonProfile: FollowButtonProfile.followSmall,
            //   userId: userResult.id,
            //   isActive: false,
            // )
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
