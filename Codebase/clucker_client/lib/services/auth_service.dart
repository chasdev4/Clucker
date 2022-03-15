import 'dart:convert';
import 'package:clucker_client/models/auth_request.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String url =
      'http://cluckerapi-env.eba-zjcqgymj.us-east-2.elasticbeanstalk.com:8080/';

  Future<http.Response> login(AuthRequest _authRequest) async{
    return await http.post(
      Uri.parse('${url}login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(_authRequest.toJSON()),
    );
  }
}