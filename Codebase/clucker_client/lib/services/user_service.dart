import 'dart:convert';
import 'package:clucker_client/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:clucker_client/models/user_registration.dart';

class UserService {
  static const String url =
      'http://cluckerapi-env.eba-zjcqgymj.us-east-2.elasticbeanstalk.com:8080/';

  Future<bool> usernameAvailable(String _username) async {
    final response = await http
        .get(Uri.parse('${url}users/available-usernames?username=$_username'));

    return response.statusCode == 200;
  }

  Future<http.Response> registerUser(UserRegistration _userRegister) async {
    return await http.post(
      Uri.parse('${url}users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(_userRegister.toJSON()),
    );
  }

  Future<User> getUserById(int id) async {
    final response = await http.get(Uri.parse('${url}users/$id'));

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return User.fromJson(userJson);
    }

    throw Exception('User with the id $id was not found');
  }

  Future<User> getSelf() async {
    final response = await http.get(Uri.parse('${url}users/self'));

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return User.fromJson(userJson);
    }

    throw Exception('User \'self\' was not found');
  }

  void updateUserById(int id) async {

  }
}
