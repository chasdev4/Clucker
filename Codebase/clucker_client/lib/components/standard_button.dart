import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum StandardButtonProfile { standard, saveCancel }

class StandardButton extends StatelessWidget {
  const StandardButton(
      {Key? key,
      required this.text,
      required this.routeName,
      required this.onPress,
      this.isSecondary = false,
      this.standardButtonProfile = StandardButtonProfile.standard})
      : super(key: key);

  final String text;
  final String routeName;
  final Function onPress;
  final bool isSecondary;
  final StandardButtonProfile standardButtonProfile;

  @override
  Widget build(BuildContext context) {
    double horizontalPadding =
        (standardButtonProfile == StandardButtonProfile.standard) ? 50 : 15;
    const double buttonHeight = 45;

    Color textColor =
        (isSecondary == true) ? Palette.cluckerRed : Palette.white;
    Color buttonColor =
        (isSecondary == false) ? Palette.cluckerRed : Palette.white;
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: horizontalPadding,
          ),
          standardButtonProfile == StandardButtonProfile.standard
              ? Expanded(
                  child: SizedBox(
                  height: buttonHeight,
                  child: ElevatedButton(
                    child: Text(
                      text,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      side: (isSecondary == true)
                          ? BorderSide(
                              color: textColor,
                              width: 2.5,
                              style: BorderStyle.solid)
                          : const BorderSide(style: BorderStyle.none),
                    ),
                    onPressed: () {
                      onPress();
                    },
                  ),
                ))
              : Expanded(
                  child: SizedBox(
                      height: buttonHeight,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: buttonColor,
                              side: BorderSide(
                                  color: textColor,
                                  width: 2.5,
                                  style: BorderStyle.solid)),
                          onPressed: () {
                            onPress();
                          },
                          icon: Icon(
                            FontAwesomeIcons.solidTrashAlt,
                            color: Palette.cluckerRed,
                          ),
                          label: Text(
                            ' Cancel',
                            style: TextStyle(color: textColor, fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ))),
                ),
          SizedBox(
            width: horizontalPadding,
          ),
          standardButtonProfile != StandardButtonProfile.standard
              ? Expanded(
                  child: SizedBox(
                      height: buttonHeight,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: textColor,
                          ),
                          onPressed: () {
                            onPress();
                          },
                          icon: const Icon(FontAwesomeIcons.solidSave,),
                          label: const Text(' Save', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),))))
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
          standardButtonProfile != StandardButtonProfile.standard
              ? SizedBox(
                  width: horizontalPadding,
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
        ]));
  }
}
