import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';
import 'package:clucker_client/models/user_registration.dart';
import 'package:clucker_client/services/user_service.dart';
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
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  String email = '';

  UserService userService = UserService();
  DialogUtil dialogUtil = DialogUtil();

  @override
  dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

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
              focusNode: emailFocusNode,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
            ),
            TextBox(
              textBoxProfile: TextBoxProfile.passwordFieldSignUp,
              controller: passwordController,
              focusNode: passwordFocusNode,
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                return passwordController.text ==
                    confirmPasswordController.text;
              },
              onChanged: () {
                return passwordController.text ==
                    confirmPasswordController.text;
              },
            ),
            TextBox(
              textBoxProfile: TextBoxProfile.confirmPasswordFieldSignUp,
              controller: confirmPasswordController,
              focusNode: confirmPasswordFocusNode,
              onFieldSubmitted: () => FocusScope.of(context).unfocus(),
              onEditingComplete: () {
                return passwordController.text ==
                    confirmPasswordController.text;
              },
              onChanged: () {
                return passwordController.text ==
                    confirmPasswordController.text;
              },
            ),
            StandardButton(
              text: 'Sign-Up',
              routeName: '',
              onPress: () async {
                List<String> errorMessages = [];
                Response response = Response('', 404);
                if (passwordController.text.isNotEmpty &&
                    confirmPasswordController.text.isNotEmpty &&
                    emailController.text.isNotEmpty) {
                  if (passwordController.text == confirmPasswordController.text) {
                    UserRegistration userRegistration = UserRegistration(
                        username: widget.username,
                        password: passwordController.text,
                        email: emailController.text);

                    response =
                        await userService.registerUser(userRegistration);
                  }

                  if (response.statusCode == 201 && passwordController.text == confirmPasswordController.text) {
                    dialogUtil.oneButtonDialog(
                        context, 'Account Created', 'Start Clucking!');
                  } else if (response.body.contains('email')){
                    errorMessages.add('A Clucker account with the email \'${emailController.text}\' already exists.');
                  }
                }

                if (passwordController.text !=
                    confirmPasswordController.text) {
                  errorMessages
                      .add('The passwords you provided do not match. Please re-enter your password.');
                }
                if (errorMessages.length == 1) {
                  dialogUtil.oneButtonDialog(
                      context, 'Hold on!', errorMessages[0]);
                } else if (errorMessages.length == 2) {
                  String errorMessageBody = '';
                  for (int i = 0; i < errorMessages.length; i++) {
                    errorMessageBody += '- ';
                    errorMessageBody += errorMessages[i];
                    if (i == 0) {
                      errorMessageBody += '\n\n';
                    }
                  }
                  dialogUtil.oneButtonDialog(
                      context, 'Hold on!', errorMessageBody);
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
