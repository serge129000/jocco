import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/country_list.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/models/country.dart';

class CustomPhonePicker extends StatefulWidget {
  final Function(Country?) onChanged;
  const CustomPhonePicker({super.key, required this.onChanged});

  @override
  State<CustomPhonePicker> createState() => _CustomPhonePickerState();
}

class _CustomPhonePickerState extends State<CustomPhonePicker> {
  late List<Country> allCountry;
  late Country selectedCountry;
  @override
  void initState() {
    allCountry = Countries.countryList.map((e) => Country.fromJson(e)).toList();
    selectedCountry = allCountry
        .where((e) => e.name!.toLowerCase().contains('france'))
        .single;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            showDragHandle: true,
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return ListView.builder(
                    itemCount: allCountry.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          widget.onChanged(allCountry[index]);
                          setState(() {
                            selectedCountry = allCountry[index];
                          });
                          kPopPage(context);
                        },
                        leading: Text(allCountry[index].dialCode ?? ''),
                        title: Text(
                          allCountry[index].name ?? '',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      );
                    });
              });
            }).then((v) {
          setState(() {});
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 48,
        width: 110.57,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                selectedCountry.dialCode ?? 'U',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Image.asset(
                kIconAssetPath(imageName: 'dropdown.png'),
                height: 6.64,
                width: 10.39,
              )
            ],
          ),
        ),
      ),
    );
  }
}
