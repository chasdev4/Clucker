import 'package:clucker_client/models/user.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:clucker_client/navigation/new_cluck_button.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final userService = UserService();
  late User user;

  @override
  void initState(){
    super.initState();
    getUser();
  }

  void getUser() async {

  }

  @override
  Widget build(BuildContext context) {
    final cluckNode = FocusNode();
    return Scaffold(
      appBar: CluckerAppBar(
        user: user,
        appBarProfile: AppBarProfile.avatar,
        title: 'Feed',
      ),
      body: ListView(
        //TODO: Populate Feed
      ),
      bottomNavigationBar:  MainNavigationBar(focusNode: cluckNode,),
      floatingActionButton:  NewCluckButton(focusNode: cluckNode,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
