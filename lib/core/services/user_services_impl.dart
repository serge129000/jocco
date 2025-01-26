import 'package:jocco/core/services/user_services.dart';

class UserServicesImpl implements UserServices {
  @override
  Future<double> insertBasicInfos({required Map<String, dynamic> data}) async {
   await Future.delayed(Duration(seconds: 2));
   return 0.2;
  }

  @override
  Future<double> insertUserOtherInfos(
      {required Map<String, dynamic> data}) async {
        await Future.delayed(Duration(seconds: 2));
        return 0.5;
      }

  @override
  Future<double> insertUserPhotos({required Map<String, dynamic> data}) async {
    await Future.delayed(Duration(seconds: 2));
    return 0.7;
  }

  @override
  Future<double> insertUserProjectInfos(
      {required Map<String, dynamic> data}) async {
        await Future.delayed(Duration(seconds: 2));
        return 0.9;
      }
}
