import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';
import 'package:clucker_client/models/user_registration.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:http/http.dart';
import '../components/functions.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign-Up',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: EmailForm(username: username),
    );
  }
}

class EmailForm extends StatefulWidget {
  const EmailForm({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {

  final _emailFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstPasswordController = TextEditingController();
  final secondPasswordController = TextEditingController();

  UserService userService = UserService();
  Functions functions = Functions();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _emailFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Please enter your email address',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontStyle: FontStyle.italic,
              fontSize: 20,
            ),
          ),
          TextBox(
            textBoxProfile: TextBoxProfile.emailField,
            controller: emailController,
          ),
          const Text(
            'Please enter a password',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontStyle: FontStyle.italic,
              fontSize: 20,
            ),
          ),
          TextBox(
            textBoxProfile: TextBoxProfile.passwordFieldSignUp,
            controller: firstPasswordController,
          ),
          TextBox(
            textBoxProfile: TextBoxProfile.passwordFieldSignUp,
            controller: secondPasswordController,
          ),
          StandardButton(
            text: 'Sign-Up',
            routeName: '',
            onPress: () async {
              if (firstPasswordController.text ==
                  secondPasswordController.text) {

                UserRegistration userRegistration = UserRegistration(
                    username: widget.username,
                    password: firstPasswordController.text,
                    email: emailController.text);

                Response response =
                    await userService.registerUser(userRegistration);

                if (response.statusCode == 201) {
                  functions.oneButtonDialog(
                      context,
                      'Account Created',
                      'Start Clucking!');
                } else {
                  functions.oneButtonDialog(
                      context,
                      'ERROR',
                      response.body);
                }
              } else {
                functions.oneButtonDialog(
                    context,
                    'Password Conflict',
                    'Passwords must match!');
              }
            },
          ),
        ],
      ),
    );
  }
}
