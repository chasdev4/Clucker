import 'package:clucker_client/components/div.dart';
import 'package:clucker_client/components/follow_button.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:clucker_client/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AccountWidgetProfile {
  follower, discover, block
}

class AccountWidget extends StatelessWidget {
  const AccountWidget({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
      const SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
                UserAvatar(
                 username: user.username,
                 userHue: user.hue,
                 userId: user.id,
                 avatarSize: AvatarSize.small,),
              Text(
                user.username,
                style: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.7,
                ),
              ),
            ],
          ),
          FollowButton(buttonProfile: FollowButtonProfile.followSmall, userId: user.id,)
        ],
      ),
      const SizedBox(height: 10,),
      const Div()
    ]);
  }
}
