import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:clucker_client/components/text_box.dart';
import 'package:clucker_client/components/standard_button.dart';
import 'package:clucker_client/screens/email_signup_page.dart';
import 'package:clucker_client/services/user_service.dart';
import '../utilities/dialog_util.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: UsernameForm(),
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
  final usernameFocusNode = FocusNode();
  final offsetScale = -0.8;

  String username = '';

  UserService userService = UserService();
  DialogUtil dialogUtil = DialogUtil();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      key: _usernameFormKey,
      child: Transform.translate(
          offset: Offset(0,
              (MediaQuery.of(context).viewInsets.bottom * offsetScale * 0.3)),
          child: Stack(
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 125),
                  child: Row(children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 8,
      ),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                       )],))
                    ]),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 6,),
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
                      focusNode: usernameFocusNode,
                      onFieldSubmitted: () => FocusScope.of(context).unfocus(),
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
                        bool isGood =
                            await userService.usernameAvailable(username);

                        if (_usernameFormKey.currentState!.validate()) {}

                        if (isGood && username.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EmailPage(username: username)));
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
              )
            ],
          )),
    );
  }
}
