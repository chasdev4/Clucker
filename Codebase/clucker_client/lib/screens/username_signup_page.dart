import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';
import 'package:clucker_client/screens/email_signup_page.dart';
import 'package:clucker_client/services/user_service.dart';
import '../components/DialogUtil.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

  UserService userService = UserService();
  DialogUtil dialogUtil = DialogUtil();

  void disposeController() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _usernameFormKey,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 125),
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
                height: MediaQuery.of(context).size.height / 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: const Text(
                  'What would you like to be called?',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              TextBox(
                textBoxProfile: TextBoxProfile.usernameFieldSignUp,
                controller: usernameController,
                onEditingComplete: () async {
                  if (_usernameFormKey.currentState!.validate()) {}
                  username = usernameController.text;
                  return await userService.usernameAvailable(username);
                },
                onChanged: () async {
                  if (_usernameFormKey.currentState!.validate()) {}
                  username = usernameController.text;
                  return await userService.usernameAvailable(username);
                },
              ),
              StandardButton(
                text: 'Next',
                routeName: '',
                onPress: () async {

                  bool isGood = await userService.usernameAvailable(username);

                  if (_usernameFormKey.currentState!.validate()) {}

                  if (username.isNotEmpty) {
                    if (isGood && username.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EmailPage(username: username)));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
