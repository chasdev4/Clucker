import 'package:clucker_client/components/cluck_widget.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum CardType {
  endCard,
  noItems,
  noComments,
  noResults,
  noCard
}

class PageCard extends StatelessWidget {
  const PageCard({Key? key, required this.cardType, this.commentsPage = false})
      : super(key: key);

  final CardType cardType;
  final bool commentsPage;

  @override
  Widget build(BuildContext context) {
    return cardType == CardType.noCard ? const SizedBox() : SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width -
          MediaQuery.of(context).size.width / 5,
      child: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                  cardType == CardType.noComments
                      ? FontAwesomeIcons.solidCommentDots
                      : cardType == CardType.noResults
                          ? FontAwesomeIcons.cookieBite
                          : FontAwesomeIcons.egg,
                  size: 100,
                  color: Palette.cluckerRed.toMaterialColor().shade200),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    cardType == CardType.endCard
                        ? 'You\'ve reached the end!'
                        : cardType == CardType.noResults
                            ? 'No results found...'
                            : cardType == CardType.noComments
                                ? 'Be the first to post a\ncomment on this cluck'
                                : cardType == CardType.noItems
                                    ? 'Nothing to show here!'
                                    : 'Data not found',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Palette.offBlack.toMaterialColor().shade100,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                    maxLines: 2,
                  )),
              SizedBox(
                height: commentsPage ? 75 : 0,
              )
            ]),
      ),
    );
  }
}
