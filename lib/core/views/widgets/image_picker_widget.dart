import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/views/widgets/custom_image_shower.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(String?) onImageChanged;
  final String? firstOnlineImage;
  const ImagePickerWidget(
      {super.key, required this.onImageChanged, this.firstOnlineImage});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String? imagePath;
  String? firstOnlineImageGot;
  @override
  void initState() {
    firstOnlineImageGot = widget.firstOnlineImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            ImagePicker()
                .pickImage(source: ImageSource.gallery)
                .then((imgPath) {
              imagePath = imgPath?.path;
              setState(() {});
              widget.onImageChanged(imgPath?.path);
            });
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: 137.97,
            width: 109.62,
            decoration: BoxDecoration(
                image: imagePath == null
                    ? null
                    : DecorationImage(
                        image: FileImage(File(imagePath!)), fit: BoxFit.cover),
                color: PrimaryColors.first,
                border: Border.all(width: 1.5, color: pickerBorder),
                borderRadius: BorderRadius.circular(10)),
            child: imagePath == null
                ? firstOnlineImageGot != null
                    ? CustomImageShower(url: firstOnlineImageGot): Center(
                    child: Image.asset(
                        height: 30.88,
                        width: 30.88,
                        kIconAssetPath(imageName: 'img_placeholder.png')),
                  )
                    : null,
          ),
        ),
        Positioned(
            bottom: imagePath == null ? 8 : null,
            right: imagePath == null ? 8 : -5,
            top: imagePath == null ? null : 0,
            child: GestureDetector(
              onTap: () {
                if (imagePath != null) {
                  imagePath = null;
                  setState(() {});
                  widget.onImageChanged(imagePath);
                }
              },
              child: Container(
                height: 16,
                width: 16,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: PrimaryColors.white),
                child: Center(
                  child: Icon(
                    imagePath == null ? Icons.add : Icons.close,
                    color: PrimaryColors.first,
                    size: 10,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
