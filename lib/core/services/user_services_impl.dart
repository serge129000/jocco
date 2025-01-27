import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
        imagesUploaded[i] = await addImage(image: images[i], userId: uid);
      }
      data['images'] = imagesUploaded;
      final response = await http.patch(
          kProdUri(endPoint: 'api/v1/users/images'),
          body: jsonEncode(data),
          headers: authHeaders(token: jwt));
      if (!checkIfSuccess(statusCode: response.statusCode)) {
        throw Exception(response.body);
      }
      return {'value': 0.7, 'pic': ([/* '' */data['images'] as List]).first};
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
      final response = await http.patch(
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
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(17040039).toString();
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('photos')
          .child(userId)
          .child('${fileName}.jpg');
      await storageRef.putFile(image);
      return storageRef.getDownloadURL();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
