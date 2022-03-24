import 'package:clucker_client/components/clucker_app_bar.dart';
import 'package:clucker_client/components/palette.dart';
import 'package:clucker_client/components/standard_button.dart';
import 'package:clucker_client/models/bio_update_request.dart';
import 'package:clucker_client/services/user_service.dart';
import 'package:clucker_client/utilities/dialog_util.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage(
      {Key? key,
      required this.username,
      required this.userId,
      required this.bio,
      required this.refresh})
      : super(key: key);

  final String username;
  final int userId;
  final String bio;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    late String? initalValue;
    final TextEditingController bioController = TextEditingController();
    bioController.text = initalValue = bio;
    bioController.selection = TextSelection.fromPosition(TextPosition(offset: bioController.text.length));

    return Scaffold(
        appBar: CluckerAppBar(
            username: username,
            appBarProfile: AppBarProfile.noAvatar,
            userId: userId,
            title: 'Edit Profile'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          child: Text(
                            'Edit Bio',
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 5,
                              fontWeight: FontWeight.w700,
                              color: Palette.black,
                            ),
                          )))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      child: TextFormField(
                        maxLines: 3,
                        minLines: 3,
                        maxLength: 120,
                        keyboardType: TextInputType.text,
                        cursorColor: Palette.lightGrey,
                        controller: bioController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(3, 3))),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 6, 10, 6),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Palette.lightGrey,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Palette.lightGrey, width: 1.3),
                          ),
                          hintText: 'Add a profile bio...',
                          hintStyle: TextStyle(
                            color: Palette.lightGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ))
                ],
              ),
            ]),
            const SizedBox(
              height: 15,
            ),
            StandardButton(
              text: '',
              routeName: '',
              onPress: () {
                Navigator.pop(context);
              },
              onPressRight: () async {
              if (bioController.text != initalValue) {
                  UserService userService = UserService();
                  Response response = await userService.updateBio(
                      userId, BioUpdateRequest(bio: bioController.text));

                  print(response.statusCode);

                  if (response.statusCode != 200) {
                    DialogUtil dialogUtil = DialogUtil();
                    dialogUtil.oneButtonDialog(
                        context,
                        'Unexpected error',
                        'We encountered an'
                            ' unexpected error while processing your request,'
                            ' please try again later.');
                  }
                }
                Navigator.pop(context);

                refresh(bioController.text);
              },
              standardButtonProfile: StandardButtonProfile.saveCancel,
            ),
          ],
        ));
  }
}
