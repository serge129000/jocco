import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
                      child: Text(
                        AllText.finish,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: PrimaryColors.white),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(child: Consumer<UserProvider>(
                  builder: (context, userProvider, widgets) {
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
                                          0)
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
                      child: Slider(
                          activeColor: PrimaryColors.white,
                          inactiveColor: filterInactiveColor,
                          min: 0.0,
                          max: 100,
                          value: double.tryParse(userProvider
                                  .filterData['distance']
                                  .toString()) ??
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
                              value: userProvider.filterData['st'] ?? false,
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
                                          0)
                                      .floor()
                                      .toString() +
                                  '-' +
                                  (double.tryParse(userProvider
                                              .filterData['ageMax']
                                              .toString()) ??
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
                        max: 90,
                        values: RangeValues(
                            double.parse(
                                (userProvider.filterData['ageMin'] ?? 18)
                                    .toString()),
                            double.parse(
                                (userProvider.filterData['ageMax'] ?? 90)
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
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: PrimaryColors.white,
                              ),
                            ),
                            Divider(
                              color: filterInactiveColor,
                              thickness: 5,
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
                            ),
                            Divider(
                              color: filterInactiveColor,
                              thickness: 5,
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
                            ),
                            Divider(
                              color: filterInactiveColor,
                              thickness: 5,
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
                            ),
                            Divider(
                              color: filterInactiveColor,
                              thickness: 5,
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
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: PrimaryColors.white,
                              ),
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
