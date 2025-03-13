import 'package:flutter/material.dart';
import 'package:jocco/core/views/landing/landing_screen.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/widgets/custom_uniform_scaffold.dart';
import 'package:jocco/core/views/widgets/more_listtile.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/all_text.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/screen.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppAuthProvider>(builder: (context, appAuthProvider, _) {
      return CustomUniformScaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: PrimaryColors.white),
          title: Text(
            AllText.settings,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: PrimaryColors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  kPopPage(context);
                },
                child: Text(
                  AllText.finish,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: PrimaryColors.white),
                ),
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            MoreListtile(
                listTileText: AllText.disconnect,
                onTap: () {
                  appAuthProvider.logoutUser();
                  kPushAndRemoveUntil(context, page: LandingScreen());
                })
          ],
        ),
      );
    });
  }
}
