import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jocco/core/models/app_user.dart';
import 'package:jocco/core/streams/register_stream.dart';
import 'package:jocco/core/utils/app_utils.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/home/pages/profil_components/update_page.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:jocco/core/views/widgets/custom_uniform_scaffold.dart';
import 'package:jocco/core/views/widgets/user_info_card.dart';
import 'package:provider/provider.dart';

import '../../../../utils/all_text.dart';
import '../../../../utils/color.dart';
import '../../../providers/auth_provider.dart';

class UpdateProfil extends StatefulWidget {
  const UpdateProfil({super.key});

  @override
  State<UpdateProfil> createState() => _UpdateProfilState();
}

class _UpdateProfilState extends State<UpdateProfil>
    with TickerProviderStateMixin {
  late TabController tabController;
  bool updatingStarting = false;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomUniformScaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: PrimaryColors.white),
        title: Text(
          AllText.updateProfil,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: PrimaryColors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer2<AppAuthProvider, StepProvider>(
                builder: (context, appAuthProvider, stepProvider, _) {
              AppUser currentUser = appAuthProvider.currentAppUser!;
              return GestureDetector(
                onTap: () {
                  RegisterStream.registerUser(
                    projectId: currentUser.projet!.id,
                    otherImages: stepProvider
                          .selectedImages.values
                          .where((v) => v != null && isUrl(v)).map((e)=> e!).toList(),
                      basicData: {
                        "nom": '',
                        "prenom":
                            stepProvider.name?.trim() ?? currentUser.prenom,
                        "dateNais": DateFormat("yyyy-MM-dd").format(
                            stepProvider.birthDate ??
                                currentUser.dateNais ??
                                DateTime.now()),
                        "departement":
                            stepProvider.department ?? currentUser.departement,
                        "genre":
                            stepProvider.selectedGender?.symbol.toUpperCase() ??
                                currentUser.genre,
                        "parent": stepProvider.hasChildren == currentUser.parent
                            ? currentUser.parent
                            : stepProvider.hasChildren,
                        "searchGenre":
                            stepProvider.choosenGender?.symbol.toUpperCase()
                      },
                      otherInfosData: {
                        "centreInterets": stepProvider.selectedInterest,
                        "personnalites": stepProvider.selectedTraits
                      },
                      insertPhotosData: List<File>.from(stepProvider
                          .selectedImages.values
                          .where((v) => v != null && !isUrl(v))
                          .map((e) => File(e!))),
                      projectInfosData: {
                        "categories":stepProvider.projectCat != null? [stepProvider.projectCat]: currentUser.projet?.categories.map((e)=> e).toList(),
                        "titre": stepProvider.projectTitle ??
                            currentUser.projet?.titre,
                        "description": stepProvider.projectCat ??
                            currentUser.projet?.description,
                        "lifeProject": stepProvider.selectedIfProject?.value ?? currentUser.projet?.lifeProject,
                        "detailsLifeProject": stepProvider.projectSpec ??
                            currentUser.projet?.detailsLifeProject,
                        "delay": stepProvider.projectTimes.value,
                        "canLeave": stepProvider.leaveAll.value
                      },
                      isFinished: (b, pic, appUser) async {
                        if (b) {
                          await FirebaseAuth.instance.currentUser
                              ?.updateProfile(
                                  displayName: stepProvider.name,
                                  photoURL: pic);
                          await FirebaseAuth.instance.currentUser?.reload();
                          kPopPage(context);
                        }
                      },
                      hasError: (err) {
                        RegisterStream.reinitStream();
                        showSnackbar(
                            context: context,
                            isError: true,
                            content: Text(
                              'Erreur',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: PrimaryColors.white),
                            ));
                        setState(() {
                          updatingStarting = false;
                        });
                      },
                      isStarted: (b) {
                        setState(
                          () {
                            updatingStarting = b;
                          },
                        );
                      });
                },
                child: updatingStarting? CupertinoActivityIndicator(
                  color: PrimaryColors.white,
                ): Text(
                  AllText.applyFr,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: PrimaryColors.white,
                      ),
                ),
              );
            }),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Consumer<AppAuthProvider>(
                builder: (context, authProvider, widgets) {
              return TabBar(
                  onTap: (value) {},
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: PrimaryColors.white,
                  controller: tabController,
                  indicatorWeight: 3.5,
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        AllText.update,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: tabController.index == 0
                                ? FontWeight.bold
                                : null,
                            color: tabController.index == 0
                                ? Color(0xfff5f5f5)
                                : PrimaryColors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        AllText.preview,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: tabController.index == 1
                                ? FontWeight.bold
                                : null,
                            color: tabController.index == 1
                                ? Color(0xfff5f5f5)
                                : PrimaryColors.white),
                      ),
                    ),
                  ]);
            }),
          ),
          Expanded(child:
              Consumer<AppAuthProvider>(builder: (context, appAuthProvider, _) {
            return TabBarView(controller: tabController, children: [
              UpdatePage(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: UserInfoCard(
                    user: appAuthProvider.currentAppUser!,
                    controller: null,
                    pageController: new PageController()),
              )
            ]);
          }))
        ],
      ),
    );
  }
}
