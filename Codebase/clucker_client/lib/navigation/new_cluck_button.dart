import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewCluckButton extends StatefulWidget {
  const NewCluckButton({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

  @override
  _NewCluckButtonState createState() => _NewCluckButtonState();
}

class _NewCluckButtonState extends State<NewCluckButton> {
  int numNewLines = 0;
  bool cluckBarVisible = false;
  final cluckController = TextEditingController();
  bool getKeyboardState() {
    return ((MediaQuery.of(context).viewInsets.bottom >= 0 &&
        MediaQuery.of(context).viewInsets.bottom <
            MediaQuery.of(context).size.height / 36));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: getKeyboardState() && cluckBarVisible == false
          ? FloatingActionButton(
              backgroundColor: Palette.white,
              onPressed: () {
                _showOverlay(context);
                widget.focusNode.requestFocus();
              },
              child: Icon(
                FontAwesomeIcons.plusCircle,
                size: 80,
                color: Palette.cluckerRed,
              ),
              elevation: 0,
              tooltip: 'New Cluck')
          : null,
    );
  }

  void _showOverlay(BuildContext context) async {
    double barHeight = 260;

    OverlayState? overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Column(children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                barHeight -
                MediaQuery.of(context).viewInsets.bottom,
            child: RawMaterialButton(
              fillColor: Palette.black.toMaterialColor().shade300,
              splashColor: Colors.transparent,
              onPressed: () {
                setState(() {
                  barHeight = 125;
                  if (widget.focusNode.hasFocus) {
                    widget.focusNode.unfocus();
                  } else {
                    overlayEntry.remove();
                    cluckBarVisible = false;
                  }
                });
              },
            ),
          ),
        ),
        Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: barHeight - 1,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  offset: const Offset(0, -1.45),
                  color: Palette.mercuryGray.toMaterialColor().shade400)
            ]),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: barHeight,
                color: Palette.white,
                child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 50,
                          child: const Text(
                            'New Cluck',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w900),
                          ),
                        ),
                        TextBox(
                          textBoxProfile: TextBoxProfile.cluckField,
                          controller: cluckController,
                          focusNode: widget.focusNode,
                          onTap: (){setState(() {
                            barHeight = 260;
                          });}
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ]),
      ]);
    });
    cluckBarVisible = true;
    overlayState?.insert(overlayEntry);
  }
        }
