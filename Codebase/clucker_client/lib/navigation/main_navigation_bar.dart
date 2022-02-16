import 'package:flutter/material.dart';

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
                    IconButton(onPressed: () {}, icon: const Icon(Icons.house), tooltip: 'Feed',),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.explore), tooltip: 'Discover',)
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
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search), tooltip: 'Search',),
                    IconButton(
                      onPressed: () {}, icon: const Icon(Icons.notifications), tooltip: 'Notifications',)
              ],
            ),
                )),
          ],
        ),
      ),
    );
  }
}
