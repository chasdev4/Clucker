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

  List<Cluck> getOneCluck() {

    Cluck oneCluck = Cluck(
      username: _usernames[0],
      cluckText: _cluckText[0],
      eggCount: _eggCounts[0],
    );

    List<Cluck> smallList = [
      oneCluck
    ];

    return smallList;
  }

  List<Cluck> getMoreClucks() {

    List<Cluck> mediumList = [];

    for(int i = 0; i < 5; i++) {
      Cluck newCluck = Cluck(
        username: _usernames[i],
        cluckText: _cluckText[i],
        eggCount: _eggCounts[i],
      );

      mediumList.add(newCluck);
    }

    return mediumList;
  }

  List<Cluck> getAllClucks() {

    List<Cluck> bigList = [];

    for(int i = 0; i < 10; i++) {
      Cluck newCluck = Cluck(
        username: _usernames[i],
        cluckText: _cluckText[i],
        eggCount: _eggCounts[i],
      );

      bigList.add(newCluck);
    }

    return bigList;
  }

}