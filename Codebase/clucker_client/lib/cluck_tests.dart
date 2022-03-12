// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:clucker_client/components/cluck_widget.dart';
//
// class CluckTests {
//
//   final List<String> _cluckText = [
//     'This is a cluck.',
//     'This is another cluck.',
//     'Short Cluck.',
//     'Is this Cluck the best Cluck?',
//     'Maybe this one is the best?',
//     'Clucks\nCan\nLook\nLike\nThis\nToo!',
//     'They can all\nlook different!',
//     'What would you Cluck?',
//     'Clucker can confidently collect cool Clucks!',
//     'There are Clucks all over Clucker!'
//   ];
//
//   final List<String> _usernames = [
//     '12345678901234567890',
//     'zculp',
//     'TheCluckMan',
//     'RealZCulp',
//     'BATMAN',
//     'RealZCulp',
//     'zculp',
//     'BATMAN',
//     'TheCluckMan',
//     'zculp'
//   ];
//
//   final List<DateTime> _postDates = [
//     DateTime.parse("2021-12-12 11:47:00"),
//     DateTime.parse("2022-01-23 12:23:00"),
//     DateTime.parse("2020-08-29 01:47:00"),
//     DateTime.parse("2019-07-05 11:45:00"),
//     DateTime.parse("2021-12-03 05:47:00"),
//     DateTime.parse("2022-02-02 11:53:00"),
//     DateTime.parse("2022-02-09 08:14:00"),
//     DateTime.parse("2022-03-04 11:54:00"),
//     DateTime.parse("2022-03-03 03:38:00"),
//     DateTime.parse("2022-03-02 11:23:00"),
//   ];
//
//   final List<int> _eggCounts = [15, 78, 35, 12, 0, 47, -25, 10, 9, 99];
//
//   List<Widget> _comments = [];
//
//   Random rnd = Random();
//
//   List<Widget> getCluckList({int howManyClucks = 1}) {
//     List<Widget> cluckList = [];
//
//     for (int i = 0; i < howManyClucks; i++) {
//       CluckWidget newCluck;
//
//       if (i < 10) {
//         newCluck = CluckWidget(
//           postDate: _postDates[i],
//           username: _usernames[i],
//           cluckText: _cluckText[i],
//           eggCount: _eggCounts[i],
//           comments: getCommentList(),
//         );
//       } else {
//         newCluck = CluckWidget(
//           postDate: _postDates[i % 10],
//           username: _usernames[i % 10],
//           cluckText: _cluckText[i % 10],
//           eggCount: _eggCounts[i % 10],
//           comments: getCommentList(),
//         );
//       }
//       cluckList.add(newCluck);
//     }
//
//     return cluckList;
//   }
//
//   List<Widget> getCommentList() {
//     final List<String> cluckText = [
//       'This is a comment.',
//       'It\'s a small world afterall...',
//       'I agree.\nLike if you agree.',
//       'I always have to debate this',
//       'Maybe next time...',
//       'Reminds me of that one lyric.',
//       'You have been\nposting alot today!',
//       'The\nworld\nwill\nnever\nknow?',
//       'Isn\'t this fun?!',
//       'Follow me,\nit\'s free!'
//     ];
//
//     final List<String> usernames = [
//       '12345678901234567890',
//       'toaster',
//       'love_lock5',
//       'maniacalG',
//       'MANBAT',
//       'a_rising_sun',
//       'mandy249095',
//       'Zamos',
//       'finlandaero',
//       'jetbrains'
//     ];
//
//     final List<DateTime> postDates = [
//       DateTime.parse("2021-12-12 11:47:00"),
//       DateTime.parse("2022-01-23 12:23:00"),
//       DateTime.parse("2020-08-29 01:47:00"),
//       DateTime.parse("2019-07-05 11:45:00"),
//       DateTime.parse("2021-12-03 05:47:00"),
//       DateTime.parse("2022-02-02 11:53:00"),
//       DateTime.parse("2022-02-09 08:14:00"),
//       DateTime.parse("2022-03-04 11:54:00"),
//       DateTime.parse("2022-03-03 03:38:00"),
//       DateTime.parse("2022-03-02 11:23:00"),
//     ];
//
//     final List<int> eggCounts = [15, 78, 35, 12, 0, 47, -25, 10, 9, 99];
//
//
//     _comments = [];
//     int numComments = rnd.nextInt(20);
//     for (int j = 0; j < numComments; j++) {
//       _comments.add(CluckWidget(
//         postDate: postDates[rnd.nextInt(10)],
//         cluckType: CluckType.comment,
//         username: usernames[rnd.nextInt(10)],
//         cluckText: cluckText[rnd.nextInt(10)],
//         eggCount: eggCounts[rnd.nextInt(10)],
//       ));
//     }
//
//     return _comments;
//   }
// }
