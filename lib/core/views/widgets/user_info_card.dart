import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/views/widgets/custom_image_shower.dart';
import 'package:jocco/core/views/widgets/user_about_shower.dart';

class UserInfoCard extends StatefulWidget {
  final Map<String, dynamic> userData;
  final AppinioSwiperController controller;
  final PageController pageController;
  const UserInfoCard(
      {super.key, required this.userData, required this.controller, required this.pageController});
  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1 / 0,
      width: 1 / 0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(builder: (context, constraint) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              child: PageView(
                controller: widget.pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                children: [
                  ...(widget.userData['userImages'] as List<String>)
                      .take(1)
                      .map((e) => CustomImageShower(url: e)),
                  UserAboutShower(userData: widget.userData),
                  ...(widget.userData['userImages'] as List<String>)
                      .skip(1)
                      .map((e) => CustomImageShower(url: e)),
                ],
              ),
            ),
            Positioned(
                top: 20,
                left: 10,
                right: 10,
                child: SizedBox(
                  width: constraint.maxWidth,
                  child: Builder(builder: (context) {
                    List value =
                        List<String>.from(widget.userData['userImages'])
                          ..add('');
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...value.map((e) => Builder(builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Opacity(
                                  opacity:
                                      value.indexOf(e) == currentPage ? 1 : .5,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeOut,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: PrimaryColors.white),
                                    height: 5,
                                    width:
                                        ((constraint.maxWidth) / value.length) -
                                            20,
                                    /* color: PrimaryColors.white, */
                                  ),
                                ),
                              );
                            }))
                      ],
                    );
                  }),
                )),
                if(currentPage != 1)
                Positioned(
                  bottom: 0,
                  child: Opacity(
                  opacity: .7,
                  child: AnimatedContainer(
                    duration: Duration(
                      milliseconds: 700
                    ),
                    height: constraint.maxHeight / 4.5,
                    width: constraint.maxWidth,
                    decoration: const BoxDecoration(
                      color: PrimaryColors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.userData['nom'] + ' ' + widget.userData['age'].toString(), style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: PrimaryColors.white,
                            fontWeight: FontWeight.bold
                          ),),
                          Padding(padding: const EdgeInsets.symmetric(
                            vertical: 2
                          ),
                          child: Text(widget.userData['projet'], style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: PrimaryColors.white,
                            fontWeight: FontWeight.w500
                          ),),)
                        ],
                      ),
                    ),
                  ),
                )),
            Positioned(
                bottom: -20,
                left: 50,
                child: GestureDetector(
                  onTap: () {
                    widget.controller.swipeLeft();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: PrimaryColors.white,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 35,
                      color: PrimaryColors.first,
                    ),
                  ),
                )),
            Positioned(
                bottom: -20,
                right: 50,
                child: GestureDetector(
                  onTap: () {
                    widget.controller.swipeDown();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: PrimaryColors.white,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      size: 35,
                      color: PrimaryColors.first,
                    ),
                  ),
                )),
                
          ],
        );
      }),
    );
  }
}