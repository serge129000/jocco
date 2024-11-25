import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/providers/step_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/list_utils.dart';
import '../../../utils/step_utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/button.dart';

class FifthStep extends StatefulWidget {
  const FifthStep({super.key});

  @override
  State<FifthStep> createState() => _FifthStepState();
}

class _FifthStepState extends State<FifthStep> {
  FocusNode anotherPFocus = FocusNode();
  String? anotherProject;
  @override
  Widget build(BuildContext context) {
    return Consumer<StepProvider>(builder: (context, stepProvider, widgets) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  Provider.of<StepProvider>(context, listen: false).backStep();
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
                                                        color: PrimaryColors.black),
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
                                       e['icon'] == null && anotherProject != null? anotherProject!: e['title'] ?? '',
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
                                const Positioned(
                                    top: 5,
                                    right: 5,
                                    child: Icon(
                                      Icons.add,
                                      color: PrimaryColors.white,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Btn(
                  function: () {
                    context.read<StepProvider>().nextStep();
                  },
                  isTransparent: false,
                  anotherColor: PrimaryColors.white,
                  child: Text(
                    AllText.next,
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
