import 'package:flutter/material.dart';

import '../../../widgets/image_picker_widget.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 20
      ),
      children: [
        SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  runSpacing: 10,
                  spacing: 7,
                  children: [
                    ...List<int>.generate(6, (i) => i)
                        .map((e) => ImagePickerWidget(
                              onImageChanged: (value) {
                                if (value == null) {
                                } else {
                                }
                              },
                            ))
                  ],
                ),
              ),
      ],
    );
  }
}