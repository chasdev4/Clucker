import 'package:flutter/material.dart';
import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:clucker_client/components/user_avatar.dart';
import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:clucker_client/navigation/new_cluck_button.dart';
import 'package:clucker_client/components/discover_tab_controls.dart';
import 'package:clucker_client/components/cluck.dart';

DiscoverTabControls discoverTabControls = const DiscoverTabControls(
    cluckActive: true,
    bestActive: true);

class Discover extends StatelessWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CluckerAppBar(
        title: 'Discover',
        actions: [
          UserAvatar(
            avatarImage: 'assets/icons/chicken.jpg',
          ),
        ],
      ),
      body: Column(
        children: [
          discoverTabControls,
          Flexible(
            fit: FlexFit.tight,
            child: ListView(
              children: discoverTabControls.getDiscoveryList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MainNavigationBar(),
      floatingActionButton: const NewCluckButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
