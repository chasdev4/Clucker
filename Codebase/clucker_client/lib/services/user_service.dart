import 'dart:convert';
import 'package:clucker_client/models/user_account_model.dart';
import 'package:clucker_client/models/user_avatar_model.dart';
import 'package:clucker_client/models/user_self_model.dart';
import 'package:clucker_client/models/user_profile_model.dart';
import 'package:clucker_client/models/user_result_model.dart';
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

  Future<UserAccountModel> getUserAccountById(int id) async {
    final response = await http.get(Uri.parse('${url}users/$id'));

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserAccountModel.fromJson(userJson);
    }

    throw Exception('An error has occurred on the method getUserAccountById(). Status Code: ${response.statusCode}');
  }

  Future<UserProfileModel> getUserProfileById(int id) async {
    final response = await http.get(Uri.parse('${url}users/$id'));

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserProfileModel.fromJson(userJson);
    }

    throw Exception('An error has occurred on the method getUserProfileById(). Status Code: ${response.statusCode}');
  }

  Future<UserResultModel> getUserResultById(int id) async {
    final response = await http.get(Uri.parse('${url}users/$id'));

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserResultModel.fromJson(userJson);
    }
    throw Exception('An error has occurred on the method getUserResultById(). Status Code: ${response.statusCode}');
  }

  Future<UserAvatarModel> getUserAvatarById(int id) async {
    final response = await http.get(Uri.parse('${url}users/$id'));

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserAvatarModel.fromJson(userJson);
    }
    throw Exception('An error has occurred on the method getUserAvatarById(). Status Code: ${response.statusCode}');
  }

  Future<UserSelfModel> getSelf(String _token) async {
    final response = await http.get(Uri.parse('${url}users/self'),
        headers: {'authorization': _token});

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserSelfModel.fromJson(userJson);
    }

    throw Exception('An error has occurred on the method getSelf(). Status Code: ${response.statusCode}');
  }

  Future<bool> followUser(int id) async {
    final response = await http.put(Uri.parse('${url}users/$id/followers'));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception('An error has occurred on the method followUser(). Status Code: ${response.statusCode}');
  }

  Future<List<UserAccountModel>> getFollowers(int id) async {
    final response = await http.get(Uri.parse('${url}users/$id/followers'));

    if (response.statusCode == 200) {
      var jsonFollowers = json.decode(response.body)['content'];
      List<UserAccountModel> userAccounts = jsonFollowers
          .map<UserAccountModel>((json) => UserAccountModel.fromJson(json))
          .toList();

      return userAccounts;
    }

    throw Exception('An error has occurred on the method getFollowers(). Status Code: ${response.statusCode}');
  }
}
