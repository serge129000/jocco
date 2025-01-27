import 'dart:io';

abstract class UserServices {
  Future<double> insertBasicInfos({required Map<String, dynamic> data});
  Future<Map<String, dynamic>> insertUserPhotos({required List<File> images});
  Future<double> insertUserOtherInfos({required Map<String, dynamic> data});
  Future<double> insertUserProjectInfos({required Map<String, dynamic> data});
  Future<String> addImage({required File image, required String userId});
}
