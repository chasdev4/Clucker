import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AppBarProfile { avatar, noAvatar, centered, followers }

class CluckerAppBar extends StatelessWidget with PreferredSizeWidget {
  const CluckerAppBar(
      {Key? key,
      this.appBarProfile = AppBarProfile.avatar,
      required this.title,
      this.noDivider = false,
      this.padding = 15,
      this.fontSize = 36,
      this.height = 80})
      : super(key: key);

  final AppBarProfile appBarProfile;
  final String title;
  final double fontSize;
  final double padding;
  final bool? noDivider;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: isFollowers()
          ? IconButton(
              icon: Icon(
                FontAwesomeIcons.arrowLeft,
                color: Palette.black,
              ),
              iconSize: 25,
              onPressed: () {
                Navigator.pop(context);
              })
          : null,
      toolbarHeight: height,
      elevation: 0,
      bottomOpacity: noDivider == true ? 0 : 1,
      bottom: PreferredSize(
          child: Container(
            color: Palette.cluckerRed,
            height: 2.5,
            width: MediaQuery.of(context).size.width - padding * 2,
          ),
          preferredSize: const Size.fromHeight(2.5)),
      title: Row(mainAxisAlignment: isAvatar() ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,children: [
        Text(
          title,
          maxLines: isFollowers() ? 2 : 1,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Container(child:
        isAvatar()
            ? UserAvatar()
            : null)
      ],),
    );
  }

  bool isAvatar() {
    return appBarProfile == AppBarProfile.avatar;
  }

  bool isFollowers() {
    return appBarProfile == AppBarProfile.followers;
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
