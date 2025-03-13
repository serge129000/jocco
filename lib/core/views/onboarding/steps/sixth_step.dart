import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jocco/core/streams/register_stream.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/list_utils.dart';
import 'package:jocco/core/utils/step_utils.dart';
import 'package:jocco/core/views/home/root.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:jocco/core/views/widgets/asynchronous_loader.dart';
import 'package:jocco/core/views/widgets/custom_textfield.dart';
import 'package:jocco/core/views/widgets/duration_chooser.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/screen.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/button.dart';

class SixthStep extends StatefulWidget {
  final bool hasNotSizedBox;
  const SixthStep({super.key, this.hasNotSizedBox = false});

  @override
  State<SixthStep> createState() => _SixthStepState();
}

class _SixthStepState extends State<SixthStep> {
  bool hasNotProjectAndAccepted = false;
  final formkey = GlobalKey<FormState>();
  String projectTitle = '';
  String projectSpec = '';
  String delay = '';
  bool registerStarting = false;
  bool isConfirmed = false;
  @override
  void dispose() {
    RegisterStream.registerStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<StepProvider, AppAuthProvider>(
        builder: (context, stepProvider, appAuthProvider, _) {
      return Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.hasNotSizedBox)
                  const SizedBox(
                    height: 110,
                  ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackWidget(
                    onCondtion: () {
                      if (Provider.of<StepProvider>(context, listen: false)
                              .currentStep !=
                          StepJ.first) {
                        Provider.of<StepProvider>(context, listen: false)
                            .backStep();
                      } else {
                        kPopPage(context);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    AllText.hasProject,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        height: 0,
                        fontWeight: FontWeight.w600,
                        color: PrimaryColors.white),
                  ),
                ),
                Row(
                  children: [
                    ...IfProject.values.map((e) => Row(
                          children: [
                            Radio<IfProject>(
                                activeColor: PrimaryColors.white,
                                fillColor: const WidgetStatePropertyAll(
                                    PrimaryColors.white),
                                value: stepProvider.selectedIfProject ??
                                    IfProject.yes,
                                groupValue: e,
                                onChanged: (v) {
                                  stepProvider.setSelectedIfProjet(
                                      ifProject: e);
                                }),
                            Text(
                              e.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: PrimaryColors.white),
                            )
                          ],
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Text(AllText.titleProject,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          height: 0,
                          fontWeight: FontWeight.w600,
                          color: PrimaryColors.white)),
                ),
                CustomTextfield(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Saisissez le titre de votre projet";
                    }
                    return null;
                  },
                  onChanged: (p0) {
                    projectTitle = p0;
                    stepProvider.setProjectTitle(title: p0);
                  },
                  isActivate: stepProvider.selectedIfProject?.value ?? true,
                  hasGreenColor: true,
                  hintText: 'Saisir le titre de votre projet',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    AllText.specifyTitleProject,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        height: 0,
                        fontWeight: FontWeight.w600,
                        color: PrimaryColors.white),
                  ),
                ),
                CustomTextfield(
                  onChanged: (p0) {
                    projectSpec = p0;
                    stepProvider.setProjectSpec(spec: p0);
                  },
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Specifiez votre projet";
                    }
                    return null;
                  },
                  isActivate: stepProvider.selectedIfProject?.value ?? true,
                  hasGreenColor: true,
                  hintText: 'Ex : Ouvrir un hôtel écologique en montagne',
                ),
                if (!(stepProvider.projectCat == categories[0]['title'] ||
                    stepProvider.projectCat == categories[1]['title']))
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(AllText.projectTimes,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            height: 0,
                            fontWeight: FontWeight.w600,
                            color: PrimaryColors.white)),
                  ),
                if (!(stepProvider.projectCat == categories[0]['title'] ||
                    stepProvider.projectCat == categories[1]['title']))
                  DurationChooser(
                    isActivated: stepProvider.selectedIfProject?.value ?? true,
                    onChanged: (p0) {
                      stepProvider.setProjectTimes(times: p0);
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    AllText.leaveAll,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        height: 0,
                        fontWeight: FontWeight.w600,
                        color: PrimaryColors.white),
                  ),
                ),
                Row(
                  children: [
                    ...LeaveAll.values.map((e) => Row(
                          children: [
                            Radio<LeaveAll>(
                                activeColor: PrimaryColors.white,
                                fillColor: const WidgetStatePropertyAll(
                                    PrimaryColors.white),
                                value: stepProvider.leaveAll,
                                groupValue: e,
                                onChanged: (v) {
                                  stepProvider.setSelectedLeavingAll(
                                      leaveAlls: e);
                                }),
                            Text(
                              e.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: PrimaryColors.white),
                            )
                          ],
                        ))
                  ],
                ),
                if (!widget.hasNotSizedBox)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: !registerStarting
                        ? Btn(
                            function: () {
                              if (!(stepProvider.selectedIfProject?.value ??
                                  true)) {
                                showDialog(
                                    context: context,
                                    builder: (context) => confirmFinalProject(
                                        context: context)).then((v) {
                                  if (isConfirmed) {
                                    registerUser(stepProvider, appAuthProvider);
                                  }
                                });
                              } else {
                                formkey.currentState!.validate()
                                    ? showDialog(
                                        context: context,
                                        builder: (context) =>
                                            confirmFinalProject(
                                                context: context)).then((v) {
                                        if (isConfirmed) {
                                          registerUser(
                                              stepProvider, appAuthProvider);
                                        }
                                      })
                                    : null;
                              }
                            },
                            isTransparent: false,
                            anotherColor: PrimaryColors.white,
                            child: Text(
                              AllText.next,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: PrimaryColors.first,
                                      fontWeight: FontWeight.w600),
                            ),
                          )
                        : StreamBuilder<Map<String, dynamic>>(
                            stream: RegisterStream
                                .registerStreamController.stream
                                .asBroadcastStream(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: 1 / 0,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: AsynchronousLoader(
                                      stepMessage: snapshot.data?['message'],
                                      debut: snapshot.data?['debut'] ?? 0.0,
                                      finish: snapshot.data?['fin'] ?? 0.0),
                                );
                              }
                              return SizedBox();
                            }),
                  )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget confirmFinalProject({required BuildContext context}) =>
      StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          backgroundColor: PrimaryColors.first,
          content:
              Consumer<StepProvider>(builder: (context, stepProvider, widgets) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  !stepProvider.selectedIfProject!.value
                      ? 'Vous n\'avez pas de projet spécifique. Toutefois, veuillez confirmer votre engagement à respecter le projet des personnes dans la catégorie choisie.'
                      : 'Pour respecter votre motivation liée à votre projet de vie dans cette catégories sélectionnée, veuillez confirmer votre engagement ci dessous ',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: PrimaryColors.white, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Checkbox.adaptive(
                        fillColor:
                            const WidgetStatePropertyAll(PrimaryColors.first),
                        focusColor: PrimaryColors.first,
                        activeColor: PrimaryColors.first,
                        side: const BorderSide(color: PrimaryColors.white),
                        value: hasNotProjectAndAccepted,
                        onChanged: (v) {
                          setState(() {
                            hasNotProjectAndAccepted =
                                !hasNotProjectAndAccepted;
                          });
                        }),
                    Expanded(
                      child: Text(
                        'Je m\'engage à respecter mon projet dans cette catégorie.',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 14,
                            color: PrimaryColors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
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
                                  setState(() {
                                    isConfirmed = false;
                                  });
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
                                  setState(() {
                                    isConfirmed = true;
                                  });
                                  kPopPage(context);
                                },
                                child: Text(
                                  'Confirmer',
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
            );
          }),
        );
      });

  void registerUser(
          StepProvider stepProvider, AppAuthProvider appAuthProvider) =>
      RegisterStream.registerUser(
          basicData: {
            "nom": '',
            "prenom": stepProvider.name?.trim(),
            "dateNais":
                DateFormat("yyyy-MM-dd").format(stepProvider.birthDate!),
            "departement": stepProvider.department,
            "genre": stepProvider.selectedGender?.symbol.toUpperCase(),
            "parent": stepProvider.hasChildren,
            "searchGenre": stepProvider.choosenGender?.symbol.toUpperCase()
          },
          otherInfosData: {
            "centreInterets": stepProvider.selectedInterest,
            "personnalites": stepProvider.selectedTraits
          },
          insertPhotosData: List<File>.from(stepProvider.selectedImages.values
              .where((v) => v != null)
              .map((e) => File(e!))),
          projectInfosData: {
            "categories": [stepProvider.projectCat],
            "titre": projectTitle,
            "description": stepProvider.projectCat,
            "lifeProject": stepProvider.selectedIfProject?.value,
            "detailsLifeProject": projectSpec,
            "delay": stepProvider.projectTimes.value,
            "canLeave": stepProvider.leaveAll.value
          },
          isFinished: (b, pic, appUser) async {
            if (b) {
              RegisterStream.reinitStream();
              await appAuthProvider.me();
              await FirebaseAuth.instance.currentUser?.updateProfile(
                  displayName: stepProvider.name, photoURL: pic);
              await FirebaseAuth.instance.currentUser?.reload();
              kPushAndRemoveUntil(context, page: Root());
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
              registerStarting = false;
            });
          },
          isStarted: (b) {
            setState(
              () {
                registerStarting = b;
              },
            );
          });
}
