import 'package:flutter/cupertino.dart';
import 'package:jocco/core/utils/app_utils.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/home/pages/history_components/no_likers.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/error_widget.dart';
import 'package:provider/provider.dart';

import '../../../widgets/user_card_components.dart';

class RecentLikes extends StatelessWidget {
  const RecentLikes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<UserProvider>(builder: (context, userProvider, _) {
        print(userProvider.gettingMylikers);
        if (userProvider.gettingMylikers == Status.loading) {
          return Center(
            child: CupertinoActivityIndicator(
              color: PrimaryColors.white,
            ),
          );
        }
        if (userProvider.gettingMylikers == Status.loaded) {
          if (userProvider.potentialUserLikersContent!.content.isEmpty) {
            return NoLikers();
          }
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView(
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 20,
                  spacing: 10,
                  children: [
                    ...userProvider.potentialUserLikersContent!.content
                        .map((e) => UserCardComponents(
                              url: e.profileImage!,
                              userName: e.prenom ?? '',
                              userAge:
                                  getAgeFromBirthDate(birthDate: e.dateNais!),
                            ))
                  ],
                ),
              ],
            ),
          );
        }
        if (userProvider.gettingMylikers == Status.error) {
          return CustomErrorWidget(onRetry: () {
            userProvider.refreshUserLikers(null);
          });
        }
        return SizedBox();
      }),
    ) /* PremiumPage(data: firstPremiumData) */;
  }
}
