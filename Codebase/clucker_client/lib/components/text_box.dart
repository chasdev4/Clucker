import 'package:flutter/material.dart';
import 'package:clucker_client/components/palette.dart';

class TextBox extends StatefulWidget {
  TextBox({Key? key}) : super(key: key);

  late String hintText;
  late bool isSearchField;
  late bool isCluckField;
  late bool obscureText;
  late double horizontalPadding;

  void setValues(String hintText, bool isSearchField, bool isCluckField,
      bool obscureText, double horizontalPadding) {
    this.hintText = hintText;
    this.isSearchField = isSearchField;
    this.isCluckField = isCluckField;
    this.obscureText = obscureText;
    this.horizontalPadding = horizontalPadding;
  }

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  String enteredText = '';
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    double sendButtonSize = 35;
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding, vertical: 6),
        child: Row(children: [
          Flexible(child:
          Stack(alignment: Alignment.centerRight, children: [
            TextField(
              obscureText: widget.obscureText,
              cursorColor: const Color.fromARGB(255, 100, 100, 100),
              cursorWidth: 1.1,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: lightGrey, width: 1.3),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: lightGrey,
                    width: 1,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(3, 3))),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: lightGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  enteredText = value;
                  counter = 0;
                  for (int i = 0; i < enteredText.length; i++) {
                    if (enteredText[i] == ' ') {
                      counter++;
                    }
                  }
                });
              },
            ),
            Container(
              child: widget.isSearchField == true
                  ? IconButton(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/search_icon_256x256.png'),
                        color: black,
                        size: 22,
                      ),
                      onPressed: () {
                        // do something
                      },
                    )
                  : widget.isCluckField == true
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
                              fontSize: 15,
                            ),
                          )
                        ])
                      : const SizedBox(),
            ),
          ]), ),
          SizedBox(
            width: sendButtonSize,
            height: sendButtonSize,
            child: widget.isCluckField == true
                ? IconButton(
                    icon: ImageIcon(
                      const AssetImage('assets/icons/send_icon_256x256.png'),
                      color: black,
                      size: sendButtonSize,
                    ),
                    padding: const EdgeInsets.only(left: 10),
                    onPressed: () {
                      // do something
                    },
                  )
                : null,
          ),
        ]));
  }
}
