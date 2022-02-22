import 'package:http/http.dart' as http;

class UserService {

  Future <bool> usernameAvailable(String _username) async {

    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/users/available-usernames?username=$_username'));

    return response.statusCode == 200;
  }

}