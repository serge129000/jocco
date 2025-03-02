import 'dart:io';

import 'package:jocco/core/models/potential_matching.dart';

import '../models/app_user.dart';

abstract class UserServices {
  Future<double> insertBasicInfos({required Map<String, dynamic> data});
  Future<Map<String, dynamic>> insertUserPhotos({required List<File> images});
  Future<double> insertUserOtherInfos({required Map<String, dynamic> data});
  Future<double> insertUserProjectInfos({required Map<String, dynamic> data});
  Future<String> addImage({required File image, required String userId});
  void listenUserMessages({required Function(Map<String, List>) onNewChat, required Function(Map<String, List<AppUser>>) rommUsers});
  Future<void> sendMessages(
      {required String text, required String senderId, String? roomId, required AppUser currentUser, required AppUser secondUser});
  Future<String> getRoomId({required String secondUserId});
  Future<File> addImageToCache({required String imageUrl});
  Future<PotentialUserContent> getPotentialMatchings({(int, int)? paginData});
  Future<void> viewUser({required String userId});
  Future<void> likeUser({required String userId});
  Future<void> dislikeUser({required String userId});
  Future<PotentialUserContent> getMyLikers({(int, int)? paginData});
  Future<PotentialUserContent> getMyMatches({(int, int)? paginData});
  Future<void> updateFilter({required Map<String, dynamic> data});
}
