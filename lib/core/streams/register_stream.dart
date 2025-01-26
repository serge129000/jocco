import 'dart:async';

import 'package:jocco/core/services/user_services_impl.dart';

class RegisterStream {
  static final StreamController<Map<String, double>> registerStreamController =
      StreamController<Map<String, double>>();
  static Sink<Map<String, double>> get registerSink =>
      registerStreamController.sink;
  static Stream<Map<String, double>> get stream =>
      registerStreamController.stream;
  static UserServicesImpl userServicesImpl = UserServicesImpl();

  static void registerUser(
      {required Map<String, dynamic> basicData,
      required Map<String, dynamic> otherInfosData,
      required Map<String, dynamic> insertPhotosData,
      required Map<String, dynamic> projectInfosData,
      required Function(bool) isFinished,
      required Function(double) hasError,
      required Function(bool) isStarted}) async {
    double step = 0.0;
    double previousStep = 0.0;
    try {
      isStarted(true);
      registerSink.add({'debut': previousStep, 'fin': step});
      previousStep = step;
      step = await userServicesImpl.insertBasicInfos(data: basicData);
      registerSink.add({'debut': previousStep, 'fin': step});
      previousStep = step;
      step = await userServicesImpl.insertUserOtherInfos(data: otherInfosData);
      registerSink.add({'debut': previousStep, 'fin': step});
      previousStep = step;
      step = await userServicesImpl.insertUserPhotos(data: insertPhotosData);
      registerSink.add({'debut': previousStep, 'fin': step});
      previousStep = step;
      step =
          await userServicesImpl.insertUserProjectInfos(data: projectInfosData);
      registerSink.add({'debut': previousStep, 'fin': step});
      await Future.delayed(Duration(seconds: 2));
      isFinished(true);
    } catch (e) {
      hasError(step);
      isFinished(false);
      registerSink.close();
      rethrow;
    }
  }
}
