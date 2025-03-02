import 'package:flutter/material.dart';
import 'package:jocco/core/utils/list_utils.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/custom_uniform_scaffold.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/all_text.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/screen.dart';
import '../../../../widgets/button.dart';

class AddCatProject extends StatefulWidget {
  const AddCatProject({super.key});

  @override
  State<AddCatProject> createState() => _AddCatProjectState();
}

class _AddCatProjectState extends State<AddCatProject> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<UserProvider>().initProjectCat(
          receivCat:Provider.of<UserProvider>(context, listen: false).filterData['projectCat'] ??  Provider.of<AppAuthProvider>(context, listen: false)
                  .currentAppUser
                  ?.filtre
                  ?.categories ??
              []);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomUniformScaffold(
      appBar: AppBar(
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
      body: Consumer2<AppAuthProvider, UserProvider>(
          builder: (context, appAuthProvider, userProvider, _) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                AllText.addProjectCat,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: PrimaryColors.white),
              ),
            ),
            ...categories.map(
              (e) => Container(
                color: Color(0xff1e7e7e),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        if (!(userProvider.filterData['projectCat'] as List)
                            .contains(e['title'])) {
                          if ((userProvider.filterData['projectCat'] as List)
                                      .length >=
                                  1 &&
                              appAuthProvider.currentAppUser!.subscription!
                                      .typeAbonnement ==
                                  'FREE') {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    stopOnFree(context: context));
                          } else {
                            userProvider.setProjectCat(projectCat: e['title']);
                          }
                          
                        } else {
                          userProvider.removeCat(cat: e['title']);
                        }
                        //debugPrint(userProvider.cat.toString());
                      },
                      leading: Text(
                        e['title'],
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: PrimaryColors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: ((userProvider.filterData['projectCat'] ?? [])
                                  as List)
                              .contains(e['title'])
                          ? Icon(
                              Icons.check,
                              size: 15,
                              color: PrimaryColors.white,
                            )
                          : SizedBox(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        color: dividerColor,
                        thickness: 3,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

Widget stopOnFree({required BuildContext context}) =>
    StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
          backgroundColor: PrimaryColors.first,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(kAssetPath(imageName: 'stop.png')),
              Text(
                'En tant que membre gratuit, vous pouvez sélectionner une seule catégorie de projet de vie. Pour choisir jusqu\'à 3 catégories et bénéficier de changements instantanés, passez à l\'abonnement premium.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: PrimaryColors.white, fontWeight: FontWeight.w500),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      SizedBox(
                          width: size(context: context).width / 3.6,
                          child: Btn(
                              isTransparent: true,
                              function: () {
                                kPopPage(context);
                              },
                              child: Text(
                                'Annuler',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: PrimaryColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                              ))),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Btn(
                              isTransparent: false,
                              function: () {
                                kPopPage(context);
                              },
                              child: Text(
                                'Passer Premium',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: PrimaryColors.first,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                              )))
                    ],
                  ))
            ],
          ));
    });
