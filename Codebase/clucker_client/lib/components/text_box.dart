import 'package:loading_animations/loading_animations.dart';
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
  const TextBox(
      {Key? key,
      required this.textBoxProfile,
      this.controller,
      required this.onEditingComplete})
      : super(key: key);

  final TextBoxProfile textBoxProfile;
  final TextEditingController? controller;
  final Function onEditingComplete;

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  String enteredText = '';
  int counter = 0;
  int numLines = 1;
  IconData validationIcon = FontAwesomeIcons.solidQuestionCircle;
  bool usernameAvailable = false;
  bool loading = false;

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
            ? 24
            : 0;
    double horizontalPadding =
        (widget.textBoxProfile != TextBoxProfile.cluckField &&
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
                    controller: widget.controller,
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
                    onEditingComplete: () async {
                      usernameAvailable = await widget.onEditingComplete();
                      loading = false;

                      setState(() {
                        if (widget.textBoxProfile ==
                                TextBoxProfile.usernameFieldSignUp ||
                            widget.textBoxProfile ==
                                TextBoxProfile.emailField) {
                          if (enteredText.isEmpty) {
                            validationIcon =
                                FontAwesomeIcons.solidQuestionCircle;
                          } else if (!usernameAvailable) {
                            validationIcon = FontAwesomeIcons.solidTimesCircle;
                          } else if (usernameAvailable) {
                            validationIcon = FontAwesomeIcons.solidCheckCircle;
                          }
                        }
                      });
                    },
                    onChanged: (value) async {
                      enteredText = value;

                      setState(() {
                        enteredText = value;

                        if (enteredText.isEmpty) {
                          loading = false;
                          validationIcon = FontAwesomeIcons.solidQuestionCircle;
                        }else {
                          loading = true;
                        }

                        if (widget.textBoxProfile ==
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
                    : ((widget.textBoxProfile ==
                                    TextBoxProfile.usernameFieldSignUp ||
                                widget.textBoxProfile ==
                                    TextBoxProfile.emailField) &&
                            loading == false)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          )
                        : ((widget.textBoxProfile ==
                                        TextBoxProfile.usernameFieldSignUp ||
                                    widget.textBoxProfile ==
                                        TextBoxProfile.emailField) &&
                                loading == true)
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10),
                                        child: Transform.scale(scale: 1.654, origin: Offset(-7.6, -1.3737),child: LoadingFlipping.circle(                                          backgroundColor: Palette.lightGrey,
                                          borderColor: Palette.lightGrey,
                                          size: validationIconSize,
                                        )))
                            : null,
              ),
            ]));
  }
}
