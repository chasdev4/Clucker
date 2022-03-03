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
  passwordFieldSignUp,
  confirmPasswordFieldSignUp,
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
      required this.focusNode,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onChanged,
      this.extraFunction})
      : super(key: key);

  final TextBoxProfile textBoxProfile;
  final TextEditingController? controller;
  final FocusNode focusNode;
  final Function? onEditingComplete;
  final Function? onFieldSubmitted;
  final Function? onChanged;
  final Function? extraFunction;

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  //#region States
  late String enteredText;
  late int wordCount;
  late IconData validationIcon;
  late bool usernameAvailable;
  late bool iconAnimation;
  late bool validatorError;
  late bool timerActive;
  late double horizontalPadding;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    enteredText = '';
    wordCount = 0;
    validationIcon = FontAwesomeIcons.solidQuestionCircle;
    usernameAvailable = false;
    iconAnimation = false;
    validatorError = false;
    timerActive = false;
  }

  //#endregion

  @override
  Widget build(BuildContext context) {
    //#region Initializing size variables
    double sendButtonSize = (isCluckOrCommentField()) ? 32 : 0;
    double validationIconSize = (isAnyValidationField()) ? 24 : 0;
    horizontalPadding = (!isCluckOrCommentField() &&
            widget.textBoxProfile != TextBoxProfile.searchField)
        ? 50
        : 10;
    //#endregion

    return Padding(
      padding: isAnyValidationField()
          ? EdgeInsets.fromLTRB(horizontalPadding, 6, horizontalPadding + 10, 6)
          : EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 6),
      child: Row(
          crossAxisAlignment: isCluckOrCommentField()
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Stack(alignment: Alignment.center, children: [
                TextFormField(
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    inputFormatters: getInputFormatters(),
                    cursorColor: const Color.fromARGB(255, 100, 100, 100),
                    cursorWidth: 1.1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(3, 3))),
                      contentPadding: EdgeInsets.fromLTRB(
                          10,
                          6,
                          isCluckOrCommentField() ||
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
                    keyboardType: isCluckOrCommentField()
                        ? TextInputType.multiline
                        : TextInputType.text,
                    maxLines: isCluckOrCommentField() ? 9 : 1,
                    minLines: 1,
                    obscureText: isAnyPasswordField() ? true : false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: isUsernameFieldSignUp()
                        ? (value) {
                            if (iconAnimation) {
                              return null;
                            } else if (value == null || value.isEmpty) {
                              validatorError = false;
                              return null;
                            } else {
                              if (!usernameAvailable &&
                                  enteredText.length > 3) {
                                validatorError = true;
                                if (enteredText.length > 10) {
                                  return '\'$enteredText\' is unavailable';
                                } else {
                                  return 'The username \'$enteredText\' is unavailable';
                                }
                              } else {
                                String pattern = r'^[a-zA-Z0-9-_].{2,}$';
                                RegExp regExp = RegExp(pattern);

                                if (!regExp.hasMatch(enteredText)) {
                                  Future.delayed(Duration.zero, () {
                                    setState(() {
                                      validatorError = true;
                                      validationIcon =
                                          FontAwesomeIcons.solidTimesCircle;
                                    });
                                  });
                                  if (enteredText.length < 3) {
                                    return 'Username must be at least 3 characters';
                                  }
                                  return 'Invalid username';
                                } else {
                                  Future.delayed(Duration.zero, () {
                                    setState(() {
                                      validatorError = false;
                                      validationIcon =
                                          FontAwesomeIcons.solidCheckCircle;
                                    });
                                  });
                                }
                              }
                            }
                            return null;
                          }
                        : isEmailFieldSignUp()
                            ? (value) {
                                if (iconAnimation) {
                                  return null;
                                } else if (value == null || value.isEmpty) {
                                  Future.delayed(Duration.zero, () {
                                    setState(() {
                                      validatorError = false;
                                      validationIcon =
                                          FontAwesomeIcons.solidQuestionCircle;
                                    });
                                  });
                                  return null;
                                } else {
                                  String pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regExp = RegExp(pattern);

                                  if (!regExp.hasMatch(enteredText)) {
                                    return 'Invalid email address';
                                  }
                                }
                                return null;
                              }
                            : isPasswordFieldSignUp()
                                ? (value) {
                                    if (iconAnimation) {
                                      return null;
                                    } else if (value == null || value.isEmpty) {
                                      Future.delayed(Duration.zero, () {
                                        setState(() {
                                          validatorError = false;
                                          validationIcon = FontAwesomeIcons
                                              .solidQuestionCircle;
                                        });
                                      });
                                      return null;
                                    } else {
                                      bool atLeastEightChar = value.length >= 8;

                                      String pattern =
                                          r'^(?=.*[0-9])(?=.*[A-Za-z])(?=.*)(?=.*[@#$%^&+=_!]).{8,}$';
                                      RegExp regExp = RegExp(pattern);

                                      if (!regExp.hasMatch(enteredText)) {
                                        if (atLeastEightChar) {
                                          regExp = RegExp('[A-Za-z]');
                                          if (!regExp.hasMatch(enteredText)) {
                                            return 'Enter at least one letter (a-z)';
                                          }
                                          regExp = RegExp(r'^(?=.*[0-9])');
                                          if (!regExp.hasMatch(enteredText)) {
                                            return 'Enter at least one number (0-9)';
                                          }
                                          regExp =
                                              RegExp(r'^(?=.*[@#$%^&+=_!])');
                                          if (!regExp.hasMatch(enteredText)) {
                                            return 'At least one special character @#\$%^&+=_!';
                                          }
                                        } else {
                                          return 'Enter at least 8 characters';
                                        }
                                        return 'Invalid password';
                                      } else {
                                        Future.delayed(Duration.zero, () {
                                          setState(() {
                                            validatorError = false;
                                            validationIcon = FontAwesomeIcons
                                                .solidCheckCircle;
                                          });
                                          return null;
                                        });
                                      }
                                    }

                                    return null;
                                  }
                                : isConfirmPasswordFieldSignUp()
                                    ? (value) {
                                        if (iconAnimation) {
                                          return null;
                                        } else if (value == null ||
                                            value.isEmpty) {
                                          if (widget.extraFunction!()) {
                                            Future.delayed(Duration.zero, () {
                                              setState(() {
                                                validatorError = false;
                                                validationIcon =
                                                    FontAwesomeIcons
                                                        .solidQuestionCircle;
                                              });
                                            });
                                            return null;
                                          }
                                          return null;
                                        } else {
                                          if (!widget.onChanged!() && !widget.extraFunction!()) {
                                            Future.delayed(Duration.zero, () {
                                              setState(() {
                                                validatorError = true;
                                                validationIcon =
                                                    FontAwesomeIcons
                                                        .solidTimesCircle;
                                              });
                                            });
                                            return 'Passwords do not match';
                                          } else {
                                            Future.delayed(Duration.zero, () {
                                              setState(() {
                                                validatorError = false;
                                                validationIcon =
                                                    FontAwesomeIcons
                                                        .solidCheckCircle;
                                              });
                                            });
                                          }
                                        }
                                        return null;
                                      }
                                    : (value) {
                                        return null;
                                      },
                    textInputAction: isEmailOrUsernameFieldLogin() ||
                            isEmailFieldSignUp() ||
                            isPasswordFieldSignUp()
                        ? TextInputAction.next
                        : TextInputAction.done,
                    onFieldSubmitted: (value) {
                      if (isPasswordFieldLogin() ||
                          isUsernameFieldSignUp() ||
                          isConfirmPasswordFieldSignUp()) {
                        widget.onFieldSubmitted!();
                      }
                    },
                    onEditingComplete: () {
                      if (isEmailOrUsernameFieldLogin() ||
                          isEmailFieldSignUp() ||
                          isPasswordFieldSignUp()) {
                        widget.onChanged!();
                      }
                      if (isAnyValidationField()) {
                        updateValidationState();
                      }
                    },
                    onChanged: (value) {
                      enteredText = '';
                      if (wordCount <= 6) {
                        enteredText = value;
                      }

                      if (isAnyValidationField()) {
                        setState(() {
                          if (iconAnimation) {
                            _timer.cancel();
                          }
                          startTimer();
                        });
                      } else if (isConfirmPasswordFieldSignUp() &&
                          enteredText.isNotEmpty) {
                        iconAnimation = false;
                      }

                      if (value.isNotEmpty) {
                        validatorError = false;

                        setState(() {
                          enteredText = value;

                          if (isAnyValidationField() &&
                              (enteredText.isEmpty || timerActive == false)) {
                            iconAnimation = false;
                            validationIcon =
                                FontAwesomeIcons.solidQuestionCircle;
                          } else if (timerActive == true) {
                            iconAnimation = true;
                          }

                          if (isCluckOrCommentField()) {
                            wordCount = enteredText.isEmpty ? 0 : 1;
                            String temp = '';
                            if (wordCount == 5) {
                              for (int i = 0; i < enteredText.length - 2; i++) {
                                if ((enteredText[i] != ' ' ||
                                    enteredText[i] != '\n')) {
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
                    child: isCluckOrCommentField()
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
              width: isCluckOrCommentField()
                  ? sendButtonSize + 10
                  : isAnyValidationField()
                      ? validationIconSize
                      : 0,
              height: isCluckOrCommentField()
                  ? sendButtonSize + 10
                  : isAnyValidationField()
                      ? validationIconSize
                      : 0,
              child: isCluckOrCommentField()
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
                  : (isAnyValidationField() && iconAnimation == false)
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
                      : ((isAnyValidationField()) && iconAnimation == true)
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Transform.scale(
                                  scale: 1.654,
                                  origin: Offset(-7.6,
                                      validatorError ? -10 - 1.3737 : -1.3737),
                                  child: LoadingFlipping.circle(
                                    backgroundColor: Palette.lightGrey,
                                    borderColor: Palette.lightGrey,
                                    size: validationIconSize,
                                  )))
                          : null,
            ),
          ]),
    );
  }

  void startTimer() {
    if (isAnyValidationField()) {
      setState(() {
        timerActive = true;
        _timer = Timer(Duration(seconds: isUsernameFieldSignUp() ? 6 : 1), () {
          updateValidationState();
        });
      });
    }
  }

  void updateValidationState() async {
    bool validEmail = false;
    bool validPassword = false;
    bool passwordsMatch = false;
    if (isAnyValidationField()) {
      if (isUsernameFieldSignUp() && enteredText.length > 2) {
        usernameAvailable = await widget.onEditingComplete!();
      } else if (isEmailFieldSignUp() && enteredText.isNotEmpty) {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = RegExp(pattern);

        validEmail = regExp.hasMatch(enteredText);
      } else if (isPasswordFieldSignUp() && enteredText.isNotEmpty) {
        String pattern =
            r'^(?=.*[0-9])(?=.*[a-z])(?=.*)(?=.*[@#$%^&+=_!]).{8,}$';

        RegExp regExp = RegExp(pattern);
        validPassword = regExp.hasMatch(enteredText);
      } else if (isConfirmPasswordFieldSignUp() &&
          widget.controller!.text.isNotEmpty) {
        print('call to parent');
        passwordsMatch = widget.onChanged!();
      }

      iconAnimation = false;
      setState(() {
        if (enteredText.isEmpty) {
          validatorError = false;
          validationIcon = FontAwesomeIcons.solidQuestionCircle;
        } else if ((isUsernameFieldSignUp() && !usernameAvailable) ||
            (isEmailFieldSignUp() && !validEmail) ||
            (isPasswordFieldSignUp() && !validPassword) ||
            (isConfirmPasswordFieldSignUp() && !passwordsMatch)) {
          validatorError = true;
          validationIcon = FontAwesomeIcons.solidTimesCircle;
        } else if ((isUsernameFieldSignUp() && usernameAvailable) ||
            (isEmailFieldSignUp() && validEmail) ||
            (isPasswordFieldSignUp() && validPassword) ||
            (isConfirmPasswordFieldSignUp() && passwordsMatch)) {
          validatorError = false;
          validationIcon = FontAwesomeIcons.solidCheckCircle;
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

  List<TextInputFormatter> getInputFormatters() {
    List<TextInputFormatter> inputFormatters = [];
    bool lengthLimitAlreadyEnforced = false;

    // All Login / Sign Up Fields
    if (isAnyLoginOrSignUpField()) {
      inputFormatters.add(FilteringTextInputFormatter.deny(RegExp(' ')));
    }

    // Username Selection Field
    if (isUsernameFieldSignUp()) {
      inputFormatters
          .add(FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9-_]")));
      inputFormatters.add(LengthLimitingTextInputFormatter(20));
      lengthLimitAlreadyEnforced = true;
    }

    // Email Sign Up Field
    if (isEmailFieldSignUp()) {
      // inputFormatters.add(FilteringTextInputFormatter.allow(
      // RegExp("[a-zA-Z0-9@.]")));
    }

    // Cluck or Comment Field
    if (isCluckOrCommentField() && wordCount == 6) {
      inputFormatters.add(LengthLimitingTextInputFormatter(
          checkMaxWordCount() ? enteredText.length : 120));
      lengthLimitAlreadyEnforced = true;
    }

    if (!lengthLimitAlreadyEnforced) {
      inputFormatters.add(LengthLimitingTextInputFormatter(128));
    }

    return inputFormatters;
  }

  String getHintText() {
    return widget.textBoxProfile == TextBoxProfile.emailOrUsernameFieldLogin
        ? 'Email or Username'
        : widget.textBoxProfile == TextBoxProfile.usernameFieldSignUp
            ? 'Pick a Username'
            : widget.textBoxProfile == TextBoxProfile.passwordFieldLogin
                ? 'Enter Password'
                : widget.textBoxProfile == TextBoxProfile.passwordFieldSignUp
                    ? 'Enter your Password'
                    : widget.textBoxProfile ==
                            TextBoxProfile.confirmPasswordFieldSignUp
                        ? 'Confirm password'
                        : widget.textBoxProfile ==
                                TextBoxProfile.emailFieldSignUp
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

  //#region Comparisons

  bool isEmailOrUsernameFieldLogin() {
    return widget.textBoxProfile == TextBoxProfile.emailOrUsernameFieldLogin;
  }

  bool isPasswordFieldLogin() {
    return widget.textBoxProfile == TextBoxProfile.passwordFieldLogin;
  }

  bool isUsernameFieldSignUp() {
    return widget.textBoxProfile == TextBoxProfile.usernameFieldSignUp;
  }

  bool isEmailFieldSignUp() {
    return widget.textBoxProfile == TextBoxProfile.emailFieldSignUp;
  }

  bool isPasswordFieldSignUp() {
    return widget.textBoxProfile == TextBoxProfile.passwordFieldSignUp;
  }

  bool isConfirmPasswordFieldSignUp() {
    return widget.textBoxProfile == TextBoxProfile.confirmPasswordFieldSignUp;
  }

  bool isAnyLoginOrSignUpField() {
    return isAnyValidationField() ||
        widget.textBoxProfile == TextBoxProfile.passwordFieldLogin ||
        widget.textBoxProfile == TextBoxProfile.emailOrUsernameFieldLogin;
  }

  bool isAnyPasswordField() {
    return widget.textBoxProfile == TextBoxProfile.passwordFieldLogin ||
        widget.textBoxProfile == TextBoxProfile.passwordFieldSignUp ||
        widget.textBoxProfile == TextBoxProfile.confirmPasswordFieldSignUp;
  }

  bool isAnyValidationField() {
    return widget.textBoxProfile == TextBoxProfile.usernameFieldSignUp ||
        widget.textBoxProfile == TextBoxProfile.emailFieldSignUp ||
        widget.textBoxProfile == TextBoxProfile.passwordFieldSignUp ||
        widget.textBoxProfile == TextBoxProfile.confirmPasswordFieldSignUp;
  }

  bool isCluckOrCommentField() {
    return widget.textBoxProfile == TextBoxProfile.cluckField ||
        widget.textBoxProfile == TextBoxProfile.commentField;
  }
//#endregion
}
