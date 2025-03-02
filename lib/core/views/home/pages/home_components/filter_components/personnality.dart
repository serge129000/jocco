import 'package:flutter/material.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/custom_uniform_scaffold.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/all_text.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/list_utils.dart';
import '../../../../../utils/screen.dart';
import '../../../../widgets/another_selected_container.dart';

class Personnality extends StatefulWidget {
  const Personnality({super.key});

  @override
  State<Personnality> createState() => _PersonnalityState();
}

class _PersonnalityState extends State<Personnality> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<UserProvider>().initPersonnality(
          personnality: Provider.of<UserProvider>(context, listen: false).personnality.isEmpty?  Provider.of<AppAuthProvider>(context, listen: false)
                  .currentAppUser
                  ?.filtre
                  ?.personnalites ??
              []: Provider.of<UserProvider>(context, listen: false).personnality);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomUniformScaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: PrimaryColors.white),
        title: Text(
          AllText.personalityType,
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
      body: Consumer2<UserProvider, AppAuthProvider>(
          builder: (context, userProvider, appAuthProvider, _) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Text(
                AllText.personalityType,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: PrimaryColors.white),
              ),
            ),
            Wrap(
              runSpacing: 10,
              spacing: 12,
              children: [
                ...traitsDePersonnalite.map((e) => GestureDetector(
                      onTap: () {
                        if (userProvider.personnality.contains(e)) {
                          userProvider.removePersonnality(personnality: e);
                        } else {
                          userProvider.setPersonnality(personnality: e);
                        }
                      },
                      child: AnotherSelectedContainer(
                          isSelected: userProvider.personnality.contains(e),
                          child: Text(
                            e,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: borderColor,
                                    fontSize: 14),
                          )),
                    ))
              ],
            ),
          ],
        );
      }),
    );
  }
}
