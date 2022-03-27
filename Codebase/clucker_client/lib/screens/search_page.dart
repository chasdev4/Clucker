import 'package:clucker_client/components/page_card.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/tab_controls.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/screens/search_results_page.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage(
      {Key? key,
      required this.userId,
      required this.username,
      this.searchPageIndex = 0})
      : super(key: key);

  final int userId;
  final String username;
  final int searchPageIndex;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CluckResultsPage cluckResultPage = CluckResultsPage(
    term: '',
    returnIndex: () {},
  );
  UserResultsPage userResultPage = UserResultsPage(
    term: '',
    returnIndex: () {},
  );

  late List<Widget> searchPages;
  final searchNode = FocusNode();
  final cluckNode = FocusNode();
  final searchController = TextEditingController();
  late List<Widget> searchResults = [];
  late int searchPageIndex;
  late bool refresh = false;
  late bool startedSearch = false;

  @override
  void initState() {
    super.initState();
    searchPageIndex = widget.searchPageIndex;
  }

  @override
  Widget build(BuildContext context) {
    searchPages = [
      const _StartSearchPage(),
      cluckResultPage,
      userResultPage,
      const _NoResultsFoundPage()
    ];

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 150,
            backgroundColor: Palette.white,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 12,
                ),
                TextBox(
                  textBoxProfile: TextBoxProfile.searchField,
                  focusNode: searchNode,
                  controller: searchController,
                  extraFunction: () {
                    startedSearch = true;
                    if (searchController.text.isEmpty) {
                      setState(() {
                        searchPageIndex = 0;
                        startedSearch = false;
                      });
                    } else {
                      searchNode.unfocus();
                      if (searchPageIndex == 0) {
                        setState(() {
                          cluckResultPage = CluckResultsPage(
                            fetchAgain: true,
                            returnIndex: (value) {
                              if (value == 3) {
                                setState(() {
                                  searchPageIndex = value;
                                });
                              }
                            },
                            term: searchController.text,
                          );
                          searchPageIndex = 1;
                        });
                      } else {
                        if (searchPageIndex == 1) {
                          cluckResultPage = CluckResultsPage(
                            fetchAgain: true,
                            returnIndex: (value) {
                              if (value == 3) {
                                setState(() {
                                  searchPageIndex = value;
                                });
                              }
                            },
                            term: searchController.text,
                          );
                          setState(() {
                            searchPageIndex = 1;
                          });
                        } else if (searchPageIndex == 2) {
                          userResultPage = UserResultsPage(
                            fetchAgain: true,
                            returnIndex: (value) {
                              if (value == 3) {
                                setState(() {
                                  searchPageIndex = value;
                                });
                              }
                            },
                            term: searchController.text,
                          );

                          setState(() {
                            searchPageIndex = 2;
                          });
                        }
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
            bottom: TabControls(
              height: SizeConfig.blockSizeHorizontal * 13,
              onPressedLeft: () {
                if (searchController.text.isNotEmpty && startedSearch) {
                  cluckResultPage = CluckResultsPage(
                    fetchAgain: true,
                    returnIndex: (value) {
                      if (value == 3) {
                        setState(() {
                          searchPageIndex = value;
                        });
                      }
                    },
                    term: searchController.text,
                  );
                  setState(() {
                    searchPageIndex = 1;
                  });
                } else {
                  searchPageIndex = 1;
                }
              },
              onPressedRight: () {
                if (searchController.text.isNotEmpty && startedSearch) {
                  userResultPage = UserResultsPage(
                    fetchAgain: true,
                    returnIndex: (value) {
                      if (value == 3) {
                        setState(() {
                          searchPageIndex = value;
                        });
                      }
                    },
                    term: searchController.text,
                  );

                  setState(() {
                    searchPageIndex = 2;
                  });
                } else {
                  searchPageIndex = 2;
                }
              },
              isSearchTabs: true,
            ),
          )),
      body: searchPages[searchPageIndex],
    );
  }
}

class _StartSearchPage extends StatelessWidget {
  const _StartSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
    ));
  }
}

class _NoResultsFoundPage extends StatelessWidget {
  const _NoResultsFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageCard(cardType: CardType.noResults);
  }
}
