import 'package:clucker_client/components/cluck.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/cluck_tests.dart';



bool cluckTabActive = true;
bool bestTabActive = true;

List<Widget> discoverList = CluckTests().sortClucks(
    CluckTests().getCluckList(howManyClucks: 10), bestTabActive);

class DiscoverTabControls extends StatefulWidget with PreferredSizeWidget {
  const DiscoverTabControls({
    Key? key,
    required this.cluckActive,
    required this.bestActive,
    this.height = 46,
    this.padding = 15,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  final bool cluckActive;
  final bool bestActive;
  final double height;
  final double padding;

  @override
  _DiscoverTabControlsState createState() => _DiscoverTabControlsState();

  List<Widget> getDiscoveryList() {
    return discoverList;
  }

}

class _DiscoverTabControlsState extends State<DiscoverTabControls> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _cluckUserButton('Clucks', true),
                Container(
                  width: 3,
                  height: widget.height,
                  color: Palette.lightGrey,
                ),
                _cluckUserButton('Users', false),
              ],
            ),
            PreferredSize(
              preferredSize: const Size.fromHeight(2.5),
              child: Container(
                color: Palette.cluckerRed,
                height: 2.5,
                width: MediaQuery.of(context).size.width - widget.padding * 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _bestWorstButton('Best', true),
                Container(
                  width: 3,
                  height: widget.height,
                  color: Palette.lightGrey,
                ),
                _bestWorstButton('Worst', false),
              ],
            ),
            PreferredSize(
              preferredSize: const Size.fromHeight(2.5),
              child: Container(
                color: Palette.cluckerRed,
                height: 2.5,
                width: MediaQuery.of(context).size.width - widget.padding * 2,
              ),
            ),
          ],
        ));
  }

  SizedBox _cluckUserButton(String text, bool isLeftTab) {
    return SizedBox(
      width: ((MediaQuery.of(context).size.width / 2) - widget.padding),
      height: widget.height,
      child: RawMaterialButton(
        onPressed: () {
          setState(() {
            if (widget.cluckActive == true &&
                isLeftTab == true &&
                cluckTabActive == false) {
              cluckTabActive = true;
              discoverList = CluckTests().sortClucks(
                  CluckTests().getCluckList(), widget.bestActive);
            } else if (widget.cluckActive == true &&
                isLeftTab == false &&
                cluckTabActive == true) {
              cluckTabActive = false;
            }
          });
        },
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: ((widget.cluckActive == true &&
                  cluckTabActive == true &&
                  isLeftTab == true) ||
                  (widget.cluckActive == true &&
                      cluckTabActive == false &&
                      isLeftTab == false))
                  ? Palette.cluckerRed
                  : Palette.black,
              fontSize: 20),
        ),
      ),
    );
  }

  SizedBox _bestWorstButton(String text, bool isLeftTab) {
    return SizedBox(
      width: ((MediaQuery.of(context).size.width / 2) - widget.padding),
      height: widget.height,
      child: RawMaterialButton(
        onPressed: () {
          setState(() {
            if (widget.bestActive == true &&
                isLeftTab == true &&
                bestTabActive == false) {
              bestTabActive = true;
              if (cluckTabActive) {
                discoverList = CluckTests().sortClucks(
                    CluckTests().getCluckList(), bestTabActive);
              }
            } else if (widget.bestActive == true &&
                isLeftTab == false &&
                bestTabActive == true) {
              bestTabActive = false;
              if (cluckTabActive) {
                discoverList = CluckTests().sortClucks(
                    CluckTests().getCluckList(), bestTabActive);
              }
            }
          });
        },
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: ((widget.bestActive == true &&
                  bestTabActive == true &&
                  isLeftTab == true) ||
                  (widget.bestActive == true &&
                      bestTabActive == false &&
                      isLeftTab == false))
                  ? Palette.cluckerRed
                  : Palette.black,
              fontSize: 20),
        ),
      ),
    );
  }
}