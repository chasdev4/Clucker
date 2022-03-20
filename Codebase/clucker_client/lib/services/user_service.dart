import 'dart:convert';
import 'package:clucker_client/models/user_account_model.dart';
import 'package:clucker_client/models/user_avatar_model.dart';
import 'package:clucker_client/models/user_self_model.dart';
import 'package:clucker_client/models/user_profile_model.dart';
import 'package:clucker_client/models/user_result_model.dart';
import 'package:clucker_client/screens/followers_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:clucker_client/models/user_registration.dart';

class UserService {
  final storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'authorization');
  }
  static const String url =
      'http://cluckerapi-env.eba-zjcqgymj.us-east-2.elasticbeanstalk.com:8080/';

  Future<List<UserResultModel>> getUserResults({String term = '', int size = 20, int page = 0}) async {
    final response = await http.read(
      Uri.parse('${url}users?search=$term&size=$size&page=$page'),
    );

   // print(response);

    var jsonUsers = json.decode(response)['content'];

    return jsonUsers
        .map<UserResultModel>((json) => UserResultModel.fromJson(json))
        .toList();
  }

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
    String? token = await getToken();
    final response = await http.get(Uri.parse('${url}users/$id'),
        headers: {'authorization': token!}
    );

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserAccountModel.fromJson(userJson);
    }

    throw Exception('An error has occurred on the method getUserAccountById(). Status Code: ${response.statusCode}');
  }

  Future<UserProfileModel> getUserProfileById(int id) async {
    String? token = await getToken();
    final response = await http.get(Uri.parse('${url}users/$id'),
        headers: {'authorization': token!});

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserProfileModel.fromJson(userJson);
    }

    throw Exception('An error has occurred on the method getUserProfileById(). Status Code: ${response.statusCode}');
  }

  Future<UserResultModel> getUserResultById(int id) async {
    String? token = await getToken();
    final response = await http.get(Uri.parse('${url}users/$id'),
        headers: {'authorization': token!});

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserResultModel.fromJson(userJson);
    }
    throw Exception('An error has occurred on the method getUserResultById(). Status Code: ${response.statusCode}');
  }

  Future<UserAvatarModel> getUserAvatarById(int id) async {
    String? token = await getToken();
    final response = await http.get(Uri.parse('${url}users/$id'),
        headers: {'authorization': token!});

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserAvatarModel.fromJson(userJson);
    }
    throw Exception('An error has occurred on the method getUserAvatarById(). Status Code: ${response.statusCode}');
  }

  Future<UserSelfModel> getSelf() async {
    String? token = await getToken();
    final response = await http.get(Uri.parse('${url}users/self'),
        headers: {'authorization': token!});

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserSelfModel.fromJson(userJson);
    } else if (response.statusCode == 500) {

    }

    throw Exception('An error has occurred on the method getSelf(). Status Code: ${response.statusCode}');
  }

  Future<bool> followUser(int id) async {
    String? token = await getToken();
    final response = await http.put(Uri.parse('${url}users/$id/followers'),
        headers: {'authorization': token!});

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception('An error has occurred on the method followUser(). Status Code: ${response.statusCode}');
  }

  Future<bool> unfollowUser(int id) async {
    String? token = await getToken();
    final response = await http.delete(Uri.parse('${url}users/$id/followers'),
        headers: {'authorization': token!});

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception('An error has occurred on the method followUser(). Status Code: ${response.statusCode}');
  }

  Future<List<UserAccountModel>> getFollowers(
      {required int id, required PageContext pageContext}) async {
    String? token = await getToken();
    final response = await http.get(Uri.parse('${url}users/$id/${pageContext == PageContext.followers ? 'followers' : 'following'}'),
        headers: {'authorization': token!});

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
