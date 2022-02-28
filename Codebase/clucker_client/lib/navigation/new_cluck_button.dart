import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewCluckButton extends StatefulWidget {
  const NewCluckButton({Key? key, required this.focusNode, required this.overlayVisible, required this.setOverlayState}) : super(key: key);
  final FocusNode focusNode;
  final bool overlayVisible;
  final Function setOverlayState;

  @override
  _NewCluckButtonState createState() => _NewCluckButtonState();
}

class _NewCluckButtonState extends State<NewCluckButton> {
  late int numNewLines;
  late bool overlayVisible;

  @override
  void initState() {
    super.initState();
    numNewLines = 0;
    overlayVisible = widget.overlayVisible;
    widget.setOverlayState(overlayVisible);
  }


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
      child: getKeyboardState() && overlayVisible == false
          ? FloatingActionButton(
              backgroundColor: Palette.white,
              onPressed: () {
                _showOverlay(context);
                widget.focusNode.requestFocus();
                widget.setOverlayState(overlayVisible);
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
    double barHeight = 218;

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
                  barHeight = countNewLines() <= 1 ? 125 : countNewLines() >= 9 ? 260 : (((numNewLines + 1) * 19.285) + 90);
                  if (MediaQuery.of(context).viewInsets.bottom == 0) {
                    overlayEntry.remove();
                    overlayVisible = false;
                    widget.setOverlayState(overlayVisible);
                    cluckController.text = '';
                  }
                  else {
                    widget.focusNode.unfocus();
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
                            padding: EdgeInsets.all(widget.focusNode.hasFocus ? 3 : 13),
                            width: MediaQuery.of(context).size.width - 50,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(padding: EdgeInsets.only(left: widget.focusNode.hasFocus ? 10 : 0), child: const Text(
                                  'New Cluck',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900),
                                ),),
                                const SizedBox(),
                                widget.focusNode.hasFocus ?
                                IconButton(
                                    onPressed: () {
                                      overlayEntry.remove();
                                      overlayVisible = false;
                                      widget.setOverlayState(overlayVisible);
                                    },
                                    icon: Icon(FontAwesomeIcons.times, size: 26, color: Palette.offBlack,)) : const SizedBox(),
                              ],
                            )),
                        TextBox(
                            textBoxProfile: TextBoxProfile.cluckField,
                            controller: cluckController,
                            focusNode: widget.focusNode,
                            onTap: () {
                              setState(() {
                                barHeight = 218;
                              });
                            }),
                      ],
                    )),
              ),
            ],
          ),
        ]),
      ]);
    });

    overlayVisible = true;
    widget.setOverlayState(overlayVisible);
    overlayState?.insert(overlayEntry);
  }

  int countNewLines() {
    numNewLines = 0;
    if (cluckController.text.isNotEmpty) {
      for (int i = 0; i < cluckController.text.length; i++) {
        if (cluckController.text[i] == '\n') {
          numNewLines++;
        }
      }
    }
    return numNewLines;
  }
}
