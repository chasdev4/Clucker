class UserProfileModel {
  UserProfileModel(
      this.id,
      this.username,
      this.role,
      this.bio,
      this.joined,
      this.followersCount,
      this.followingCount,
      this.eggRating,
      this.hue,
      this.avatarImage
      );
  late int id;
  late String username;
  late String role;
  late String bio;
  late int followersCount;
  late int followingCount;
  late int eggRating;
  late String joined;
  late double hue;
  late String avatarImage;

  UserProfileModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    username = json['username'];
    role = json['role'];
    bio = json['bio'] ?? '';
    followersCount = json['followersCount'];
    followingCount = json['followingCount'];
    eggRating = json['eggRating'];
    joined = json['joined'].toString();
    hue = json['avatarHue'];
    avatarImage = json['avatarImage'] ?? '';
  }
}