import 'package:clucker_client/models/auth_request.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:clucker_client/navigation/home.dart';
import 'package:clucker_client/screens/username_signup_page.dart';
import 'package:clucker_client/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';
import 'package:clucker_client/utilities/dialog_util.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  final storage = const FlutterSecureStorage();
  final _logInFormKey = GlobalKey<FormState>();
  final emailOrUsernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailOrUsernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  UserService userService = UserService();
  DialogUtil dialogUtil = DialogUtil();

  String emailOrUsername = '';
  String password = '';

  final double offsetScale = -1.9;
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
        child: Transform.translate(
            offset: Offset(0,
                (MediaQuery.of(context).viewInsets.bottom * offsetScale * 0.3)),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: SizeConfig.blockSizeVertical * 40,
                        image: const AssetImage(
                          'assets/icons/clucker-icon.png',
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeVertical * 40 * 0.55,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Transform.translate(
                              offset: const Offset(0, -7),
                              child: const Text(
                                'Clucker',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextBox(
                        textBoxProfile:
                            TextBoxProfile.emailOrUsernameFieldLogin,
                        controller: emailOrUsernameController,
                        focusNode: emailOrUsernameFocusNode,
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                          return true;
                        },
                        onChanged: () {
                          FocusScope.of(context).nextFocus();
                          return true;
                        },
                      ),
                      TextBox(
                        textBoxProfile: TextBoxProfile.passwordFieldLogin,
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        onFieldSubmitted: () =>
                            FocusScope.of(context).unfocus(),
                      ),
                      StandardButton(
                        text: 'Log-In',
                        onPress: () async {
                          AuthRequest authRequest = AuthRequest(
                              username: emailOrUsernameController.text,
                              password: passwordController.text);
                          AuthService authService = AuthService();

                          Response response =
                              await authService.login(authRequest);

                          if (response.statusCode == 200) {
                            response.headers.forEach((key, value) {
                              if (key == 'authorization') {
                                storage.write(key: key, value: value);
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                              );
                            });
                          } else {
                            passwordController.text = '';
                            emailOrUsernameController.text = '';
                            String title = 'Log-In Error';
                            String message =
                                'There was an issue with your password or username.'
                                '\nPlease try again.';
                            dialogUtil.oneButtonDialog(context, title, message);
                          }
                        },
                      ),
                      StandardButton(
                        text: 'Sign-Up',
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
            )));
  }
}
