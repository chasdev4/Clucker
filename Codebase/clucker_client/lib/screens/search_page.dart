import 'package:clucker_client/components/tab_controls.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/palette.dart';
import '../navigation/main_navigation_bar.dart';
import '../navigation/new_cluck_button.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchNode = FocusNode();
  late List<Widget> searchResults = [];

  @override
  void dispose() {
    searchNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
              elevation: 0,
              toolbarHeight: 150,
              bottom: const TabControls(
                isSearchTabs: true,
              ),
              backgroundColor: Palette.white,
              title: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  TextBox(
                      textBoxProfile: TextBoxProfile.searchField,
                      focusNode: searchNode),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ))),
      body: searchResults.length == 0
          ? Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width / 2, child:
                  Icon(FontAwesomeIcons.search, color: Palette.cluckerRed.toMaterialColor().shade400, size: MediaQuery.of(context).size.width / 2.5),),
                  Padding(padding: EdgeInsets.only(top: 20), child: Text('Start typing to search...', style: TextStyle(
                      color: Palette.cluckerRed.toMaterialColor().shade600,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ))),
              ],
            ))
          : ListView(children: searchResults),
      bottomNavigationBar: const MainNavigationBar(),
      floatingActionButton: const NewCluckButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
