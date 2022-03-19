class CommentPostRequest {
  CommentPostRequest(
      {required this.cluckId,
      required this.body,
      required this.username,
      required this.userId,
      required this.eggRating});

  final String cluckId;
  final String body;
  final String username;
  final int userId;
  final int eggRating;

  Map<String, String> toJSON() => {
        'cluckId': cluckId,
        'body': body,
        'username': username,
        'authorId': userId.toString(),
        'eggRating': eggRating.toString()
      };
}
