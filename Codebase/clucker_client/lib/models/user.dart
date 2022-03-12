class User {
  User(
      this.id,
      this.username,
      this.email,
     // this.bio,
      this.joined,
      this.cluckCount,
      //this.comments,
      this.followersCount,
      this.followingCount,
      //this.eggRating,
      //this.hue
      );
  late int id;
  late String username;
  late String email;
 // late String bio;
  late DateTime joined;
  late int cluckCount;
  late int followersCount;
  late int followingCount;
  //late int eggRating;
  //late double hue;

  User.fromJson(Map<String, dynamic> json) {
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
