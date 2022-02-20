import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';

class TabControls extends StatefulWidget with PreferredSizeWidget {
  const TabControls(
      {Key? key,
      required this.isSearchTabs,
      this.height = 48,
      this.padding = 15})
      : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TabButton((widget.isSearchTabs == true)
                ? 'Clucks'
                : '$followingCount Following'),
            Container(
              width: 3,
              height: widget.height,
              color: Palette.lightGrey,
            ),
            TabButton((widget.isSearchTabs == true)
                ? 'Users'
                : '$followerCount Followers'),
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

  Container TabButton(String text) {
    return Container(
      width: ((MediaQuery.of(context).size.width / 2) - widget.padding),
      height: widget.height,
      child: RawMaterialButton(
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Palette.black,
                fontSize: 18),
          ),
        ),
    );
  }
}
