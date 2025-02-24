import 'dart:io';

abstract class StorageService {
  void setImageNameAndPath({required String imageUrl, required File image});
  Future<File?> getImageLoaclPath({required String imageUrl});
}
