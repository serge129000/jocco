import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/views/home/pages/home_components/filter_components/add_cat_project.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/custom_uniform_scaffold.dart';
import 'package:jocco/core/views/widgets/more_listtile.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/screen.dart';

class SelectProjectLife extends StatelessWidget {
  const SelectProjectLife({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomUniformScaffold(
      body: SizedBox(
        width: 1 / 0,
        child: Consumer2<AppAuthProvider, UserProvider>(
            builder: (context, appAuthProvider, userProvider, _) {
          final currentFilter = appAuthProvider.currentAppUser?.filtre;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                iconTheme: IconThemeData(color: PrimaryColors.white),
                title: Text(
                  AllText.catProject,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  AllText.catProject,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: PrimaryColors.white),
                ),
              ),
              if (currentFilter!.categories.isEmpty &&
                  userProvider.filterData['projectCat'] == null || ((userProvider.filterData['projectCat'] ?? []) as List).isEmpty)
                Container(
                  color: Color(0xff1e7e7e),
                  child: ListTile(
                    leading: Text(
                      appAuthProvider
                              .currentAppUser?.projet!.categories.first ??
                          '',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: PrimaryColors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      Icons.check,
                      size: 15,
                      color: PrimaryColors.white,
                    ),
                  ),
                ),
              if (currentFilter.categories.isNotEmpty &&
                  userProvider.filterData['projectCat'] == null)
                ...currentFilter.categories.map(
                  (e) => Container(
                    color: Color(0xff1e7e7e),
                    child: ListTile(
                      leading: Text(
                        e,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                                color: PrimaryColors.white,
                                fontWeight: FontWeight.w500),
                      ),
                      trailing: Icon(
                        Icons.check,
                        size: 15,
                        color: PrimaryColors.white,
                      ),
                    ),
                  ),
                ),
              if (userProvider.filterData['projectCat'] != null &&
                  (userProvider.filterData['projectCat'] as List).isNotEmpty)
                ...(userProvider.filterData['projectCat'] as List<String>).map(
                  (e) => Column(
                    children: [
                      Container(
                        color: Color(0xff1e7e7e),
                        child: ListTile(
                          leading: Text(
                            e,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: PrimaryColors.white,
                                    fontWeight: FontWeight.w500),
                          ),
                          trailing: Icon(
                            Icons.check,
                            size: 15,
                            color: PrimaryColors.white,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: MoreListtile(
                    listTileText: 'Ajouter jusqu\'à 3 catégories',
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      kPushToPage(context, page: AddCatProject());
                    }),
              )
            ],
          );
        }),
      ),
    );
  }
}
