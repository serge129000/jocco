import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jocco/core/services/user_services.dart';
import 'package:http/http.dart' as http;
import 'package:jocco/core/utils/request_utils.dart';

class UserServicesImpl implements UserServices {
  @override
  Future<double> insertBasicInfos({required Map<String, dynamic> data}) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final response = await http.patch(
          kProdUri(endPoint: 'api/v1/users/basic-info'),
          body: jsonEncode(data),
          headers: authHeaders(
              token: await FirebaseAuth.instance.currentUser!.getIdToken()));
      if (!checkIfSuccess(statusCode: response.statusCode)) {
        throw Exception(response.body);
      }
      return 0.2;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<double> insertUserOtherInfos(
      {required Map<String, dynamic> data}) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final response = await http.patch(
          kProdUri(endPoint: 'api/v1/users/other-infos'),
          body: jsonEncode(data),
          headers: authHeaders(
              token: await FirebaseAuth.instance.currentUser!.getIdToken()));
      if (!checkIfSuccess(statusCode: response.statusCode)) {
        throw Exception(response.body);
      }
      return 0.5;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> insertUserPhotos(
      {required List<File> images}) async {
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    String? jwt = await FirebaseAuth.instance.currentUser!.getIdToken();
    try {
      await Future.delayed(Duration(seconds: 2));
      Map<String, dynamic> data = {};
      List<String> imagesUploaded = [];
      for (int i = 0; i < images.length; i++) {
        imagesUploaded.add(await addImage(image: images[i], userId: uid));
      }
      data['images'] = imagesUploaded;
      final response = await http.patch(
          kProdUri(endPoint: 'api/v1/users/images'),
          body: jsonEncode(data),
          headers: authHeaders(token: jwt));
      if (!checkIfSuccess(statusCode: response.statusCode)) {
        throw Exception(response.body);
      }
      return {
        'value': 0.7,
        'pic': ([/* '' */ data['images'] as List]).first
      };
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<double> insertUserProjectInfos(
      {required Map<String, dynamic> data}) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final response = await http.post(
          kProdUri(endPoint: 'api/v1/projets/store'),
          body: jsonEncode(data),
          headers: authHeaders(
              token: await FirebaseAuth.instance.currentUser!.getIdToken()));
      if (!checkIfSuccess(statusCode: response.statusCode)) {
        throw Exception(response.body);
      }
      return 0.9;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<String> addImage({required File image, required String userId}) async {
    try {
      final folderRef =
          FirebaseStorage.instance.ref().child("photos").child(userId);
      final ListResult result = await folderRef.listAll();
      for (Reference fileRef in result.items) {
        fileRef.delete();
      }
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(17040039).toString();
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('photos')
          .child(userId)
          .child('${fileName}.jpg');
      await storageRef.putFile(image);
      //print(await storageRef.getDownloadURL());
      return await storageRef.getDownloadURL();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  void listenUserMessages({required Function(Map<String, List>) onNewChat}) {
    Map<String, List> allUserChats = {};
    FirebaseFirestore.instance
        .collection('chats')
        .where("participants",
            arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots(includeMetadataChanges: true)
        .listen((chats) {
      for (var chat in chats.docs) {
        chat.reference
            .collection("messages")
            .orderBy("timestamp")
            .snapshots(includeMetadataChanges: true)
            .listen((chatData) {
          List<Map<String, dynamic>> chatDetails = [];
          for (var chatDetail in chatData.docs) {
            chatDetails.add(chatDetail.data());
          }
          allUserChats[chat.id] = chatDetails;
          onNewChat(allUserChats);
        });
      }
    });
  }

  @override
  Future<void> sendMessages(
      {required DateTime timestamp,
      required String text,
      required String senderId,
      required String roomId}) {
    // TODO: implement sendMessages
    throw UnimplementedError();
  }
}
