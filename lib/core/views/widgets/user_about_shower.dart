import 'package:flutter/material.dart';
import 'package:jocco/core/models/app_user.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/list_utils.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/step_utils.dart';
import 'package:jocco/core/views/widgets/coloured_container.dart';

class UserAboutShower extends StatelessWidget {
  final AppUser user;
  const UserAboutShower({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1 / 0,
      width: 1 / 0,
      decoration: BoxDecoration(
          color: userShowerColor, borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Departement',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: blackShadeColor),
                ),
              ),
              ColouredContainer(
                  child: Text(
                user.departement ?? '',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: PrimaryColors.white),
              )),
              /* const Padding(padding: EdgeInsets.only(
                top: 12
              ),
              child: Divider(
                color: PrimaryColors.first,
              ),), */
              /* Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15
                ),
                child: Text('A propos de moi', style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: blackShadeColor
                  ),),
              ),
              Text(userData['about'], style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: PrimaryColors.white
              ),), */
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Divider(
                  color: PrimaryColors.first,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Categorie du projet de vie',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: blackShadeColor),
                ),
              ),
              ColouredContainer(child: Builder(builder: (context) {
                String? iconAssetPath = categories
                              .where(
                                  (e) => e['title'] == user.projet!.description)
                              .firstOrNull?['icon'];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(iconAssetPath != null)
                    Image.asset(
                      kIconAssetPath(
                          imageName: iconAssetPath
                              .toString()),
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        user.projet!.description,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: PrimaryColors.white),
                      ),
                    ),
                  ],
                );
              })),
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Divider(
                  color: PrimaryColors.first,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Projet',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: blackShadeColor),
                ),
              ),
              ColouredContainer(
                  child: Text(
                user.projet!.description,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: PrimaryColors.white),
              )),
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Divider(
                  color: PrimaryColors.first,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Avez vous des enfants?',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: blackShadeColor),
                ),
              ),
              ColouredContainer(
                  child: Text(
                user.parent.toFrenchString(),
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: PrimaryColors.white),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
