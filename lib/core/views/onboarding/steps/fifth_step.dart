import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/app_utils.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/list_utils.dart';
import '../../../utils/step_utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/button.dart';

class FifthStep extends StatefulWidget {
  final bool hasNotSizedBox;
  const FifthStep({super.key, this.hasNotSizedBox = false});

  @override
  State<FifthStep> createState() => _FifthStepState();
}

class _FifthStepState extends State<FifthStep> {
  FocusNode anotherPFocus = FocusNode();
  String? anotherProject;
  String? selectedProjectIcon;
  @override
  void initState() {
    if (Provider.of<StepProvider>(context, listen: false).projectCat == null) {
      Future.delayed(Duration.zero, () {
        Provider.of<StepProvider>(context, listen: false).addProjectCat(category: Provider.of<AppAuthProvider>(context, listen: false).currentAppUser!.projet!.description);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StepProvider>(builder: (context, stepProvider, widgets) {
      return Padding(
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
                  AllText.projectCategory,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      height: 0,
                      fontWeight: FontWeight.w600,
                      color: PrimaryColors.white),
                ),
              ),
              LayoutBuilder(builder: (context, constraint) {
                return Center(
                  child: Wrap(
                    runAlignment: WrapAlignment.spaceBetween,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ...categories.map((e) => GestureDetector(
                            onTap: () {
                              stepProvider.addProjectCat(category: e['title']!);
                              selectedProjectIcon = e['icon'];
                              setState(() {});
                              if (e['icon'] == null) {
                                anotherPFocus.requestFocus();
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(),
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: size(context: context).height /
                                            2.15,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 48,
                                              child: TextFormField(
                                                onChanged: (value) {
                                                  setState(() {
                                                    anotherProject = value;
                                                  });
                                                },
                                                onFieldSubmitted: (value) {
                                                  kPopPage(context);
                                                },
                                                focusNode: anotherPFocus,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                        color: PrimaryColors
                                                            .black),
                                                cursorColor: greyColor,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  border: InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15,
                                                          vertical: 5),
                                                  hintText:
                                                      AllText.describeProject,
                                                  hintStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                          color: greyColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).then((v) {
                                  setState(() {});
                                });
                                /* showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          height: size(context: context).height /4,
                                          child: TextField()),
                                      );
                                    }); */
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  height: 134,
                                  width: (constraint.maxWidth - 30) / 3,
                                  decoration: BoxDecoration(
                                      color:
                                          stepProvider.projectCat == e['title']
                                              ? selectedBorderColor
                                              : filledSelectedBorder,
                                      border: Border.all(
                                          color: stepProvider.projectCat ==
                                                  e['title']
                                              ? selectedColor
                                              : borderColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      if (e['icon'] != null)
                                        Image.asset(
                                          kIconAssetPath(imageName: e['icon']!),
                                          height: 54,
                                          width: 54,
                                        ),
                                      Text(
                                        e['icon'] == null &&
                                                anotherProject != null
                                            ? anotherProject!
                                            : e['title'] ?? '',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                fontSize: 11,
                                                color: PrimaryColors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                    top: 5,
                                    right: 5,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                showListDialog(
                                                    context: context,
                                                    data: e['examples']));
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: PrimaryColors.white,
                                      ),
                                    ))
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              }),
              //if (isKeyBoardActivated(context: context))
              /* Visibility(
                  visible: isKeyBoardActivated(context: context),
                  child: TextField(
                    focusNode: anotherPFocus,
                  ),
                ), */
              if (!widget.hasNotSizedBox)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Btn(
                    function: () {
                      if (stepProvider.projectCat == null) {
                        showSnackbar(
                            context: context,
                            isError: true,
                            content: Text(
                              'Choisissez une categorie',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: PrimaryColors.white),
                            ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => confirmCategoryWidget(
                                context: context,
                                projectIcon: selectedProjectIcon,
                                anotherProject: anotherProject,
                                projectTitle: stepProvider.projectCat ?? ''));
                      }
                    },
                    isTransparent: false,
                    anotherColor: PrimaryColors.white,
                    child: Text(
                      !widget.hasNotSizedBox ? AllText.next : 'Continuer',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: PrimaryColors.first,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
            ],
          ),
        ),
      );
    });
  }
}

Widget confirmCategoryWidget(
        {required String? projectIcon,
        required String projectTitle,
        String? anotherProject,
        required BuildContext context}) =>
    AlertDialog(
      backgroundColor: PrimaryColors.first,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Confirmation',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: PrimaryColors.white, fontWeight: FontWeight.bold),
          ),
          if (projectIcon != null)
            Image.asset(
              kIconAssetPath(imageName: projectIcon),
              height: 162,
              width: 162,
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              projectTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: PrimaryColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Confirmez-vous la sélection de la catgorie $projectTitle ?',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: PrimaryColors.white, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset(
              kIconAssetPath(imageName: 'info.png'),
              height: 62,
              width: 62,
            ),
          ),
          Text(
            'Ce choix déterminera la categorie des profils avec lesquels vous pourrez matcher, il ne sera possible de la changer qu’aprés 10 jours d’utilisation',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: PrimaryColors.white, fontSize: 16),
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
                          context.read<StepProvider>().nextStep();
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
            ),
          )
        ],
      ),
    );
