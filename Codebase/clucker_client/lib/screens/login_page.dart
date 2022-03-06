import 'package:clucker_client/screens/username_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';

import '../utilities/size_config.dart';

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
  final emailOrUsernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailOrUsernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  String emailOrUsername = '';
  String password = '';

  late FocusNode focusNode;

  @override
  void dispose() {
    emailOrUsernameController.dispose();
    passwordController.dispose();
    emailOrUsernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      key: _logInFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              Image(
                height: SizeConfig.blockSizeVertical * 40,
                image: const AssetImage(
                  'assets/icons/clucker-icon.png',
                ),
              ),
              SizedBox(
                width: SizeConfig.blockSizeVertical * 40 * 0.55,
                child: Transform.translate(
                  offset: const Offset(0, -15),
                  child: const FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Clucker',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              TextBox(
                textBoxProfile: TextBoxProfile.emailOrUsernameFieldLogin,
                controller: emailOrUsernameController,
                focusNode: emailOrUsernameFocusNode,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
              ),
              TextBox(
                textBoxProfile: TextBoxProfile.passwordFieldLogin,
                controller: passwordController,
                focusNode: passwordFocusNode,
                onFieldSubmitted: () => FocusScope.of(context).unfocus(),
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
                    MaterialPageRoute(
                        builder: (context) => const UsernamePage()),
                  );
                },
                isSecondary: true,
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
