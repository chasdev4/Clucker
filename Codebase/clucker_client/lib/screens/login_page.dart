import 'package:clucker_client/models/auth_request.dart';
import 'package:clucker_client/screens/username_signup_page.dart';
import 'package:clucker_client/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';
import 'package:http/http.dart';

import '../utilities/size_config.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: _LogInForm(),
    );
  }
}

class _LogInForm extends StatefulWidget {
  const _LogInForm({Key? key}) : super(key: key);

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<_LogInForm> {
  final _logInFormKey = GlobalKey<FormState>();
  final emailOrUsernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailOrUsernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  String emailOrUsername = '';
  String password = '';

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
                onPress: () async {
                  AuthRequest authRequest = AuthRequest(
                      username: emailOrUsernameController.text,
                      password: passwordController.text);
                  AuthService authService = AuthService();

                  Response response = await authService.login(authRequest);


                    print('${response.statusCode}, ${response.body}, ${response.headers}');

                },
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
