class CluckPostRequest {
  const CluckPostRequest(
      {required this.body,
      required this.username,
      required this.userId,
      required this.commentCount,
      required this.eggRating});

  final String body;
  final String username;
  final String userId;
  final String commentCount;
  final String eggRating;

  Map<String, String> toJSON() => {
    'body': body,
    'username': username,
    'authorId': userId,
    'commentCount': commentCount,
    'eggRating' : eggRating
  };
}
