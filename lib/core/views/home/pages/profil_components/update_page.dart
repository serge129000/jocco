import 'package:flutter/material.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/home/pages/profil_components/all_profil_update.dart';
import 'package:jocco/core/views/onboarding/steps/fifth_step.dart';
import 'package:jocco/core/views/onboarding/steps/first_step.dart';
import 'package:jocco/core/views/onboarding/steps/fourth_step.dart';
import 'package:jocco/core/views/onboarding/steps/sixth_step.dart';
import 'package:jocco/core/views/onboarding/steps/third_step.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../../utils/all_text.dart';
import '../../../../utils/color.dart';
import '../../../widgets/image_picker_widget.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<UserProvider, AppAuthProvider, StepProvider>(
        builder: (context, userProvider, authProvider, stepProvider, _) {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              runSpacing: 10,
              spacing: 7,
              children: [
                ...List<int>.generate(6, (i) => i)
                    .map((e) => Builder(builder: (context) {
                          String? userImage;
                          try {
                            if (stepProvider.selectedImages.containsKey(e)) {
                              userImage = stepProvider.selectedImages[e];
                            } else {
                              userImage =
                                  authProvider.currentAppUser!.images[e];
                            }
                          } catch (e) {
                            userImage = null;
                          }
                          return ImagePickerWidget(
                            firstOnlineImage:
                                stepProvider.selectedImages[e] ?? userImage,
                            onImageChanged: (value, isUrl) {
                              if (value == null) {
                                stepProvider.removeImage(key: e);
                              } else {
                                stepProvider.addImage(key: e, imagePath: value);
                              }
                            },
                          );
                        }))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Text(
              AllText.aboutMe,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: PrimaryColors.white, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: PrimaryColors.white,
            ),
            onTap: () {
              kPushToPage(context, page: AllProfilUpdate(body: FirstStep(hasNotSizedBox: true,)));
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              color: dividerColor,
              thickness: 3,
            ),
          ),
          ListTile(
            leading: Text(
              AllText.catProject,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: PrimaryColors.white, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: PrimaryColors.white,
            ),
            onTap: () {
              kPushToPage(context, page: AllProfilUpdate(body: FifthStep(hasNotSizedBox: true,)));
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              color: dividerColor,
              thickness: 3,
            ),
          ),
          ListTile(
            leading: Text(
              AllText.interestCat,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: PrimaryColors.white, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: PrimaryColors.white,
            ),
            onTap: () {
              kPushToPage(context, page: AllProfilUpdate(body: FourthStep(hasNotSizedBox: true,)));
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              color: dividerColor,
              thickness: 3,
            ),
          ),
          ListTile(
            leading: Text(
              AllText.personalityType,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: PrimaryColors.white, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: PrimaryColors.white,
            ),
            onTap: () {
              kPushToPage(context, page: AllProfilUpdate(body: ThirdStep(hasNotSizedBox: true,)));
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              color: dividerColor,
              thickness: 3,
            ),
          ),
          ListTile(
            leading: Text(
              AllText.describeProject,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: PrimaryColors.white, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: PrimaryColors.white,
            ),
            onTap: () {
              kPushToPage(context, page: AllProfilUpdate(body: SixthStep(hasNotSizedBox: true,)));
            },
          ),
        ],
      );
    });
  }
}
