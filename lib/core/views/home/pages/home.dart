import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/views/home/pages/home_components/no_potential_match_components.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/custom_image_shower.dart';
import 'package:jocco/core/views/widgets/user_info_card.dart';
import 'package:provider/provider.dart';

import '../../../utils/screen.dart';
import 'home_components/filter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    /* FirebaseAuth.instance.currentUser!.getIdToken().then((v) {
      print(v);
    }); */
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    kIconAssetPath(imageName: 'jocco.png'),
                    height: 26.35,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Consumer2<UserProvider, AppAuthProvider>(
                          builder: (context, userProvider, appAuthProvider, _) {
                        return GestureDetector(
                          onTap: () {
                            if (appAuthProvider
                                    .currentAppUser?.subscription?.active ??
                                false) {
                              userProvider.setUnfinsihList();
                              Future.delayed(Duration(milliseconds: 100), () {
                                userProvider.controller.unswipe();
                              });
                            } else {
                              getBackSheet(context: context);
                            }
                          },
                          child: Image.asset(
                            kIconAssetPath(
                                imageName: 'icon-park-outline_back-one.png'),
                            height: 32,
                            width: 32,
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Consumer<AppAuthProvider>(
                          builder: (BuildContext context, AppAuthProvider value,
                              Widget? child) {
                            return GestureDetector(
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                  kPushToPage(context, page: Filter());
                                  //value.logoutUser();
                                },
                                child: Image.asset(
                                  kIconAssetPath(
                                      imageName: 'fluent_filter-20-filled.png'),
                                  height: 32,
                                  width: 32,
                                ));
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(child: Consumer2<UserProvider, AppAuthProvider>(
                builder: (context, userProvider, appAuthProvider, _) {
              userProvider.controller.activityHistory.then((v) {
                print(v?.length);
              });
              if (userProvider.potentialMatchingUsers != null) {
                if (userProvider.finalUsers.isNotEmpty) {
                  if (userProvider.listFinish) {
                    return NoPotentialMatchComponents();
                  }
                  return AppinioSwiper(
                    initialIndex: userProvider.currentCardIndex.$2,
                    onEnd: () {
                      userProvider.setFinishingList();
                    },
                    controller: userProvider.controller,
                    backgroundCardCount: 0,
                    onSwipeEnd: (previousIndex, targetIndex, activity) {
                      userProvider.controller.activityHistory.then((v) {
                        print(v?.length);
                      });
                      userProvider.setCardIndex((previousIndex, targetIndex));
                    },
                    cardBuilder: (BuildContext context, int index) {
                      return UserInfoCard(
                        user: userProvider.finalUsers[index],
                        controller: userProvider.controller,
                        pageController: null,
                      );
                    },
                    swipeOptions: SwipeOptions.only(),
                    cardCount: userProvider.finalUsers.length,
                  );
                }
              }
              return Stack(
                alignment: Alignment.center,
                children: [
                  SpinKitPulse(
                    size: 170,
                    color: PrimaryColors.gradientF,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CustomImageShower(
                      url: appAuthProvider.currentAppUser?.profileImage,
                      isRounded: true,
                    ),
                  )
                ],
              );
            }))
          ],
        ),
      ),
    );
  }
}
