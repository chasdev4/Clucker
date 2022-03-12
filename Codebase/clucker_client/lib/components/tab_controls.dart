import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/models/user.dart';
import 'package:clucker_client/screens/followers_page.dart';
import 'package:flutter/material.dart';

import '../utilities/count_format.dart';

class TabControls extends StatefulWidget with PreferredSizeWidget {
  const TabControls({
    Key? key,
    required this.isSearchTabs,
    this.user,
    this.height = 46,
    this.padding = 15,
  }) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(height);

  final User? user;
  final bool isSearchTabs;
  final double height;
  final double padding;

  @override
  _TabControlsState createState() => _TabControlsState();
}

class _TabControlsState extends State<TabControls> {
  int followerCount = 43212;
  int followingCount = 1234567;
  bool leftTabActive = true;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tabButton(
              (widget.isSearchTabs == true)
                  ? 'Clucks'
                  : '${countFormat(followingCount)} Following',
              true,
            ),
            Container(
              width: 3,
              height: widget.height,
              color: Palette.lightGrey,
            ),
            _tabButton(
                (widget.isSearchTabs == true)
                    ? 'Users'
                    : '${countFormat(followerCount)} Followers',
                false),
          ],
        ),
        Container(
            color: Palette.cluckerRed,
            height: 2.5,
            width: MediaQuery.of(context).size.width - widget.padding * 2,
          ),
      ],
    ));
  }

  SizedBox _tabButton(String text, bool isLeftTab) {
    return SizedBox(
      width: ((MediaQuery.of(context).size.width / 2) - widget.padding),
      height: widget.height,
      child: RawMaterialButton(
        onPressed: () {
          setState(() {
            if (widget.isSearchTabs == true &&
                isLeftTab == true &&
                leftTabActive == false) {
              leftTabActive = true;
            } else if (widget.isSearchTabs == true &&
                isLeftTab == false &&
                leftTabActive == true) {
              leftTabActive = false;
            } else if (widget.isSearchTabs == false && isLeftTab == true) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FollowersPage(user: widget.user!, pageContext: PageContext.following)));
            } else if (widget.isSearchTabs == false && isLeftTab == false) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) =>
                  FollowersPage(user: widget.user!, pageContext: PageContext.followers)));
            }
          });
        },
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: ((widget.isSearchTabs == true &&
                          leftTabActive == true &&
                          isLeftTab == true) ||
                      (widget.isSearchTabs == true &&
                          leftTabActive == false &&
                          isLeftTab == false))
                  ? Palette.cluckerRed
                  : Palette.black,
              fontSize: 20),
        ),
      ),
    );
  }
}
