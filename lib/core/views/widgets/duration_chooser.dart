import 'package:flutter/material.dart';
import 'package:jocco/core/utils/step_utils.dart';

import '../../utils/color.dart';
import '../../utils/path.dart';
import '../../utils/screen.dart';

class DurationChooser extends StatefulWidget {
  final Function(ProjectTimes) onChanged;
  final bool isActivated;
  const DurationChooser({super.key, required this.onChanged, required this.isActivated});

  @override
  State<DurationChooser> createState() => _DurationChooserState();
}

class _DurationChooserState extends State<DurationChooser> {
  ProjectTimes choosenProjectTime = ProjectTimes.immediately;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isActivated) {
          showModalBottomSheet(
            backgroundColor: filledSelectedBorder,
            showDragHandle: true,
            context: context,
            builder: (context) {
              return Column(
                children: [
                  ...ProjectTimes.values.map((e) => ListTile(
                        onTap: () {
                          setState(() {
                            choosenProjectTime = e;
                          });
                          widget.onChanged(e);
                          kPopPage(context);
                        },
                        leading: Text(
                          e.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: inDeepGreenGrey),
                        ),
                      ))
                ],
              );
            }).then((v) {
          setState(() {});
        });
        }
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: 1 / 0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: filledSelectedBorder),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              choosenProjectTime.name,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: inDeepGreenGrey),
            ),
            Image.asset(
              kIconAssetPath(imageName: 'back_select.png'),
              width: 10,
              height: 10.12,
            )
          ],
        ),
      ),
    );
  }
}
