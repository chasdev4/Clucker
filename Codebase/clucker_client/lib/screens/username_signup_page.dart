import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';
import 'package:clucker_client/screens/email_signup_page.dart';
import 'package:clucker_client/components/palette.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({Key? key}) : super(key: key);

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
      body: const UsernameForm(),
    );
  }
}

class UsernameForm extends StatefulWidget {
  const UsernameForm({Key? key}) : super(key: key);

  @override
  _UsernameFormState createState() => _UsernameFormState();
}

class _UsernameFormState extends State<UsernameForm> {

  final _usernameFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();

  String username = '';

  @override
  void Dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _usernameFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          const Text(
            'What would you like to be called?',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontStyle: FontStyle.italic,
              fontSize: 20,
            ),
          ),
          TextBox(
            textBoxProfile: TextBoxProfile.usernameFieldSignUp,
            controller: usernameController,
          ),
          StandardButton(
            text: 'Next',
            routeName: '',
            onPress: () {
              username = usernameController.text;
              print(username);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmailPage(username: username)),
              );
            },
          ),
        ],
      ),
    );
  }
}
