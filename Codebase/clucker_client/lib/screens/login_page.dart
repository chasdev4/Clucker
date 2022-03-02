import 'package:clucker_client/screens/username_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
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
          Column(
            children: [
             const Image(
                width: 256,
                height: 256,
                image: AssetImage(
                  'assets/icons/clucker-icon.png',
                ),
              ),
              Transform.translate(offset: const Offset(0, -15), child:
             const  Text(
                'Clucker',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),),
            ],
          ),
          const SizedBox(height: 15,),
          Column(children: [
            TextBox(
              textBoxProfile: TextBoxProfile.emailOrUsernameFieldLogin,
              controller: usernameController,
              onEditingComplete: () {},
              onChanged: () {},
            ),
            TextBox(
              textBoxProfile: TextBoxProfile.passwordFieldLogin,
              controller: passwordController,
              onEditingComplete: () {},
              onChanged: () {},
            ),
            StandardButton(
              text: 'Log-In',
              routeName: '',
              onPress: () {},
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
          ],),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }
}
