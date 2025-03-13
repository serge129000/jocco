import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jocco/core/models/app_user.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/widgets/custom_image_shower.dart';
import 'package:jocco/core/views/widgets/user_info_card.dart';

import '../../utils/color.dart';

class UserCardComponents extends StatelessWidget {
  final AppUser user;
  final String url;
  final String userName;
  final String userAge;
  final bool? isHiden;
  final bool isMatched;
  const UserCardComponents(
      {super.key,
      required this.user,
      required this.url,
      this.isMatched = false,
      required this.userName,
      this.isHiden = false,
      required this.userAge});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (isHiden == false)
            showDialog(
                context: context,
                builder: (context) => Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 70,
                      horizontal: 20
                    ),
                    child: UserInfoCard(
                      isMatched: isMatched,
                        user: user,
                        controller: null,
                        pageController: PageController()),
                  ),
                ));
          },
          child: Container(
            height: 244,
            width: (size(context: context).width / 2) - 30,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                    sigmaX: !isHiden! ? 0 : 10, sigmaY: !isHiden! ? 0 : 10),
                child: CustomImageShower(url: url)),
          ),
        ),
        if (!isHiden!)
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: .6,
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      color: PrimaryColors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: Text(
                      userName + ' ' + userAge,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: PrimaryColors.white),
                    ),
                  ),
                ),
              ))
      ],
    );
  }
}
