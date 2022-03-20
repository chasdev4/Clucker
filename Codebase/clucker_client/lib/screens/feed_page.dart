import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/components/end_card.dart';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/services/cluck_service.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

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
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
      onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
      child: PagedListView<int, CluckModel>(
        pagingController: _pagingController,
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

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

// class FeedPage extends StatefulWidget {
//   const FeedPage({Key? key}) : super(key: key);
//
//   @override
//   State<FeedPage> createState() => _FeedPageState();
// }
//
// class _FeedPageState extends State<FeedPage> {
//   final storage = const FlutterSecureStorage();
//   final userService = UserService();
//   final cluckService = CluckService();
//   final cluckNode = FocusNode();
//   late List<Widget> cluckWidgets = [];
//   late List<CluckModel> cluckModels = [];
//   bool fetchingFeed = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               throw Exception('${snapshot.error}: ${snapshot.stackTrace}');
//             } else if (snapshot.hasData) {
//               return RefreshIndicator(
//                   triggerMode: RefreshIndicatorTriggerMode.anywhere,
//                   onRefresh: () async {
//                     fetchingFeed = true;
//                     getFeed();
//                     fetchingFeed = false;
//                   },
//                   child: ListView(children: cluckWidgets));
//             }
//           }
//
//           return const Center(
//             child: CircularProgressIndicator(strokeWidth: 5),
//           );
//         },
//         future: getFeed());
//   }
//
//   Future<Object?> getFeed() async {
//     String? timezone = await storage.read(key: 'timezone');
//     if (!fetchingFeed) {
//       cluckModels.clear();
//       cluckModels = await cluckService.getFeed();
//       UserService userService = UserService();
//       cluckWidgets.clear();
//
//       for (int i = 0; i < cluckModels.length; i++) {
//         UserAvatarModel userAvatar =
//             await userService.getUserAvatarById(cluckModels[i].userId);
//         cluckWidgets.add(CluckWidget(
//           cluck: cluckModels[i],
//           commentCount: cluckModels[i].commentCount!,
//         ));
//       }
//
//       /*TO DO Update the below conditional to only show the end widget when there's nothing left to retrieve
//     i.e.:  if (cluckWidgets.length > 2 && putLogicHere())
//                                        ^^^^^^^^^^^^^^^^^
//      */
//       if (cluckWidgets.length > 2) {
//         cluckWidgets.add(const EndCard());
//       }
//
//       return cluckModels;
//     }
//     return null;
//   }
// }
