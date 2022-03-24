import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/material.dart';

enum FollowButtonProfile { follow, followSmall, block }

class FollowButton extends StatefulWidget {
  const FollowButton({
    Key? key,
    required this.buttonProfile,
    required this.userId,
    required this.isActive,
    this.deactivate = false,
  }) : super(key: key);

  final FollowButtonProfile buttonProfile;
  final int userId;
  final bool isActive;
  final bool deactivate;

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  final userService = UserService();
  late bool isSecondary;

  @override
  void initState() {
    super.initState();
    isSecondary = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Color textColor =
        (isSecondary == true) ? Palette.cluckerRed : Palette.white;
    Color buttonColor =
        (isSecondary == false) ? Palette.cluckerRed : Palette.white;

    Size buttonSize = Size(SizeConfig.blockSizeHorizontal * 25, SizeConfig.blockSizeHorizontal * 11.5);

    return Padding(
      child: widget.deactivate ? null : ElevatedButton(
        child: Text(
          isNotFollowed()
              ? 'Follow'
              : isFollowed()
                  ? 'Unfollow'
                  : isNotBlocked()
                      ? 'Block'
                      : isBlocked()
                          ? 'Unblock'
                          : 'Text...',
          style: TextStyle(
              color: textColor, fontSize: SizeConfig.blockSizeHorizontal * 3.6, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: widget.buttonProfile == FollowButtonProfile.follow
              ? Size(buttonSize.width * 1.2, buttonSize.height * 1.1)
              : buttonSize,
          primary: buttonColor,
          side: (isSecondary == true)
              ? BorderSide(
                  color: textColor, width: 2.5, style: BorderStyle.solid)
              : const BorderSide(style: BorderStyle.none),
        ),
        onPressed: () {
          setState(() {
            isSecondary = !isSecondary;

            if (isFollowButton()) {
              if (widget.isActive) {
                userService.unfollowUser(widget.userId);
              } else {
                userService.followUser(widget.userId);
              }

            } else if (isBlockButton()) {
              //TODO: Block / Unblock
            }

          });
        },
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    );
  }

  bool isFollowButton() {
    return widget.buttonProfile == FollowButtonProfile.follow ||
        widget.buttonProfile ==
            FollowButtonProfile.followSmall;
  }

  bool isBlockButton() {
    return widget.buttonProfile == FollowButtonProfile.block;
  }

  bool isFollowed() {
    return isFollowButton() && isSecondary;
  }

  bool isNotFollowed() {
    return isFollowButton() && !isSecondary;
  }

  bool isBlocked() {
    return isBlockButton() && isSecondary;
  }

  bool isNotBlocked() {
    return isBlockButton() && !isSecondary;
  }
}
