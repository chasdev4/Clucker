import 'dart:async';

import 'package:flutter/material.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TextBoxProfile {
  emailOrUsernameFieldLogin,
  usernameFieldSignUp,
  passwordFieldLogin,
  passwordFieldSignUp,
  emailField,
  cluckField,
  commentField,
  searchField,
}

class TextBox extends StatefulWidget {
  const TextBox({Key? key, required this.textBoxProfile, this.controller})
      : super(key: key);

  final TextBoxProfile textBoxProfile;
  final TextEditingController? controller;

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  double horizontalPadding = 0;
  String enteredText = '';
  int counter = 0;
  int numLines = 1;
  IconData validationIcon = Icons.question_mark;

  @override
  Widget build(BuildContext context) {
    double sendButtonSize =
        (widget.textBoxProfile == TextBoxProfile.cluckField ||
                widget.textBoxProfile == TextBoxProfile.commentField)
            ? 32
            : 0;
    double validationIconSize =
        (widget.textBoxProfile == TextBoxProfile.usernameFieldSignUp ||
                widget.textBoxProfile == TextBoxProfile.emailField)
            ? 30
            : 0;
    horizontalPadding = (widget.textBoxProfile != TextBoxProfile.cluckField &&
            widget.textBoxProfile != TextBoxProfile.searchField &&
            widget.textBoxProfile != TextBoxProfile.commentField)
        ? 50
        : 10;

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
                    controller: widget.textBoxProfile ==
                            TextBoxProfile.emailOrUsernameFieldLogin
                        ? widget.controller
                        : null,
                    obscureText: widget.textBoxProfile ==
                                TextBoxProfile.passwordFieldLogin ||
                            widget.textBoxProfile ==
                                TextBoxProfile.passwordFieldSignUp
                        ? true
                        : false,
                    cursorColor: const Color.fromARGB(255, 100, 100, 100),
                    cursorWidth: 1.1,
                    keyboardType: widget.textBoxProfile ==
                                TextBoxProfile.cluckField ||
                            widget.textBoxProfile == TextBoxProfile.commentField
                        ? TextInputType.multiline
                        : TextInputType.text,
                    minLines: 1,
                    maxLines: widget.textBoxProfile ==
                                TextBoxProfile.cluckField ||
                            widget.textBoxProfile == TextBoxProfile.commentField
                        ? 9
                        : 1,
                    decoration: InputDecoration(
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
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Palette.lightGrey, width: 1.3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.lightGrey,
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(10, 6, 41, 6),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(3, 3))),
                      hintText: widget.textBoxProfile ==
                              TextBoxProfile.emailOrUsernameFieldLogin
                          ? 'Enter Username'
                          : widget.textBoxProfile ==
                                  TextBoxProfile.usernameFieldSignUp
                              ? 'Pick a Username'
                              : widget.textBoxProfile ==
                                      TextBoxProfile.passwordFieldLogin
                                  ? 'Enter Password'
                                  : widget.textBoxProfile ==
                                          TextBoxProfile.passwordFieldSignUp
                                      ? 'Enter a Password'
                                      : widget.textBoxProfile ==
                                              TextBoxProfile.emailField
                                          ? 'Email'
                                          : widget.textBoxProfile ==
                                                  TextBoxProfile.cluckField
                                              ? 'What do you want to Cluck about?'
                                              : widget.textBoxProfile ==
                                                      TextBoxProfile
                                                          .commentField
                                                  ? 'Comment on this Cluck...'
                                                  : widget.textBoxProfile ==
                                                          TextBoxProfile
                                                              .searchField
                                                      ? 'Search'
                                                      : 'Cluck cluck, cluck cluck cluck',
                      hintStyle: TextStyle(
                        color: Palette.lightGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        enteredText = value;
                        if (widget.textBoxProfile ==
                            TextBoxProfile.usernameFieldSignUp) {
                          // //TODO: Connect the backend for username validation
                        } else if (widget.textBoxProfile ==
                            TextBoxProfile.emailField) {
                          //   //TODO: Connect the backend for email validation
                        }
                        //Timer(Duration(seconds: 6), callback);
                        // if (enteredText.length == 0) {
                        //validationIcon = Icons.question_mark;
                        // }
                        // else if (enteredText already exists) {
                        //  validationIcon = Icons.close;
                        // } else {
                        //  validationIcon = Icons.check_circle;
                        // }
                        else if (widget.textBoxProfile ==
                            TextBoxProfile.passwordFieldSignUp) {
                          //TODO: Set the state of the meter based on the password field algorithm
                        } else if (widget.textBoxProfile ==
                            TextBoxProfile.cluckField) {
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
                          widget.textBoxProfile == TextBoxProfile.cluckField ||
                                  widget.textBoxProfile ==
                                      TextBoxProfile.commentField
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
                width: widget.textBoxProfile == TextBoxProfile.cluckField ||
                        widget.textBoxProfile == TextBoxProfile.commentField
                    ? sendButtonSize + 10
                    : widget.textBoxProfile ==
                                TextBoxProfile.usernameFieldSignUp ||
                            widget.textBoxProfile == TextBoxProfile.emailField
                        ? validationIconSize
                        : 0,
                height: widget.textBoxProfile == TextBoxProfile.cluckField ||
                        widget.textBoxProfile == TextBoxProfile.commentField
                    ? sendButtonSize + 10
                    : widget.textBoxProfile ==
                                TextBoxProfile.usernameFieldSignUp ||
                            widget.textBoxProfile == TextBoxProfile.emailField
                        ? validationIconSize
                        : 0,
                child: widget.textBoxProfile == TextBoxProfile.cluckField ||
                        widget.textBoxProfile == TextBoxProfile.commentField
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
                    : widget.textBoxProfile ==
                                TextBoxProfile.usernameFieldSignUp ||
                            widget.textBoxProfile == TextBoxProfile.emailField
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.circle,
                              size: validationIconSize,
                              color: Colors.grey,
                            ),
                          )
                        : null,
              ),
            ]));
  }
}
