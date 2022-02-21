import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign-Up'
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

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _emailFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          const Text(
            'Please enter your email address',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontStyle: FontStyle.italic,
              fontSize: 20,
            ),
          ),
          TextBox(
            hintText: 'Email Address',
            isSearchField: false,
            isCluckField: false,
            isValidationField: true,
            obscureText: false,
            validationProfile: Validation.emailField,
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
            hintText: 'Password',
            isSearchField: false,
            isCluckField: false,
            isValidationField: true,
            obscureText: true,
            validationProfile: Validation.emailField,
            controller: firstPasswordController,
          ),
          TextBox(
            hintText: 'Confirm Password',
            isSearchField: false,
            isCluckField: false,
            isValidationField: true,
            obscureText: true,
            validationProfile: Validation.emailField,
            controller: secondPasswordController,
          ),
          StandardButton(
            text: 'Sign-Up',
            routeName: '',
            onPress: () {
              email = emailController.text;

              if (firstPasswordController.text == secondPasswordController.text) {
                password = firstPasswordController.text;

                print('Username: ${widget.username} \n'
                    'Email Address: $email \n'
                    'Password: $password');
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Password Conflict'),
                    content: const Text('Passwords must match!'),
                    actions: <Widget> [
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
