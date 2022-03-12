class UserRegistration {

  String username;
  String password;
  String email;

  UserRegistration({required this.username, required this.password, required this.email});

  Map<String, String> toJSON() => {
    'username': username,
    'password': password,
    'email': email,
    'hue' : getAvatarHue().toString()
  };

  double getAvatarHue() {
    int index = 3;
    double hue = 0;

    if (username.codeUnitAt(index) >= 48 &&
        username.codeUnitAt(index) <= 57) {
      hue = (58 - username.codeUnitAt(3)) * 30;
    } else if (username.codeUnitAt(index) >= 65 &&
        username.codeUnitAt(index) <= 77) {
      hue = (78 - username.codeUnitAt(index)) * 27.5;
    } else if (username.codeUnitAt(index) >= 78 &&
        username.codeUnitAt(index) <= 90) {
      hue = (91 - username.codeUnitAt(index)) * 27.5;
    } else if (username.codeUnitAt(index) >= 95 &&
        username.codeUnitAt(index) <= 109) {
      hue = (110 - username.codeUnitAt(index)) * 24;
    } else if (username.codeUnitAt(index) >= 110 &&
        username.codeUnitAt(index) <= 122) {
      hue = (123 - username.codeUnitAt(index)) * 27.5;
    }

    if (username[index] == '7' ||
        username[index] == '8' ||
        username[index] == 'x' ||
        username[index] == 'X' ||
        username[index] == 'y' ||
        username[index] == 'Y' ||
        username[index] == 'l' ||
        username[index] == 'L' ||
        username[index] == 'k' ||
        username[index] == 'K') {
      hue = hue - 45;
    }

    return hue;
  }
}