import 'dart:async';
import 'dart:io';

import 'package:jocco/core/models/app_user.dart';
import 'package:jocco/core/services/auth_services_impl.dart';
import 'package:jocco/core/services/user_services_impl.dart';

class RegisterStream {
  static StreamController<Map<String, dynamic>> registerStreamController =
      StreamController<Map<String, dynamic>>();
  static Sink<Map<String, dynamic>> get registerSink =>
      registerStreamController.sink;
  static Stream<Map<String, dynamic>> get stream =>
      registerStreamController.stream.asBroadcastStream();
  static UserServicesImpl userServicesImpl = UserServicesImpl();
  static AuthServicesImpl authServicesImpl = AuthServicesImpl();
  static void reinitStream() {
    registerStreamController.close();
    registerStreamController = StreamController<Map<String, dynamic>>();
  }

  static void registerUser(
      {required Map<String, dynamic> basicData,
      required Map<String, dynamic> otherInfosData,
      required List<File> insertPhotosData,
      List<String>? otherImages,
      String? projectId,
      required Map<String, dynamic> projectInfosData,
      required Function(bool, String?, AppUser?) isFinished,
      required Function(double) hasError,
      required Function(bool) isStarted}) async {
    double step = 0.0;
    double previousStep = 0.0;
    try {
      isStarted(true);
      registerSink.add({
        'debut': previousStep,
        'fin': step,
        'message': 'Enregistrement des infos'
      });
      previousStep = step;
      step = await userServicesImpl.insertBasicInfos(data: basicData);
      registerSink.add({
        'debut': previousStep,
        'fin': step,
        'message': 'Chargement des images'
      });
      previousStep = step;
      step = await userServicesImpl.insertUserOtherInfos(data: otherInfosData);
      registerSink.add({
        'debut': previousStep,
        'fin': step,
        'message': 'Sauvegarde des images'
      });
      previousStep = step;
      final picDataResponse =
          await userServicesImpl.insertUserPhotos(images: insertPhotosData, otherImages: otherImages);
      step = picDataResponse['value'];
      registerSink.add({
        'debut': previousStep,
        'fin': step,
        'message': 'Chargement du profil'
      });
      previousStep = step;
      step = projectId != null? await userServicesImpl.updateUserProjectInfos(data: projectInfosData, id: projectId):
          await userServicesImpl.insertUserProjectInfos(data: projectInfosData);
      registerSink.add(
          {'debut': previousStep, 'fin': step, 'message': 'Finalisation...'});
      final appUser = await authServicesImpl.me();
      isFinished(true, (picDataResponse['pic'] as List).first, appUser);
    } catch (e) {
      hasError(step);
      isFinished(false, null, null);
      rethrow;
    }
  }
}
