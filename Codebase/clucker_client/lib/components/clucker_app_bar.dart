import 'package:clucker_client/components/div.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AppBarProfile { avatar, noAvatar, centered, followers }

class CluckerAppBar extends StatelessWidget with PreferredSizeWidget {
  const CluckerAppBar(
      {Key? key,
        required this.username,
        required this.userId,
      this.appBarProfile = AppBarProfile.avatar,
      required this.title,
      this.noDivider = false,
      this.fontSize = 36,
      this.height = 80,
        this.hue = 0,
       this.avatarImage})
      : super(key: key);

  final String username;
  final int userId;
  final AppBarProfile appBarProfile;
  final String title;
  final double fontSize;
  final bool? noDivider;
  final double height;
  final double hue;
  final String? avatarImage;

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
      bottom: const PreferredSize(
          child: Div(isHeader: true),
          preferredSize: Size.fromHeight(2.5)),
      title: Row(
        mainAxisAlignment: isAvatar()
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: isFollowers() && username.length > 9 ? 2 : 1,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
              child: isAvatar()
                  ? UserAvatar(
                userId: userId,
                      username: username,
                      hue: hue,
                      avatarSize: AvatarSize.medium,
                    )
                  : null)
        ],
      ),
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
