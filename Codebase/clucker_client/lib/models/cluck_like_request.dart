class CluckLikeRequest {
  const CluckLikeRequest(
      {required this.cluckId});

  final String cluckId;

  Map<String, String> toJSON() => {
    'cluckId': cluckId,
  };
}