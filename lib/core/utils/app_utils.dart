import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jocco/core/models/chat.dart';

import '../views/widgets/button.dart';
import 'color.dart';
import 'screen.dart';

Widget errorDialog({required BuildContext context, required String err}) =>
    StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: PrimaryColors.first,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              err,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: PrimaryColors.white, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Btn(
                  isTransparent: false,
                  function: () {
                    kPopPage(context);
                  },
                  child: Text(
                    'Ok',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: PrimaryColors.first,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
            )
          ],
        ),
      );
    });

Widget showListDialog(
        {required BuildContext context, required List<String> data}) =>
    StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        actions: [
          Btn(
              isTransparent: false,
              function: () {
                kPopPage(context);
              },
              child: Text(
                'Fermer',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: PrimaryColors.first,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        ],
        title: Row(
          children: [
            Text(
              "Exemples de projets",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: PrimaryColors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: PrimaryColors.first,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...data.map((e) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      color: PrimaryColors.white,
                      size: 3,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          e,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: PrimaryColors.white, fontSize: 15),
                        ),
                      ),
                    )
                  ],
                )),

            /* Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Btn(
                    isTransparent: false,
                    function: () {
                      kPopPage(context);
                    },
                    child: Text(
                      'Ok',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                              color: PrimaryColors.first,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                    )),
              ) */
          ],
        ),
      );
    });

String getAgeFromBirthDate({required DateTime birthDate}) =>
    (DateTime.now().year - birthDate.year).toString();

String showDay(DateTime date) {
  DateTime aujourdHui = DateTime.now();
  DateTime hier = aujourdHui.subtract(Duration(days: 1));
  DateTime avantHier = aujourdHui.subtract(Duration(days: 2));

  if (date.year == aujourdHui.year &&
      date.month == aujourdHui.month &&
      date.day == aujourdHui.day) {
    return 'Aujourd\'hui';
  } else if (date.year == hier.year &&
      date.month == hier.month &&
      date.day == hier.day) {
    return 'Hier';
  } else if (date.year == avantHier.year &&
      date.month == avantHier.month &&
      date.day == avantHier.day) {
    return 'Avant-hier';
  } else {
    return DateFormat('dd MMMM yyyy', 'fr_FR').format(date);
  }
}

Map<DateTime, List<Chat>> sortMessagesByDate(List<Chat> messages) {
  Map<DateTime, List<Chat>> resultat = {};

  for (var message in messages) {
    DateTime date = message.time.toDate().toLocal();
    if (resultat.containsKey(date.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0))) {
      resultat[date.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0)]!.add(message);
    } else {
      resultat[date.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0)] = [message];
    }
  }

  return resultat;
}