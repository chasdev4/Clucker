import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';
import 'package:clucker_client/models/user_registration.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:http/http.dart';

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
  String email = '';
  String password = '';

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
            textBoxProfile: TextBoxProfile.emailFieldSignUp,
            controller: emailController,
            onEditingComplete: (){},
            onChanged: (){},
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
            textBoxProfile: TextBoxProfile.passwordFieldMeterSignUp,
            controller: firstPasswordController,
            onEditingComplete: () {},
            onChanged: (){},
          ),
          TextBox(
            textBoxProfile: TextBoxProfile.passwordFieldValidationSignUp,
            controller: secondPasswordController,
            onEditingComplete: () {},
            onChanged: (){},
          ),
          StandardButton(
            text: 'Sign-Up',
            routeName: '',
            onPress: () async {
              email = emailController.text;

              if (firstPasswordController.text ==
                  secondPasswordController.text) {
                password = firstPasswordController.text;

                UserRegistration userRegistration = UserRegistration(
                    username: widget.username,
                    password: password,
                    email: email);

                Response response =
                    await userService.registerUser(userRegistration);

                if (response.statusCode == 201) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Account Created'),
                      content: const Text('Start Clucking!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('ERROR'),
                      content: Text(response.body),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Password Conflict'),
                    content: const Text('Passwords must match!'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
