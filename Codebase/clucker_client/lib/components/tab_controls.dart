import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';

class TabControls extends StatefulWidget with PreferredSizeWidget {
  const TabControls({
    Key? key,
    required this.isSearchTabs,
    this.height = 46,
    this.padding = 15,
  }) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(height);

  final bool isSearchTabs;
  final double height;
  final double padding;

  @override
  _TabControlsState createState() => _TabControlsState();
}

class _TabControlsState extends State<TabControls> {
  String followerCount = '2.3K';
  String followingCount = '4.5M';
  bool leftTabActive = true;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TabButton(
              (widget.isSearchTabs == true)
                  ? 'Clucks'
                  : '$followingCount Following',
              true,
            ),
            Container(
              width: 3,
              height: widget.height,
              color: Palette.lightGrey,
            ),
            _TabButton(
                (widget.isSearchTabs == true)
                    ? 'Users'
                    : '$followerCount Followers',
                false),
          ],
        ),
        PreferredSize(
          preferredSize: const Size.fromHeight(2.5),
          child: Container(
            color: Palette.cluckerRed,
            height: 2.5,
            width: MediaQuery.of(context).size.width - widget.padding * 2,
          ),
        ),
      ],
    ));
  }

  SizedBox _TabButton(String text, bool isLeftTab) {
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
