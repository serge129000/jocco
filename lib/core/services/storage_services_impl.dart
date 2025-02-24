import 'dart:io';

import 'package:hive/hive.dart';
import 'package:jocco/core/services/storage_service.dart';

class StorageServicesImpl implements StorageService {
  static String imageBoxName = 'img';
  @override
  Future<File?> getImageLoaclPath({required String imageUrl}) async {
    final box = await Hive.openBox(imageBoxName);
    String? imagePath = box.get(imageUrl);
    return imagePath == null ? null : File(imagePath);
  }

  @override
  void setImageNameAndPath(
      {required String imageUrl, required File image}) async {
    final box = await Hive.openBox(imageBoxName);
    await box.put(imageUrl, image.path);
  }
}
