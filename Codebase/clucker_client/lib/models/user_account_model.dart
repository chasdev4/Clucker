class UserAccountModel {
  UserAccountModel(
      this.id,
      this.username,
      );
  late int id;
  late String username;
  double hue = 0;

  UserAccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    //hue = json['hue'];
  }
}
