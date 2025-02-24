import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jocco/core/views/providers/storage_provider.dart';
import 'package:provider/provider.dart';

class ImageLoaderCached extends StatefulWidget {
  final String imageUrl;
  final BoxFit? boxFit;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  const ImageLoaderCached(
      {super.key, required this.imageUrl, this.boxFit, this.errorBuilder});

  @override
  State<ImageLoaderCached> createState() => _ImageLoaderCachedState();
}

class _ImageLoaderCachedState extends State<ImageLoaderCached> {
  late StorageProvider storageProvider;
  bool isLoading = true;
  bool isError = false;
  File? loadedFile;
  @override
  void initState() {
    storageProvider = context.read<StorageProvider>();
    Future.delayed(Duration.zero, () {
      storageProvider.loadOrSetImageToCache(
          imageUrl: widget.imageUrl,
          onFinishing: (imageFile) {
            isLoading = false;
            loadedFile = imageFile!;
            isError = false;
            setState(() {});
          },
          onError: (err) {
            isLoading = false;
            isError = true;
            setState(() {});
          });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(loadedFile);
    return Container(
      height: 1 / 0,
      width: 1 / 0,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Builder(builder: (context) {
        if (isLoading) {
          return CupertinoActivityIndicator(
            color: Colors.white,
          );
        }
        if (!isError && loadedFile != null) {
          return Image.file(
            loadedFile!,
            fit: widget.boxFit,
            errorBuilder: widget.errorBuilder,
          );
        }
        return SizedBox();
      }),
    );
  }
}
