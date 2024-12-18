import 'package:flutter/material.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/widgets/custom_image_shower.dart';

import '../../utils/color.dart';

class UserCardComponents extends StatelessWidget {
  final String url;
  final String userName;
  final String userAge;
  const UserCardComponents({super.key, required this.url, required this.userName, required this.userAge});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 244,
          width: (size(context: context).width / 2) - 30,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
          child: CustomImageShower(url: url),
        ),
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
                        bottomRight: Radius.circular(20)
                      )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 8
                ),
                child: Text(userName + ' ' + userAge, style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: PrimaryColors.white
                ),),
              ),
                    ),
          ))
      ],
    );
  }
}
