import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jocco/core/streams/user_stream.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/gender.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/utils/step_utils.dart';
import 'package:jocco/core/views/home/pages/home_components/filter_components/interest.dart';
import 'package:jocco/core/views/home/pages/home_components/filter_components/personnality.dart';
import 'package:jocco/core/views/home/pages/home_components/filter_components/select_project_life.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/button.dart';
import 'package:jocco/core/views/widgets/custom_uniform_scaffold.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return CustomUniformScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        kPopPage(context);
                      },
                      child: Text(
                        AllText.abort,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: PrimaryColors.white),
                      ),
                    ),
                    Text(
                      AllText.filtrProfil,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: PrimaryColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        kPopPage(context);
                      },
                      child: Consumer2<UserProvider, AppAuthProvider>(
                          builder: (context, userProvider, appProvider, _) {
                        final currentFilter =
                            appProvider.currentAppUser?.filtre;
                        return userProvider.onUpdatingFilterStatus ==
                                Status.loading
                            ? CupertinoActivityIndicator(
                                color: PrimaryColors.white,
                              )
                            : GestureDetector(
                                onTap: () async {
                                  await userProvider.updateFilter(data: {
                                    "genre":
                                        userProvider.filterData['gender'] ==
                                                null
                                            ? currentFilter?.genre
                                            : (userProvider.filterData['gender']
                                                    as Gender)
                                                .symbol,
                                    "distance":
                                        userProvider.filterData['distance'] ??
                                            currentFilter?.distance,
                                    "minAge":
                                        userProvider.filterData['ageMin'] ??
                                            currentFilter?.minAge,
                                    "maxAge":
                                        userProvider.filterData['ageMax'] ??
                                            currentFilter?.maxAge,
                                    "personnalites": userProvider
                                            .filterData['personnality'] ??
                                        currentFilter?.personnalites,
                                    "categories":
                                        userProvider.filterData['projectCat'] ??
                                            currentFilter?.categories,
                                    "centreInterets":
                                        userProvider.filterData['interests'] ??
                                            currentFilter?.centreInterets,
                                    "lauchProject": userProvider
                                                .filterData['projectTime'] ==
                                            null
                                        ? currentFilter?.lauchProject?.name
                                        : (userProvider
                                                    .filterData['projectTime']
                                                as ProjectTimes)
                                            .name,
                                    "filterDistance":
                                        userProvider.filterData['st'] ??
                                            currentFilter?.filterDistance
                                  });
                                  appProvider.me();
                                  UserStream().fetchUserPotentialMatching(null);
                                  kPopPage(context);
                                },
                                child: Text(
                                  AllText.finish,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: PrimaryColors.white),
                                ),
                              );
                      }),
                    )
                  ],
                ),
              ),
              Expanded(child: Consumer2<UserProvider, AppAuthProvider>(
                  builder: (context, userProvider, appAuthProvider, _) {
                final currentFilter = appAuthProvider.currentAppUser?.filtre;
                return ListView(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AllText.distance,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: PrimaryColors.white,
                                      fontWeight: FontWeight.w500)),
                          Text(
                              (double.tryParse(userProvider
                                              .filterData['distance']
                                              .toString()) ??
                                          currentFilter?.distance ??
                                          1)
                                      .floor()
                                      .toString() +
                                  ' ' +
                                  'Km',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: PrimaryColors.white,
                                      fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                      child: Slider.adaptive(
                          activeColor: PrimaryColors.white,
                          inactiveColor: filterInactiveColor,
                          min: 0.0,
                          max: 100,
                          value: double.tryParse(userProvider
                                  .filterData['distance']
                                  .toString()) ??
                              currentFilter?.distance ??
                              0,
                          onChanged: (value) {
                            userProvider.setDistance(distanceValue: value);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AllText.activateOrDesactivateDistance,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: PrimaryColors.white,
                                    fontWeight: FontWeight.w500),
                          ),
                          Switch.adaptive(
                              activeColor: PrimaryColors.white,
                              value: userProvider.filterData['st'] ??
                                  currentFilter?.filterDistance,
                              onChanged: (value) {
                                userProvider.setActivateOrDesactivate(
                                    st: value);
                              })
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AllText.age,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: PrimaryColors.white,
                                      fontWeight: FontWeight.w500)),
                          Text(
                              (double.tryParse(userProvider.filterData['ageMin']
                                              .toString()) ??
                                          currentFilter?.minAge.toDouble() ??
                                          0)
                                      .floor()
                                      .toString() +
                                  '-' +
                                  (double.tryParse(userProvider
                                              .filterData['ageMax']
                                              .toString()) ??
                                          currentFilter?.maxAge.toDouble() ??
                                          0)
                                      .floor()
                                      .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: PrimaryColors.white,
                                      fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    RangeSlider(
                        activeColor: PrimaryColors.white,
                        inactiveColor: filterInactiveColor,
                        min: 18,
                        max: 99,
                        values: RangeValues(
                            double.parse((userProvider.filterData['ageMin'] ??
                                    currentFilter?.minAge ??
                                    18)
                                .toString()),
                            double.parse((userProvider.filterData['ageMax'] ??
                                    currentFilter?.maxAge ??
                                    99)
                                .toString())),
                        onChanged: (value) {
                          userProvider.setAgeRange(
                              ageMin: value.start.floor(),
                              ageMax: value.end.floor());
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        color: filterTileBackground,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Text(
                                AllText.gender,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: PrimaryColors.white,
                                        fontWeight: FontWeight.w500),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      userProvider.filterData['gender'] == null
                                          ? Gender.fromSymbol(
                                                  currentFilter?.genre)
                                              .name
                                          : (userProvider.filterData['gender']
                                                  as Gender)
                                              .name,
                                      style:
                                          TextStyle(color: PrimaryColors.white),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: PrimaryColors.white,
                                  ),
                                ],
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: premiumBackGroundColor,
                                    showDragHandle: true,
                                    enableDrag: true,
                                    context: context,
                                    builder:
                                        (context) => StatefulBuilder(
                                                builder: (context, setState) {
                                              return Container(
                                                height: 365,
                                                width: 1 / 0,
                                                decoration: BoxDecoration(
                                                    //color: premiumBackGroundColor
                                                    ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      AllText.gender,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                              color:
                                                                  PrimaryColors
                                                                      .white),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    ...Gender.values
                                                        .map((e) => Column(
                                                              children: [
                                                                ListTile(
                                                                  onTap: () {
                                                                    userProvider
                                                                        .setGender(
                                                                            gender:
                                                                                e);
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  tileColor: Color(
                                                                      0xff003333),
                                                                  leading: Text(
                                                                    e.name,
                                                                    style: TextStyle(
                                                                        color: PrimaryColors
                                                                            .white),
                                                                  ),
                                                                  trailing: (userProvider.filterData['gender'] ??
                                                                              Gender.fromSymbol(currentFilter?.genre)) ==
                                                                          e
                                                                      ? Icon(
                                                                          Icons
                                                                              .check,
                                                                          color:
                                                                              PrimaryColors.white,
                                                                        )
                                                                      : SizedBox(),
                                                                ),
                                                                Divider(
                                                                  color: Colors
                                                                      .transparent,
                                                                  thickness: 3,
                                                                ),
                                                              ],
                                                            )),
                                                    Expanded(
                                                        child: Center(
                                                            child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20),
                                                      child: Btn(
                                                          function: () {
                                                            kPopPage(context);
                                                          },
                                                          child: Text(
                                                            AllText.applyFr,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    PrimaryColors
                                                                        .first),
                                                          ),
                                                          isTransparent: false),
                                                    )))
                                                  ],
                                                ),
                                              );
                                            }));
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                color: dividerColor,
                                thickness: 3,
                              ),
                            ),
                            ListTile(
                              leading: Text(
                                AllText.catProject,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: PrimaryColors.white,
                                        fontWeight: FontWeight.w500),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: PrimaryColors.white,
                              ),
                              onTap: () {
                                kPushToPage(context, page: SelectProjectLife());
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                color: dividerColor,
                                thickness: 3,
                              ),
                            ),
                            ListTile(
                              leading: Text(
                                AllText.interestCat,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: PrimaryColors.white,
                                        fontWeight: FontWeight.w500),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: PrimaryColors.white,
                              ),
                              onTap: () {
                                kPushToPage(context, page: Interest());
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                color: dividerColor,
                                thickness: 3,
                              ),
                            ),
                            ListTile(
                              leading: Text(
                                AllText.personalityType,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: PrimaryColors.white,
                                        fontWeight: FontWeight.w500),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: PrimaryColors.white,
                              ),
                              onTap: () {
                                kPushToPage(context, page: Personnality());
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                color: dividerColor,
                                thickness: 3,
                              ),
                            ),
                            ListTile(
                              leading: Text(
                                AllText.projectTimeDebut,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: PrimaryColors.white,
                                        fontWeight: FontWeight.w500),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      userProvider.filterData['projectTime'] ==
                                              null
                                          ? currentFilter?.lauchProject?.name ??
                                              ''
                                          : (userProvider
                                                      .filterData['projectTime']
                                                  as ProjectTimes)
                                              .name,
                                      style:
                                          TextStyle(color: PrimaryColors.white),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: PrimaryColors.white,
                                  ),
                                ],
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: premiumBackGroundColor,
                                    showDragHandle: true,
                                    enableDrag: true,
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                            builder: (context, setState) {
                                          return Container(
                                            height: 365,
                                            width: 1 / 0,
                                            decoration: BoxDecoration(
                                                //color: premiumBackGroundColor
                                                ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  AllText.projectTimeDebut,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: PrimaryColors
                                                              .white),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ...ProjectTimes.values
                                                    .map((e) => Column(
                                                          children: [
                                                            ListTile(
                                                              onTap: () {
                                                                userProvider
                                                                    .setProjectTimes(
                                                                        projectTime:
                                                                            e);
                                                                setState(() {});
                                                              },
                                                              tileColor: Color(
                                                                  0xff003333),
                                                              leading: Text(
                                                                e.name,
                                                                style: TextStyle(
                                                                    color: PrimaryColors
                                                                        .white),
                                                              ),
                                                              trailing: (userProvider.filterData[
                                                                              'projectTime'] ??
                                                                          currentFilter
                                                                              ?.lauchProject) ==
                                                                      e
                                                                  ? Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: PrimaryColors
                                                                          .white,
                                                                    )
                                                                  : SizedBox(),
                                                            ),
                                                            Divider(
                                                              color: Colors
                                                                  .transparent,
                                                              thickness: 3,
                                                            ),
                                                          ],
                                                        )),
                                                Expanded(
                                                    child: Center(
                                                        child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  child: Btn(
                                                      function: () {
                                                        kPopPage(context);
                                                      },
                                                      child: Text(
                                                        AllText.applyFr,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: PrimaryColors
                                                                .first),
                                                      ),
                                                      isTransparent: false),
                                                )))
                                              ],
                                            ),
                                          );
                                        }));
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                    /* ListTile(
                      title: Text(AllText.gender,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: PrimaryColors.white,
                                  fontWeight: FontWeight.w500)),
                    ) */
                  ],
                );
              }))
            ],
          ),
        ),
      ),
    );
  }
}
