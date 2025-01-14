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
              Text(err,
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
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                              color: PrimaryColors.first,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                    )),
              )
            ],
          ),
        );
      });