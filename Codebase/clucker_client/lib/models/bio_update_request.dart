class BioUpdateRequest {

  String bio;

  BioUpdateRequest({required this.bio});

  Map<String, String> toJSON() => {
    'bio': bio,
  };

}
