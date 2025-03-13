import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/page_provider.dart';
import 'package:jocco/core/views/widgets/button.dart';
import 'package:jocco/core/views/widgets/custom_image_shower.dart';
import 'package:provider/provider.dart';

class NoLikers extends StatelessWidget {
  const NoLikers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppAuthProvider, PageProvider>(
        builder: (context, appAuthProvider, pageProvider, _) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: CustomImageShower(
                    url: appAuthProvider.currentAppUser?.profileImage,
                    isRounded: true,
                  ),
                ),
                Positioned(
                  bottom: -15,
                  child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PrimaryColors.gradientF),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          kIconAssetPath(imageName: 'thunder.png'),
                        ),
                      )),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                AllText.moreViews,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 25,
                    color: PrimaryColors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              AllText.whyMoreView,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 20,
                    color: PrimaryColors.white,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Btn(
                function: () {
                  HapticFeedback.mediumImpact();
                  /* kPushToPage(context,
                      page: PremiumPage(data: firstPremiumData)); */
                  likeBoostSheet(context: context);
                },
                child: Text(
                  AllText.explorePlan,
                  style: TextStyle(color: PrimaryColors.white),
                ),
                isTransparent: false,
                anotherColor: firstPremiumBtnColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                pageProvider.changePage(page: Pages.home);
              },
              child: Text(
                AllText.swipe,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 15,
                      color: PrimaryColors.white,
                    ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
