import 'package:clucker_client/components/account_widget.dart';
import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:clucker_client/components/page_card.dart';
import 'package:clucker_client/models/user_account_model.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

enum PageContext { followers, following }

class FollowersPage extends StatefulWidget {
  const FollowersPage({Key? key,
    required this.userId,
    required this.username,
    required this.pageContext})
      : super(key: key);

  final int userId;
  final String username;
  final PageContext pageContext;

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  static const pageSize = 15;
  late String title;
  late int followersLength = 0;
  late String? currentUserId;

  final PagingController<int, UserAccountModel> _pagingController = PagingController(
    firstPageKey: 0,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    title = widget.username + '\'';

    if (widget.username[widget.username.length - 1] != 's') {
      title += 's';
    }

    if (widget.username.length > 9) {
      title += '\n';
    } else {
      title += ' ';
    }

    switch (widget.pageContext) {
      case PageContext.followers:
        title += 'Followers';
        break;
      case PageContext.following:
        title += 'Following';
        break;
    }

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      UserService userService = UserService();

      List<UserAccountModel> followers = await userService.getFollowers(id: widget.userId, pageContext: widget.pageContext);

      const storage = FlutterSecureStorage();

      currentUserId = await storage.read(key: 'id');

      followersLength = followers.length;

      final isLastPage = followers.length < pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(followers);
      } else {
        _pagingController.appendPage(followers, ++pageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> refresh() {
    return Future.sync(() => _pagingController.refresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CluckerAppBar(
          username: widget.username,
          userId: widget.userId,
          appBarProfile: AppBarProfile.followers,
          title: title,
          fontSize: 24,
        ),
        body: RefreshIndicator(
            onRefresh: () => refresh(),
            child: PagedListView<int, UserAccountModel>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<UserAccountModel>(
                animateTransitions: true,
                noItemsFoundIndicatorBuilder: (context) {
                 return const PageCard(cardType: CardType.noItems);
                },
                itemBuilder: (context, item, index) => AccountWidget(
                  accountWidgetProfile: AccountWidgetProfile.follower,
                  userAccountModel: item,
                  deactivateFollowButton: (currentUserId == item.id.toString()) ? true : false,
                ),
              ),
            )));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
