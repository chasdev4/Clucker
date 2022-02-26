import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';
import 'package:clucker_client/components/palette.dart';

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
  EmailForm({Key? key, required this.username}) : super(key: key);

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

  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

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
            textBoxProfile: TextBoxProfile.emailField,
            controller: emailController,
            focusNode: focusNode,
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
            focusNode: focusNode,
          ),
          TextBox(
            textBoxProfile: TextBoxProfile.passwordFieldSignUp,
            controller: secondPasswordController,
            focusNode: focusNode,
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
