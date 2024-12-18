import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/test_data.dart';
import 'package:jocco/core/views/widgets/user_card_components.dart';

class HistoryComponentMatched extends StatelessWidget {
  const HistoryComponentMatched({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10
          ),
          child: Text(AllText.findHereMatched, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: PrimaryColors.white
          ),),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 20,
            spacing: 10,
            children: [
              ...matchedData.map((e)=> UserCardComponents(url: e['image'].toString(), userName: e['nom'].toString(), userAge: e['age'].toString(),))
            ],
          ),
        )
      ],
    );
  }
}