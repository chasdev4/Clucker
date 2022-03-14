class TempUserModel {
  TempUserModel(
      this.id,
      this.username,
      this.email,
     this.bio,
      this.joined,
      this.cluckCount,
      this.followersCount,
      this.followingCount,
      );
  late int id;
  late String username;
  late String email;
  String bio = 'Not Implemented';
  late DateTime joined;
  late int cluckCount;
  late int followersCount;
  late int followingCount;
  int eggRating = 1010101;
  double hue = 0;

  TempUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
   // bio = json['bio'];
    cluckCount = json['cluckCount'];
    followersCount = json['followerCount'];
    followingCount = json['followingCount'];
    joined = json['joined'];
    //eggRating = json['eggRating'];
    //hue = json['hue'];
  }
}
