import 'dart:async';
import 'dart:developer';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TextBoxProfile {
  emailOrUsernameFieldLogin,
  usernameFieldSignUp,
  passwordFieldLogin,
  passwordFieldSignUp,
  emailFieldSignUp,
  cluckField,
  commentField,
  searchField,
}

class TextBox extends StatefulWidget {
  const TextBox(
      {Key? key,
      required this.textBoxProfile,
      this.controller,
      required this.onEditingComplete,
      required this.onChanged})
      : super(key: key);

  final TextBoxProfile textBoxProfile;
  final TextEditingController? controller;
  final Function onEditingComplete;
  final Function onChanged;

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  //#region States
  String enteredText = '';
  int counter = 0;
  IconData validationIcon = FontAwesomeIcons.solidQuestionCircle;
  bool usernameAvailable = false;
  bool iconAnimation = false;
  bool validatorError = false;
  bool timerActive = false;
  late Timer _timer;
  //#endregion
  @override
  Widget build(BuildContext context) {
    //#region Initializing size variables
    double sendButtonSize = (isCluckField()) ? 32 : 0;
    double validationIconSize = (isValidationField()) ? 24 : 0;
    double horizontalPadding =
        (!isCluckField() && widget.textBoxProfile != TextBoxProfile.searchField)
            ? 50
            : 10;
    //#endregion

    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 6),
        child: Row(
            crossAxisAlignment:
                widget.textBoxProfile == TextBoxProfile.cluckField ||
                        widget.textBoxProfile == TextBoxProfile.commentField
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Stack(alignment: Alignment.center, children: [
                  TextFormField(
                    controller: widget.controller,
                    cursorColor: const Color.fromARGB(255, 100, 100, 100),
                    cursorWidth: 1.1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(3, 3))),
                      contentPadding: const EdgeInsets.fromLTRB(10, 6, 41, 6),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.lightGrey,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Palette.lightGrey, width: 1.3),
                      ),
                      suffixIcon:
                          widget.textBoxProfile == TextBoxProfile.searchField
                              ? IconButton(
                                  icon: const ImageIcon(
                                    AssetImage(
                                        'assets/icons/search_icon_256x256.png'),
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    // do something
                                  },
                                )
                              : null,
                      hintText: getHintText(),
                      hintStyle: TextStyle(
                        color: Palette.lightGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    keyboardType: widget.textBoxProfile ==
                                TextBoxProfile.cluckField ||
                            widget.textBoxProfile == TextBoxProfile.commentField
                        ? TextInputType.multiline
                        : TextInputType.text,
                    maxLines: isCluckField() ? 9 : 1,
                    minLines: 1,
                    obscureText: widget.textBoxProfile ==
                                TextBoxProfile.passwordFieldLogin ||
                            widget.textBoxProfile ==
                                TextBoxProfile.passwordFieldSignUp
                        ? true
                        : false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (iconAnimation) {
                        return null;
                      } else if (value == null || value.isEmpty) {
                        validatorError = false;
                        return null;
                      } else {
                        if (!usernameAvailable) {
                          validatorError = true;
                          return 'The username \'$value\' is already taken.';
                        }
                      }
                      return null;
                    },
                    onEditingComplete: () async {
                      updateAnimation();
                    },
                    onChanged: (value) async {
                      setState(() {
                        _startTimer();
                      });
                      enteredText = value;
                      validatorError = false;

                      setState(() {
                        enteredText = value;

                        if (enteredText.isEmpty || timerActive == false) {
                          log('##### ANIMATION OFF #####');
                          iconAnimation = false;
                          validationIcon = FontAwesomeIcons.solidQuestionCircle;
                        } else if (timerActive == true) {
                          log('##### ANIMATION ON #####');
                          iconAnimation = true;
                        }

                        if (widget.textBoxProfile ==
                            TextBoxProfile.passwordFieldSignUp) {
                          //TODO: Set the state of the meter based on the password field algorithm
                        } else if (isCluckField()) {
                          counter = 0;
                          for (int i = 0; i < enteredText.length; i++) {
                            if (enteredText[i] == ' ' ||
                                enteredText[i] == '\n') {
                              counter++;
                            }
                          }
                        }
                      });
                    },
                  ),
                  Positioned(
                    right: 0.001,
                    bottom: 5,
                    child: SizedBox(
                      width: 40,
                      child:
                          isCluckField()
                              ? Column(children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    '$counter/6  ',
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold,
                                      color: Palette.cluckerRed
                                          .toMaterialColor()
                                          .shade400,
                                      fontSize: 14,
                                    ),
                                  )
                                ])
                              : const SizedBox(),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                width: isCluckField()
                    ? sendButtonSize + 10
                    : widget.textBoxProfile ==
                                TextBoxProfile.usernameFieldSignUp ||
                            widget.textBoxProfile ==
                                TextBoxProfile.emailFieldSignUp
                        ? validationIconSize
                        : 0,
                height: isCluckField()
                    ? sendButtonSize + 10
                    : isValidationField()
                        ? validationIconSize
                        : 0,
                child: isCluckField()
                    ? IconButton(
                        icon: Icon(
                          FontAwesomeIcons.solidPaperPlane,
                          color: Palette.cluckerRed,
                          size: sendButtonSize,
                        ),
                        padding: const EdgeInsets.only(
                            left: 10, top: 5, bottom: 20, right: 10),
                        onPressed: () {
                          // do something
                        },
                      )
                    : (isValidationField() && iconAnimation == false)
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Transform.translate(
                              offset: Offset(0, validatorError ? -10 : 0),
                              child: Icon(
                                validationIcon,
                                size: validationIconSize,
                                color: validationIcon ==
                                        FontAwesomeIcons.solidQuestionCircle
                                    ? Palette.lightGrey
                                    : validationIcon ==
                                            FontAwesomeIcons.solidTimesCircle
                                        ? Colors.red.shade600
                                        : Colors.green.shade600,
                              ),
                            ),
                          )
                        : ((isValidationField()) &&
                                iconAnimation == true)
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Transform.scale(
                                    scale: 1.654,
                                    origin: Offset(
                                        -7.6,
                                        validatorError
                                            ? -10 - 1.3737
                                            : -1.3737),
                                    child: LoadingFlipping.circle(
                                      backgroundColor: Palette.lightGrey,
                                      borderColor: Palette.lightGrey,
                                      size: validationIconSize,
                                    )))
                            : null,
              ),
            ]));
  }

