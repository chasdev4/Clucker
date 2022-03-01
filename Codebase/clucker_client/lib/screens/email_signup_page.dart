import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';
import 'package:clucker_client/models/user_registration.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:http/http.dart';
import '../components/DialogUtil.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

  UserService userService = UserService();
  DialogUtil dialogUtil = DialogUtil();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _emailFormKey,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 125),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: const Text(
                'Enter your email and password...',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextBox(
              textBoxProfile: TextBoxProfile.emailFieldSignUp,
              controller: emailController,
            ),
            TextBox(
                textBoxProfile: TextBoxProfile.passwordFieldSignUp,
                controller: firstPasswordController,
               ),
            TextBox(
              textBoxProfile: TextBoxProfile.confirmPasswordFieldSignUp,
              controller: secondPasswordController,
              onEditingComplete: () {
                if (firstPasswordController.text ==
                    secondPasswordController.text) {
                  return true;
                } else {
                  return false;
                }
              },
              onChanged: () {
                if (firstPasswordController.text ==
                    secondPasswordController.text) {
                  return true;
                } else {
                  return false;
                }
              },
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
                    dialogUtil.oneButtonDialog(
                        context, 'Account Created', 'Start Clucking!');
                  } else {
                    dialogUtil.oneButtonDialog(context, 'ERROR', response.body);
                  }
                } else {
                  dialogUtil.oneButtonDialog(
                      context, 'Password Conflict', 'Passwords must match!');
                }
              },
            ),
            StandardButton(
              text: 'Back',
              routeName: '',
              onPress: () {
                Navigator.pop(context);
              },
              isSecondary: true,
            ),
          ],
        ),
      ),
    );
  }
}
