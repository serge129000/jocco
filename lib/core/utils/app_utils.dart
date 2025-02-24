import 'package:flutter/material.dart';

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
