import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/components/end_card.dart';
import 'package:clucker_client/components/follow_button.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/tab_controls.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/models/user_result_model.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:clucker_client/utilities/count_format.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

  _SearchResultPage cluckResultPage = const _SearchResultPage(isCluckResults: true,);
  _SearchResultPage userResultPage = const _SearchResultPage(isCluckResults: false,);

  late List<Widget> searchPages;
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
    searchPages = [
      const _StartSearchPage(),
      cluckResultPage,
      userResultPage,
      const _NoResultsFoundPage()
    ];
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 12,
                ),
                TextBox(
                  textBoxProfile: TextBoxProfile.searchField,
                  focusNode: searchNode,
                  extraFunction: () {
                    setState(() {
                      cluckResultPage = _SearchResultPage(term: searchController.text, isCluckResults: (searchPageIndex == 2 ? false : true),);
                      userResultPage = _SearchResultPage(term: searchController.text, isCluckResults: (searchPageIndex == 2 ? false : true),);
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
                searchPageIndex = 1;
                if (startedSearch) {
                  setState(() {
                    searchPageIndex = 1;
                  });
                }
              },
              onPressedRight: () {
                searchPageIndex = 2;
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

class _SearchResultPage extends StatefulWidget {
  const _SearchResultPage({Key? key, this.term = '', required this.isCluckResults}) : super(key: key);
  final String term;
  final bool isCluckResults;

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<_SearchResultPage> {
  final cluckService = CluckService();
  final userService = UserService();
  static const pageSize = 15;

  final PagingController<int, CluckModel> _pagingCluckController =
  PagingController(firstPageKey: 0,);
  final PagingController<int, UserResultModel> _pagingUserController =
  PagingController(firstPageKey: 0,);

  @override
  void initState() {
      _pagingCluckController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
      _pagingUserController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      if (widget.isCluckResults){
        final cluckModels = await cluckService.getCluckResults(
            size: pageSize, page: pageKey, term: widget.term);
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
      } else {
        final userResultModels = await userService.getUserResults(
            size: pageSize, page: pageKey, term: widget.term);

        final isLastPage = userResultModels.length < pageSize;

        print(isLastPage);
        if (isLastPage) {
          _pagingUserController.appendLastPage(userResultModels);
        } else {
          _pagingUserController.appendPage(userResultModels, ++pageKey);
        }
      }
    } catch (error) {
      if (widget.isCluckResults) {
        _pagingCluckController.error = error;
      } else {
        _pagingUserController.error = error;
      }

    }
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
      onRefresh: () => Future.sync(
            () => widget.isCluckResults ? _pagingCluckController.refresh() : _pagingUserController.refresh(),
      ),
      child: widget.isCluckResults ? PagedListView<int, CluckModel>(
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
      ) : PagedListView<int, UserResultModel>(
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