//#region Timer
  void _startTimer() {
    setState(() {
      timerActive = true;
      _timer = Timer(const Duration(seconds: 3), () {
        updateAnimation();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  //#endregion

//#region Comparisons
  bool isValidationField() {
    return widget.textBoxProfile == TextBoxProfile.usernameFieldSignUp ||
        widget.textBoxProfile == TextBoxProfile.emailFieldSignUp;
  }

  bool isCluckField() {
    return widget.textBoxProfile == TextBoxProfile.cluckField ||
        widget.textBoxProfile == TextBoxProfile.commentField;
  }
  //#endregion

  String getHintText() {
    return widget.textBoxProfile == TextBoxProfile.emailOrUsernameFieldLogin
        ? 'Enter Username'
        : widget.textBoxProfile == TextBoxProfile.usernameFieldSignUp
        ? 'Pick a Username'
        : widget.textBoxProfile == TextBoxProfile.passwordFieldLogin
        ? 'Enter Password'
        : widget.textBoxProfile == TextBoxProfile.passwordFieldSignUp
        ? 'Enter a Password'
        : widget.textBoxProfile == TextBoxProfile.emailFieldSignUp
        ? 'Email'
        : widget.textBoxProfile == TextBoxProfile.cluckField
        ? 'What do you want to Cluck about?'
        : widget.textBoxProfile ==
        TextBoxProfile.commentField
        ? 'Comment on this Cluck...'
        : widget.textBoxProfile ==
        TextBoxProfile.searchField
        ? 'Search'
        : 'Cluck cluck, cluck cluck cluck';
  }

  void updateAnimation() async {
    usernameAvailable = await widget.onEditingComplete();
    iconAnimation = false;
    setState(() {
      if (isValidationField()) {
        if (enteredText.isEmpty) {
          validatorError = false;
          validationIcon =
              FontAwesomeIcons.solidQuestionCircle;
        } else if (!usernameAvailable) {
          validatorError = true;
          validationIcon = FontAwesomeIcons.solidTimesCircle;
        } else if (usernameAvailable) {
          validatorError = false;
          validationIcon = FontAwesomeIcons.solidCheckCircle;
        }
      }
    });
  }
}
