import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jocco/core/models/app_user.dart';
import 'package:jocco/core/models/custom_exception.dart';
import 'package:jocco/core/models/potential_matching.dart';
import 'package:jocco/core/services/storage_services_impl.dart';
import 'package:jocco/core/services/user_services.dart';
import 'package:http/http.dart' as http;
import 'package:jocco/core/utils/request_utils.dart';
import 'package:path_provider/path_provider.dart';

class UserServicesImpl implements UserServices {
  @override
  Future<double> insertBasicInfos({required Map<String, dynamic> data}) async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
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
      await Future.delayed(Duration(milliseconds: 500));
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
      {required List<File> images, List<String>? otherImages}) async {
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    String? jwt = await FirebaseAuth.instance.currentUser!.getIdToken();
    try {
      await Future.delayed(Duration(milliseconds: 500));
      Map<String, dynamic> data = {};
      List<String> imagesUploaded = [];
      for (int i = 0; i < images.length; i++) {
        imagesUploaded.add(await addImage(image: images[i], userId: uid));
      }
      if (otherImages != null) imagesUploaded.addAll(otherImages);
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
      /* final folderRef =
          FirebaseStorage.instance.ref().child("photos").child(userId);
      final ListResult result = await folderRef.listAll();
      for (Reference fileRef in result.items) {
        fileRef.delete();
      } */
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
  void listenUserMessages(
      {required Function(Map<String, List>) onNewChat,
      required AppUser currentUser,
      required Function(Map<String, List<AppUser>>) rommUsers}) {
    Map<String, List> allUserChats = {};
    Map<String, List<AppUser>> userAndChats = {};
    FirebaseFirestore.instance
        .collection('chats')
        .where("participants", arrayContains: currentUser.id)
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
          userAndChats[chat.id] = List<AppUser>.from(
              ((chat.data()['users'] ?? []) as List)
                  .map((e) => AppUser.fromJson(e)));
          allUserChats[chat.id] = chatDetails;
          onNewChat(allUserChats);
          rommUsers(userAndChats);
        });
      }
    });
  }

  @override
  Future<void> sendMessages(
      {required String text,
      String? roomId,
      String? uuid,
      required AppUser currentUser,
      required AppUser secondUser}) async {
    try {
      final roomIdGet = roomId ??
          await getRoomId(
              secondUserId: secondUser.id, currentUser: currentUser);
      final storeInstance = FirebaseFirestore.instance;
      await storeInstance.collection('chats').doc(roomIdGet).set({
        'participants': [currentUser.id, secondUser.id],
        'users': [currentUser.toJson(), secondUser.toJson()]
      }).then((value) async => await storeInstance
              .collection('chats')
              .doc(roomIdGet)
              .collection('messages')
              .add({
            'sender': currentUser.id,
            'text': text,
            'uuid': uuid,
            'timestamp': FieldValue.serverTimestamp(),
            'status': 'unRead',
          }));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getRoomId(
      {required String secondUserId, required AppUser currentUser}) async {
    QuerySnapshot chatQuery = await FirebaseFirestore.instance
        .collection('chats')
        .where('participants', arrayContains: currentUser.id)
        .get();

    for (var doc in chatQuery.docs) {
      List participants = doc['participants'];
      if (participants.contains(secondUserId)) {
        print('chat doc: ${doc.id}');
        return doc.id;
      }
    }

    // Si aucun chat trouvé, en créer un nouveau
    DocumentReference chatRef =
        await FirebaseFirestore.instance.collection('chats').add({
      'participants': [currentUser.id, secondUserId],
      'createdAt': FieldValue.serverTimestamp(),
    });

    return chatRef.id;
  }

  @override
  Future<File> addImageToCache({required String imageUrl}) async {
    StorageServicesImpl storageServicesImpl = StorageServicesImpl();
    try {
      final fileImageResponse = await http.get(Uri.parse(imageUrl));
      if (!checkIfSuccess(statusCode: fileImageResponse.statusCode)) {
        throw Exception('Erreur de chargement de l\'image');
      }
      final currentDirectory = await getApplicationDocumentsDirectory();
      final fileName = DateTime.now().millisecondsSinceEpoch;
      final file = File('${currentDirectory.path}/images/${fileName}.png');
      await file.writeAsBytes(fileImageResponse.bodyBytes);
      storageServicesImpl.setImageNameAndPath(imageUrl: imageUrl, image: file);
      return file;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PotentialUserContent> getPotentialMatchings(
      {(int, int)? paginData}) async {
    try {
      final response = await http.get(
          kProdUri(
              endPoint: paginData == null
                  ? 'api/v1/users/matching-users'
                  : 'api/v1/users/matching-users?page=${paginData.$1}&size=${paginData.$2}'),
          headers: authHeaders(
              token: await FirebaseAuth.instance.currentUser!.getIdToken()));
      if (!checkIfSuccess(statusCode: response.statusCode)) {
        throw Exception(response.body);
      }
      final potentialMatchingData =
          jsonDecode(utf8.decode(response.bodyBytes))['data'];
      return PotentialUserContent.fromJson(potentialMatchingData);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> dislikeUser({required String userId}) async {
    try {
      final response = await http.patch(
          kProdUri(endPoint: 'api/v1/users/dislike/$userId'),
          headers: authHeaders(
              token: await FirebaseAuth.instance.currentUser!.getIdToken()));
      if (!checkIfSuccess(statusCode: response.statusCode)) {
        throw CustomException(
            message: jsonDecode(utf8.decode(response.bodyBytes))['message']);
      }
    } on CustomException catch (e) {
      throw e;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> likeUser({required String userId}) async {
    try {
      final response = await http.patch(
          kProdUri(endPoint: 'api/v1/users/like/$userId'),
          headers: authHeaders(
              token: await FirebaseAuth.instance.currentUser!.getIdToken()));
      if (!checkIfSuccess(statusCode: response.statusCode)) {
        throw CustomException(
            message: jsonDecode(utf8.decode(response.bodyBytes))['message']);
      }
    } on CustomException catch (e) {
      throw e;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> viewUser({required String userId}) async {
    try {
      final response = await http.patch(
          kProdUri(endPoint: 'api/v1/users/view/$userId'),
          headers: authHeaders(
              token: await FirebaseAuth.instance.currentUser!.getIdToken()));
      if (!checkIfSuccess(statusCode: response.statusCode)) {
        throw Exception(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PotentialUserContent> getMyLikers({(int, int)? paginData}) async {
    try {
      final response = await http.get(
          kProdUri(
              endPoint: paginData == null
                  ? 'api/v1/users/my-likers'
                  : 'api/v1/users/my-likers?page=${paginData.$1}&size=${paginData.$2}'),
          headers: authHeaders(
              token: await FirebaseAuth.instance.currentUser!.getIdToken()));
      if (!checkIfSuccess(statusCode: response.statusCode)) {
        throw Exception(response.body);
      }
      final potentialMatchingData =
          jsonDecode(utf8.decode(response.bodyBytes))['data'];
      return PotentialUserContent.fromJson(potentialMatchingData);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<PotentialUserContent> getMyMatches({(int, int)? paginData}) async {
    try {
      final response = await http.get(
          kProdUri(
              endPoint: paginData == null
                  ? 'api/v1/users/my-matches'
                  : 'api/v1/users/my-matches?page=${paginData.$1}&size=${paginData.$2}'),
          headers: authHeaders(
              token: await FirebaseAuth.instance.currentUser!.getIdToken()));
      if (!checkIfSuccess(statusCode: response.statusCode)) {
        throw Exception(response.body);
      }
      final potentialMatchingData =
          jsonDecode(utf8.decode(response.bodyBytes))['data'];
      return PotentialUserContent.fromJson(potentialMatchingData);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> updateFilter({required Map<String, dynamic> data}) async {
    try {
      final response = await http.put(kProdUri(endPoint: 'api/v1/users/filter'),
          body: jsonEncode(data),
          headers: authHeaders(
              token: await FirebaseAuth.instance.currentUser!.getIdToken()));
      if (!checkIfSuccess(statusCode: response.statusCode)) {
        throw Exception(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<double> updateUserProjectInfos(
      {required Map<String, dynamic> data, required String id}) async {
    try {
      data['id'] = id;
      final response = await http.put(
          kProdUri(endPoint: 'api/v1/projets/update'),
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
}
