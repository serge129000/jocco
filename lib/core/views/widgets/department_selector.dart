import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/country_json.dart';
import 'package:jocco/core/utils/path.dart';

import '../../utils/screen.dart';

class DepartmentSelector extends StatefulWidget {
  final String? countryName;
  final Function(String) onChanged;
  const DepartmentSelector(
      {super.key, this.countryName, required this.onChanged});

  @override
  State<DepartmentSelector> createState() => _DepartmentSelectorState();
}

class _DepartmentSelectorState extends State<DepartmentSelector> {
  late List departmentData;
  String? selectedDepartment;
  @override
  void initState() {
    initRequiredData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.countryName);
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: filledSelectedBorder,
            showDragHandle: true,
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return ListView.builder(
                    itemCount: (departmentData.single['state']).length,
                    itemBuilder: (context, index) {
                      final stateList = (departmentData.single['state']);
                      return ListTile(
                        onTap: () {
                          setState(() {
                            selectedDepartment = stateList[index]['name'];
                          });
                          kPopPage(context);
                        },
                        leading: Text(
                          stateList[index]['name'] ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: inDeepGreenGrey),
                        ),
                      );
                    });
              });
            }).then((v) {
          setState(() {});
        });
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
              selectedDepartment ?? 'Selectionner',
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

  void initRequiredData() async {
    departmentData = await CountryJson.getcountryData();
    departmentData = departmentData
        .where((e) =>
            e['name']!.toLowerCase().contains(widget.countryName?.toLowerCase() ?? 'france'))
        .toList();
    setState(() {});
  }
}
