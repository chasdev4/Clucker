import 'dart:async';

import 'package:flutter/material.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:flutter/services.dart';

enum Validation { usernameField, emailField }

class TextBox extends StatefulWidget {
  TextBox(
      {Key? key,
      required this.hintText,
      required this.isSearchField,
      required this.isCluckField,
      required this.isValidationField,
      required this.obscureText,
      required this.validationProfile})
      : super(key: key);

  final String hintText;
  final bool isSearchField;
  final bool isCluckField;
  final bool isValidationField;
  final bool obscureText;
  final Validation validationProfile;

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
    double sendButtonSize = (widget.isCluckField == true) ? 50 : 0;
    double validationIconSize = (widget.isValidationField == true) ? 30 : 0;
    horizontalPadding =
        (widget.isCluckField == false && widget.isSearchField == false)
            ? 50
            : 10;

    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 6),
        child: Row(
            crossAxisAlignment: widget.isCluckField == true
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Stack(alignment: Alignment.centerRight, children: [
                  TextField(
                    obscureText: widget.obscureText,
                    cursorColor: const Color.fromARGB(255, 100, 100, 100),
                    cursorWidth: 1.1,
                    keyboardType: widget.isCluckField == true
                        ? TextInputType.multiline
                        : TextInputType.text,
                    minLines: 1,
                    maxLines: widget.isCluckField == true ? 9 : 1,
                    decoration: InputDecoration(
                      suffixIcon: widget.isSearchField == true
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
                        borderSide: BorderSide(color: lightGrey, width: 1.3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: lightGrey,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(10, 6, 41, 6),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(3, 3))),
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(
                        color: lightGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        enteredText = value;
                        if (widget.isValidationField == true) {

                          //if (widget.validationProfile == Validation.usernameField) {
                          // //TODO: Connect the backend for username validation
                          //} else {
                          //   //TODO: Connect the backend for email validation
                          // }
                          //Timer(Duration(seconds: 6), callback);
                          // if (enteredText.length == 0) {
                          //validationIcon = Icons.question_mark;
                          // }
                          // else if (enteredText already exists) {
                          //  validationIcon = Icons.close;
                          // } else {
                          //  validationIcon = Icons.check_circle;
                          // }
                        } else if (widget.isCluckField == true) {
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
                      child: widget.isCluckField == true
                          ? Column(children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                '$counter/6  ',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  color: cluckerRed.shade400,
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
                width: widget.isCluckField == true
                    ? sendButtonSize
                    : widget.isValidationField == true
                        ? validationIconSize
                        : 0,
                height: widget.isCluckField == true
                    ? sendButtonSize
                    : widget.isValidationField == true
                        ? validationIconSize
                        : 0,
                child: widget.isCluckField == true
                    ? IconButton(
                        icon: ImageIcon(
                          const AssetImage(
                              'assets/icons/send_icon_256x256.png'),
                          color: black,
                          size: sendButtonSize,
                        ),
                        padding: const EdgeInsets.only(
                            left: 10, top: 5, bottom: 5, right: 0),
                        onPressed: () {
                          // do something
                        },
                      )
                    : widget.isValidationField == true
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
