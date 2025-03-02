import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/app_utils.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/home/pages/history_components/no_matchers.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/error_widget.dart';
import 'package:jocco/core/views/widgets/user_card_components.dart';
import 'package:provider/provider.dart';

class HistoryComponentMatched extends StatelessWidget {
  const HistoryComponentMatched({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.potentialUserMatchsContent != null) {
        if (userProvider.potentialUserMatchsContent!.content.isNotEmpty) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  AllText.findHereMatched,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: PrimaryColors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 20,
                  spacing: 10,
                  children: [
                    ...userProvider.potentialUserMatchsContent!.content
                        .map((e) => UserCardComponents(
                              url: e.profileImage!,
                              userName: e.prenom!,
                              userAge:
                                  getAgeFromBirthDate(birthDate: e.dateNais!),
                            )),
                    if (userProvider.gettingMyMatchs == Status.loading)
                      SizedBox() //implementer le widget de pagination
                  ],
                ),
              ),
            ],
          );
        }
        if (userProvider.potentialUserMatchsContent!.content.isEmpty) {
          return NoMatchers();
        }
      }
      if (userProvider.potentialUserMatchsContent == null &&
          userProvider.gettingMyMatchs == Status.loading) {
        return Center(
          child: CupertinoActivityIndicator(
            color: PrimaryColors.white,
          ),
        );
      }
      if (userProvider.gettingMyMatchs == Status.error) {
        return CustomErrorWidget(
          onRetry: () {},
        );
      }
      return SizedBox();
    });
  }
}
