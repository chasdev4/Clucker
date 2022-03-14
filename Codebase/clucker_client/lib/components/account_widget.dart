import 'package:clucker_client/components/div.dart';
import 'package:clucker_client/components/follow_button.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:clucker_client/models/user_account_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AccountWidgetProfile { follower, discover, block }

class AccountWidget extends StatelessWidget {
  const AccountWidget(
      {Key? key,
      required this.accountWidgetProfile,
      required this.userAccountModel})
      : super(key: key);
  final UserAccountModel userAccountModel;
  final AccountWidgetProfile accountWidgetProfile;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserAvatar(
                username: userAccountModel.username,
                hue: userAccountModel.hue,
                userId: userAccountModel.id,
                avatarSize: AvatarSize.small,
              ),
              Text(
                userAccountModel.username,
                style: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.7,
                ),
              ),
            ],
          ),
          FollowButton(
            buttonProfile: FollowButtonProfile.followSmall,
            userId: userAccountModel.id,
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      const Div()
    ]);
  }
}
