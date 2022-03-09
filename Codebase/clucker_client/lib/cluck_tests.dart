import 'package:flutter/material.dart';
import 'package:clucker_client/components/cluck.dart';

class CluckTests {

  final List<String> _cluckText = [
    'This is a cluck.',
    'This is another cluck.',
    'Short Cluck.',
    'Is this Cluck the best Cluck?',
    'Maybe this one is the best?',
    'Clucks\nCan\nLook\nLike\nThis\nToo!',
    'They can all\nlook different!',
    'What would you Cluck?',
    'Clucker can confidently collect cool Clucks!',
    'There are Clucks all over Clucker!'
  ];

  final List<String> _usernames = [
    'zculp',
    'zculp',
    'TheCluckMan',
    'RealZCulp',
    'BATMAN',
    'RealZCulp',
    'zculp',
    'BATMAN',
    'TheCluckMan',
    'zculp'
  ];

  final List<int> _eggCounts = [15,78,35,12,28,47,-25,10,9,99];

  List<Cluck> getCluckList({int howManyClucks = 1}) {
    List<Cluck> cluckList = [];

    for (int i = 0; i < howManyClucks; i++) {
      if (i < 10) {
        Cluck newCluck = Cluck(
          username: _usernames[i],
          cluckText: _cluckText[i],
          eggCount: _eggCounts[i],
        );

        cluckList.add(newCluck);
      } else {
        Cluck newCluck = Cluck(
          username: _usernames[i % 10],
          cluckText: _cluckText[i % 10],
          eggCount: _eggCounts[i % 10],
        );

        cluckList.add(newCluck);
      }
    }

    return cluckList;
  }

  void sortList(List<Cluck> _cluckList) {

  }

  }