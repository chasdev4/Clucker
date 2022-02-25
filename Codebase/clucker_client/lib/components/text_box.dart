import 'dart:async';
import 'package:flutter/services.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TextBoxProfile {
  emailOrUsernameFieldLogin,
  usernameFieldSignUp,
  passwordFieldLogin,
  passwordFieldMeterSignUp,
  passwordFieldValidationSignUp,
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
  int wordCount = 0;
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
    _timer = Timer(const Duration(seconds: 6), () {
      updateAnimation();
    });
    double sendButtonSize = (isCluckCommentField()) ? 32 : 0;
    double validationIconSize = (isValidationField()) ? 24 : 0;
    double horizontalPadding = (!isCluckCommentField() &&
            widget.textBoxProfile != TextBoxProfile.searchField)
        ? 50
        : 10;
    //#endregion

    return Padding(
        padding: isValidationField()
            ? EdgeInsets.fromLTRB(
                horizontalPadding, 6, horizontalPadding + 10, 6)
            : EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 6),
        child: Row(
            crossAxisAlignment: isCluckCommentField()
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Stack(alignment: Alignment.center, children: [
                  TextFormField(
                      controller: widget.controller,
                      inputFormatters: [
                        isUsernameFieldSignUp()
                            ? FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9]"))
                            : isEmailFieldSignUp()
                                ? FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z0-9@.]"))
                                : isLoginSignUpField()
                                    ? FilteringTextInputFormatter.deny(
                                        RegExp(' '))
                                    : FilteringTextInputFormatter.deny(''),
                        wordCount == 6
                            ? LengthLimitingTextInputFormatter(
                                checkMaxWordCount()
                                    ? enteredText.length
                                    : 240)
                            : FilteringTextInputFormatter.deny(''),
                        LengthLimitingTextInputFormatter(widget
                                    .textBoxProfile ==
                                TextBoxProfile.usernameFieldSignUp
                            ? 20
                            : widget.textBoxProfile ==
                                        TextBoxProfile.emailFieldSignUp ||
                                    widget.textBoxProfile ==
                                        TextBoxProfile.emailOrUsernameFieldLogin
                                ? 50
                                : isCluckCommentField()
                                    ? 120
                                    : 240)
                      ],
                      cursorColor: const Color.fromARGB(255, 100, 100, 100),
                      cursorWidth: 1.1,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(3, 3))),
                        contentPadding: EdgeInsets.fromLTRB(
                            10,
                            6,
                            isCluckCommentField() ||
                                    widget.textBoxProfile ==
                                        TextBoxProfile.searchField
                                ? 41
                                : 10,
                            6),
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
                                    icon: Icon(
                                      FontAwesomeIcons.search,
                                      color: Palette.cluckerRed
                                          .toMaterialColor()
                                          .shade800,
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
                      keyboardType: isCluckCommentField()
                          ? TextInputType.multiline
                          : TextInputType.text,
                      maxLines: isCluckCommentField() ? 9 : 1,
                      minLines: 1,
                      obscureText: widget.textBoxProfile ==
                                  TextBoxProfile.passwordFieldLogin ||
                              widget.textBoxProfile ==
                                  TextBoxProfile.passwordFieldMeterSignUp ||
                      widget.textBoxProfile == TextBoxProfile.passwordFieldValidationSignUp
                          ? true
                          : false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: isValidationField()
                          ? (value) {
                              if (iconAnimation) {
                                return null;
                              } else if (value == null || value.isEmpty) {
                                validatorError = false;
                                return null;
                              } else {
                                if (!usernameAvailable) {
                                  validatorError = true;
                                  return 'Username unavailable';
                                }
                              }
                              return null;
                            }
                          : (value) {
                              return null;
                            },
                      onEditingComplete: () {
                        if (isValidationField()) {
                          updateAnimation();
                        }
                      },
                      onChanged: (value) {
                        enteredText = '';
                        if (isValidationField()) {
                          setState(() {
                            _startTimer();
                          });
                        }
                        if (wordCount <= 6) {
                          enteredText = value;
                        }
                        if (value.isNotEmpty) {
                          validatorError = false;

                          setState(() {
                            enteredText = value;

                            if (enteredText.isEmpty || timerActive == false) {
                              iconAnimation = false;
                              validationIcon =
                                  FontAwesomeIcons.solidQuestionCircle;
                            } else if (timerActive == true) {
                              iconAnimation = true;
                            }

                            if (widget.textBoxProfile ==
                                TextBoxProfile.passwordFieldMeterSignUp) {
                              //TODO: Set the state of the meter based on the password field algorithm
                            } else if (isCluckCommentField()) {
                              wordCount = enteredText.isEmpty ? 0 : 1;
                              String temp = '';
                              if (wordCount == 5) {
                                for (int i = 0; i < enteredText.length - 2; i++) {
                                  if ((enteredText[i] != ' ' || enteredText[i] != '\n')) {
                                    temp += enteredText[i];
                                  }
                                }
                                setState(() {
                                  enteredText = temp;
                                });

                              }
                              for (int i = 1; i < enteredText.length; i++) {
                                if (i > 1) {
                                  if ((enteredText[i - 1] == ' ' ||
                                          enteredText[i - 1] == '\n') &&
                                      (enteredText[i] != ' ' ||
                                          enteredText != '\n')) {
                                    wordCount++;
                                  }
                                }
                                }

                            }
                          });
                        }
                      }),
                  Positioned(
                    right: 0.001,
                    bottom: 5,
                    child: SizedBox(
                      width: 40,
                      child: isCluckCommentField()
                          ? Column(children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                '$wordCount/6  ',
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
                width: isCluckCommentField()
                    ? sendButtonSize + 10
                    : isValidationField()
                        ? validationIconSize
                        : 0,
                height: isCluckCommentField()
                    ? sendButtonSize + 10
                    : isValidationField()
                        ? validationIconSize
                        : 0,
                child: isCluckCommentField()
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
                        : ((isValidationField()) && iconAnimation == true)
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
    if (isValidationField()) {
      setState(() {
        timerActive = true;
        _timer = Timer(const Duration(seconds: 6), () {
          updateAnimation();
        });
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  //#endregion

//#region Comparisons
  bool isLoginSignUpField() {
    return isValidationField() ||
        widget.textBoxProfile == TextBoxProfile.passwordFieldLogin ||
        widget.textBoxProfile == TextBoxProfile.emailOrUsernameFieldLogin ||
        widget.textBoxProfile == TextBoxProfile.passwordFieldValidationSignUp;
  }

  bool isUsernameFieldSignUp() {
    return widget.textBoxProfile == TextBoxProfile.usernameFieldSignUp;
  }

  bool isEmailFieldSignUp() {
    return widget.textBoxProfile == TextBoxProfile.emailFieldSignUp;
  }

  bool isValidationField() {
    return widget.textBoxProfile == TextBoxProfile.usernameFieldSignUp ||
        widget.textBoxProfile == TextBoxProfile.emailFieldSignUp;
  }

  bool isCluckCommentField() {
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
                : widget.textBoxProfile == TextBoxProfile.passwordFieldMeterSignUp
                    ? 'Enter your Password'
    : widget.textBoxProfile == TextBoxProfile.passwordFieldValidationSignUp ?
        'Re-enter your password'
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
    if (isValidationField()) {
      usernameAvailable = await widget.onEditingComplete();
      iconAnimation = false;
      setState(() {
        if (isValidationField()) {
          if (enteredText.isEmpty) {
            validatorError = false;
            validationIcon = FontAwesomeIcons.solidQuestionCircle;
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

  bool checkMaxWordCount() {
    if (enteredText.isNotEmpty) {
      return enteredText[enteredText.length - 1] == ' ' ||
          enteredText[enteredText.length - 1] == '\n';
    } else {
      return false;
    }
  }
}
