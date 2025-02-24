import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:jocco/core/services/storage_services_impl.dart';
import 'package:jocco/core/services/user_services_impl.dart';

class StorageProvider with ChangeNotifier {
  StorageServicesImpl storageServicesImpl = StorageServicesImpl();
  Map<String, File?> _imagesLoad = {};
  Map<String, File?> get imagesLoad => _imagesLoad;

  void loadOrSetImageToCache(
      {required String imageUrl,
      required Function(File?) onFinishing,
      required Function(Exception _) onError}) async {
    try {
      if (await storageServicesImpl.getImageLoaclPath(imageUrl: imageUrl) == null) {
        final imageFile =
            await UserServicesImpl().addImageToCache(imageUrl: imageUrl);
        storageServicesImpl.setImageNameAndPath(
            imageUrl: imageUrl, image: imageFile);
        _imagesLoad[imageUrl] = imageFile;
      } else {
        _imagesLoad[imageUrl] = await
            storageServicesImpl.getImageLoaclPath(imageUrl: imageUrl);
      }
      onFinishing(_imagesLoad[imageUrl]);
    } on Exception catch (e) {
      onError(e);
    }
    notifyListeners();
  }
}
