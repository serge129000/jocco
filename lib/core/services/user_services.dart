import 'dart:io';

import 'package:jocco/core/models/potential_matching.dart';

abstract class UserServices {
  Future<double> insertBasicInfos({required Map<String, dynamic> data});
  Future<Map<String, dynamic>> insertUserPhotos({required List<File> images});
  Future<double> insertUserOtherInfos({required Map<String, dynamic> data});
  Future<double> insertUserProjectInfos({required Map<String, dynamic> data});
  Future<String> addImage({required File image, required String userId});
  void listenUserMessages({required Function(Map<String, List>) onNewChat});
  Future<void> sendMessages(
      {required String text, required String senderId, String? roomId});
  Future<String> getRoomId({required String secondUserId});
  Future<File> addImageToCache({required String imageUrl});
  Future<PotentialMatchingContent> getPotentialMatchings({(int, int)? paginData});
}
