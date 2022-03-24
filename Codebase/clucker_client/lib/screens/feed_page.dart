import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/components/page_card.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key, this.fetchAgain = false}) : super(key: key);

  final bool fetchAgain;

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final cluckService = CluckService();
  static const pageSize = 15;

  final PagingController<int, CluckModel> _pagingController =
      PagingController(firstPageKey: 0,);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final cluckModels =
          await cluckService.getFeed(size: pageSize, page: pageKey);
      final userService = UserService();

      for (int i = 0; i < cluckModels.length; i++) {
        final avatarData =
            await userService.getUserAvatarById(cluckModels[i].userId);
        cluckModels[i].update(avatarData.hue, avatarData.image ?? '');
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

  Future<void> refresh() {
    return Future.sync(() => _pagingController.refresh());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fetchAgain) {
      refresh();
    }
    return RefreshIndicator(
        onRefresh: () => refresh(),
        child: PagedListView<int, CluckModel>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<CluckModel>(
            noMoreItemsIndicatorBuilder: (context) {
              return const PageCard(cardType: CardType.endCard,);
            },
            animateTransitions: true,
            itemBuilder: (context, item, index) => CluckWidget(
              cluck: item,
            ),
          ),
        ));
  }

  @override
  void dispose() {
    //_pagingController.dispose();
    super.dispose();
  }
}
