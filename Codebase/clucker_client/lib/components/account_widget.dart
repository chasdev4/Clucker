import 'package:clucker_client/components/div.dart';
import 'package:clucker_client/components/follow_button.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:clucker_client/models/user_account_model.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AccountWidgetProfile { follower, discover, block }

class AccountWidget extends StatelessWidget {
  const AccountWidget(
      {Key? key,
      required this.accountWidgetProfile,
        this.deactivateFollowButton = false,
      required this.userAccountModel})
      : super(key: key);
  final UserAccountModel userAccountModel;
  final AccountWidgetProfile accountWidgetProfile;
  final bool deactivateFollowButton;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                  UserAvatar(
                    username: userAccountModel.username,
                    hue: userAccountModel.hue,
                    avatarImage: userAccountModel.avatarImage,
                    userId: userAccountModel.id,
                    avatarSize: AvatarSize.smallMedium,
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
                deactivate: deactivateFollowButton,
                isActive: false,
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
