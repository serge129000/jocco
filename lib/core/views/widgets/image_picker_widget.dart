import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jocco/core/utils/app_utils.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/views/widgets/custom_image_shower.dart';

class ImagePickerWidget extends StatefulWidget {
  // le path ou l'url de l'iamge plus si c'est oui ou non le profil de base true si c'est le cas
  final Function(String?, bool) onImageChanged;
  final Function(String?, bool)? onOnlineImageDeleted;
  final String? firstOnlineImage;
  const ImagePickerWidget(
      {super.key,
      required this.onImageChanged,
      this.firstOnlineImage,
      this.onOnlineImageDeleted});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String? imagePath;
  String? firstImageGot;
  @override
  void initState() {
    firstImageGot = widget.firstOnlineImage;
    if (firstImageGot != null) {
      Future.delayed(Duration.zero, () {
        widget.onImageChanged(firstImageGot, true);
      });
    }
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
              if (widget.onOnlineImageDeleted != null &&
                  firstImageGot != null &&
                  imgPath != null) {
                firstImageGot = null;
                setState(() {});
                widget.onOnlineImageDeleted!(firstImageGot, true);
              }
              widget.onImageChanged(imgPath?.path, false);
            });
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: 137.97,
            width: 109.62,
            decoration: BoxDecoration(
                image: imagePath == null
                    ? firstImageGot != null && !isUrl(firstImageGot!)
                        ? DecorationImage(
                            image: FileImage(File(firstImageGot!)),
                            fit: BoxFit.cover)
                        : null
                    : DecorationImage(
                        image: FileImage(File(imagePath!)), fit: BoxFit.cover),
                color: PrimaryColors.first,
                border: Border.all(width: 1.5, color: pickerBorder),
                borderRadius: BorderRadius.circular(10)),
            child: imagePath == null
                ? firstImageGot != null
                    ? isUrl(firstImageGot!)
                        ? CustomImageShower(
                            url: firstImageGot,
                            radius: 8,
                          )
                        : SizedBox()
                    : Center(
                        child: Image.asset(
                            height: 30.88,
                            width: 30.88,
                            kIconAssetPath(imageName: 'img_placeholder.png')),
                      )
                : null,
          ),
        ),
        Positioned(
            bottom: imagePath == null
                ? firstImageGot == null
                    ? 8
                    : null
                : null,
            right: imagePath == null
                ? firstImageGot == null
                    ? 8
                    : -5
                : -5,
            top: imagePath == null
                ? firstImageGot == null
                    ? null
                    : null
                : 0,
            child: GestureDetector(
              onTap: () {
                if (imagePath != null) {
                  imagePath = null;
                  setState(() {});
                  widget.onImageChanged(imagePath, false);
                }
                if (imagePath == null) {
                  if (firstImageGot != null) {
                    firstImageGot = null;
                    widget.onImageChanged(firstImageGot, true);
                    setState(() {});
                  }
                }
              },
              child: Container(
                height: 16,
                width: 16,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: PrimaryColors.white),
                child: Center(
                  child: Icon(
                    imagePath == null
                        ? firstImageGot == null
                            ? Icons.add
                            : Icons.close
                        : Icons.close,
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
