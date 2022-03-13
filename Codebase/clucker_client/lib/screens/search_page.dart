import 'package:clucker_client/components/tab_controls.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:flutter/material.dart';
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
  final cluckNode = FocusNode();
  late List<Widget> searchResults = [];

  @override
  void dispose() {
    searchNode.dispose();
    cluckNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
            automaticallyImplyLeading: false,
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
      body: searchResults.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Icon(FontAwesomeIcons.search,
                      color: Palette.cluckerRed.toMaterialColor().shade400,
                      size: MediaQuery.of(context).size.width / 2.5),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text('Start typing to search...',
                        style: TextStyle(
                          color: Palette.cluckerRed.toMaterialColor().shade600,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ))),
              ],
            ))
          : ListView(children: searchResults),
      bottomNavigationBar: MainNavigationBar(
        focusNode: cluckNode,
      ),
      floatingActionButton: NewCluckButton(focusNode: cluckNode),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
