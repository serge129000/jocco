import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/screen.dart';


class DatePickerWidget extends StatelessWidget {
  final void Function(DateTime, List<int>)? onChange;
  final String dateFormat;
  const DatePickerWidget(
      {super.key, required this.onChange, required this.dateFormat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DatePicker.showDatePicker(context,
            pickerTheme: DateTimePickerTheme(
                confirmTextStyle: Theme.of(context).textTheme.labelSmall,
                cancelTextStyle: Theme.of(context).textTheme.labelSmall,
                itemTextStyle: Theme.of(context).textTheme.labelSmall,
                backgroundColor: PrimaryColors.white),
            onChange: onChange,
            onConfirm: onChange,
            locale: DateTimePickerLocale.fr,
            dateFormat: "dd/MMMM/yyyy");
      },
      child: Container(
        alignment: Alignment.centerLeft,
        width: size(context: context).width / 2.28,
        height: 50,
        decoration: BoxDecoration(
            color: filledSelectedBorder,
            borderRadius: BorderRadius.circular(8),
            /* border: Border.all(color: borderColor) */),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Image.asset(kIconAssetPath(imageName: 'calendar.png'), width: 21, height: 22.5, color: inDeepGreenGrey,),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10
                        ),
                        child: Text(
                          dateFormat.isEmpty ? 'JJ/MM/AAAA': dateFormat,
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: inDeepGreenGrey
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
