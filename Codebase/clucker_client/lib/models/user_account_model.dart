class UserAccountModel {
  UserAccountModel(
      {required this.id,
      required this.username,
      required this.hue,
      required this.avatarImage});
  late int id;
  late String username;
  late double hue;
  late String? avatarImage;

  UserAccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    hue = json['avatarHue'];
    avatarImage = json['avatarImage'];
  }
}
