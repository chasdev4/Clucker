import 'package:flutter/material.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainNavigationBar();
  }
}

class _MainNavigationBar extends State<MainNavigationBar> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.house), label: 'Feed'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.explore),
                ),
                label: 'Explore'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.search),
                ),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications')
          ],
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false);
  }
}
