import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/app_utils.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/list_utils.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/home/pages/profil_components/settings/setting_page.dart';
import 'package:jocco/core/views/home/pages/profil_components/update_profil.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/custom_image_shower.dart';
import 'package:jocco/core/views/widgets/premium_long_card.dart';
import 'package:jocco/core/views/widgets/small_premium_components.dart';
import 'package:provider/provider.dart';

import '../../../utils/path.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppAuthProvider, UserProvider>(
        builder: (context, appAuthProvider, userProvider, _) {
      final user = appAuthProvider.currentAppUser;
      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    kIconAssetPath(imageName: 'jocco.png'),
                    height: 26.35,
                  ),
                  GestureDetector(
                    onTap: () {
                      kPushToPage(context, page: SettingPage());
                    },
                    child: Image.asset(
                      kIconAssetPath(imageName: 'uil_setting.png'),
                      height: 32,
                      width: 32,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: PrimaryColors.first,
                        radius: 35,
                        child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CustomImageShower(url: user?.profileImage)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          (user?.prenom ?? '') +
                              ', ' +
                              getAgeFromBirthDate(
                                  birthDate: user?.dateNais ?? DateTime.now()),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: PrimaryColors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      kPushToPage(context, page: UpdateProfil());
                    },
                    child: Image.asset(
                      kIconAssetPath(imageName: 'updater.png'),
                      height: 32,
                      width: 32,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallPremiumComponents(
                    data: firstPremiumData,
                  ),
                  SmallPremiumComponents(
                    data: secondPremiumData,
                  ),
                  SmallPremiumComponents(data: thirdPremiumData)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PremiumLongCard(
                  onTap: () {
                    customSheet(context: context, data: thirdPremiumData);
                  },
                  topTitle: AllText.premiumPlan,
                  subTitle: AllText.unlockWithPremium,
                  btnColor: firstPremiumBtnColor),
            )
          ],
        ),
      );
    });
  }
}
