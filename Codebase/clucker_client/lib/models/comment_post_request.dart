class CommentPostRequest {
  CommentPostRequest({required this.cluckId, required this.body, required this.username, required this.userId,
    required this.posted, required this.eggRating});

  final String cluckId;
  final String body;
  final String username;
  final int userId;
  final DateTime posted;
  final int eggRating;

  Map<String, dynamic> toJSON() => {
        'cluckId': cluckId,
        'body': body,
        'username': username,
        'authorId': userId,
        'posted': posted,
        'eggRating': eggRating
      };
}