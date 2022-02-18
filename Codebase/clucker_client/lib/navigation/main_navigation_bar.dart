import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainNavigationBar();
  }
}

class _MainNavigationBar extends State<MainNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.home), tooltip: 'Feed',),
                    IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.compass), tooltip: 'Discover',)
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.search), tooltip: 'Search',),
                    IconButton(
                      onPressed: () {}, icon: const Icon(FontAwesomeIcons.bell), tooltip: 'Notifications',)
              ],
            ),
                )),
          ],
        ),
      ),
    );
  }
}
