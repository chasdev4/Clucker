class CluckPostRequest {
  const CluckPostRequest(
      {required this.body,
      required this.username,
      required this.userId,
      required this.posted,
      required this.commentCount,
      required this.eggRating});

  final String body;
  final String username;
  final int userId;
  final DateTime posted;
  final int commentCount;
  final int eggRating;

  Map<String, dynamic> toJSON() => {
    'body': body,
    'username': username,
    'authorId': userId,
    'posted': posted,
    'commentCount': commentCount,
    'eggRating' : eggRating
  };
}
