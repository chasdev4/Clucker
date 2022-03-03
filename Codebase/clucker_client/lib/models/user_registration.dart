class UserRegistration {

  String username;
  String password;
  String email;

  UserRegistration({required this.username, required this.password, required this.email});

  Map<String, String> toJSON() => {
    'username': username,
    'password': password,
    'email': email
  };
}