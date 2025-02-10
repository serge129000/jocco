import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/test_data.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
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
  final AppinioSwiperController appinioSwiperController =
      AppinioSwiperController();
  final PageController pageController = PageController();
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
                      GestureDetector(
                        onTap: () {
                          appinioSwiperController.unswipe();
                        },
                        child: Image.asset(
                          kIconAssetPath(
                              imageName: 'icon-park-outline_back-one.png'),
                          height: 32,
                          width: 32,
                        ),
                      ),
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
            Expanded(
                child: AppinioSwiper(
              controller: appinioSwiperController,
              backgroundCardCount: 0,
              onSwipeEnd: (previousIndex, targetIndex, activity) {
                pageController.jumpTo(0);
              },
              cardBuilder: (BuildContext context, int index) {
                return UserInfoCard(
                  userData: data[index],
                  controller: appinioSwiperController,
                  pageController: pageController,
                );
              },
              cardCount: data.length, /*  UserInfoCard(userData: data[0]) */
            ))
          ],
        ),
      ),
    );
  }
}
