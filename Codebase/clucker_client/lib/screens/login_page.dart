import 'package:clucker_client/screens/email_signup_page.dart';
import 'package:clucker_client/screens/username_signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LogInForm(),
    );
  }
}

class LogInForm extends StatefulWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {

  final _logInFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String username = '';
  String password = '';

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _logInFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Image(
            image: AssetImage('assets/icons/clucker_logo_256x256.png'),
          ),
          const Text(
            'Clucker',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextBox(
            textBoxProfile: TextBoxProfile.emailOrUsernameFieldLogin,
            controller: usernameController,
            onEditingComplete: (){},
            onChanged: (){},
          ),
          TextBox(
            textBoxProfile: TextBoxProfile.passwordFieldLogin,
            controller: passwordController,
            onEditingComplete: (){},
            onChanged: (){},
          ),
          StandardButton(
            text: 'Log-In',
            routeName: '',
            onPress: () {
            },
          ),
          StandardButton(
            text: 'Sign-Up',
            routeName: '',
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UsernamePage()),
              );
            },
            isSecondary: true,
          ),
        ],
      ),
    );
  }
}
