import 'package:clucker_client/components/div.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/material.dart';

import '../utilities/count_format.dart';

class TabControls extends StatefulWidget with PreferredSizeWidget {
  const TabControls(
      {Key? key,
      this.userId = 0,
      required this.isSearchTabs,
      this.followerCount = 0,
      this.followingCount = 0,
      this.username = '',
      required this.height,
      this.padding = 15,
      required this.onPressedLeft,
      required this.onPressedRight})
      : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(height);

  final int userId;
  final String username;
  final bool isSearchTabs;
  final int followerCount;
  final int followingCount;
  final double height;
  final double padding;
  final Function onPressedLeft;
  final Function onPressedRight;

  @override
  _TabControlsState createState() => _TabControlsState();
}

class _TabControlsState extends State<TabControls> {
  bool leftTabActive = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                      : '${countFormat(widget.followingCount)} Following',
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
                        : '${countFormat(widget.followerCount)} Followers',
                    false),
              ],
            ),
            const Div(
              isHeader: true,
            )
          ],
        ));
  }

  SizedBox _tabButton(String text, bool isLeftTab) {
    return SizedBox(
      width: ((MediaQuery.of(context).size.width / 2) - widget.padding),
      height: widget.height,
      child: RawMaterialButton(
        onPressed: () {
          print('tab press');
          setState(() {
            if (isCluckTabAndInactive(isLeftTab: isLeftTab)) {
              widget.onPressedLeft();
              leftTabActive = true;
            } else if (isUserTabAndInactive(isLeftTab: isLeftTab)) {
              widget.onPressedRight();
              leftTabActive = false;
            } else if (widget.isSearchTabs == false && isLeftTab == true) {
             widget.onPressedLeft();
            } else if (widget.isSearchTabs == false && isLeftTab == false) {
             widget.onPressedRight();
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
              fontSize: SizeConfig.blockSizeHorizontal * 5),
        ),
      ),
    );
  }

  bool isCluckTabAndInactive({isLeftTab}) {
    return widget.isSearchTabs == true &&
        isLeftTab == true &&
        leftTabActive == false;
  }

  bool isUserTabAndInactive({isLeftTab}) {
    return widget.isSearchTabs == true &&
        isLeftTab == false &&
        leftTabActive == true;
  }
}
