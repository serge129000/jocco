abstract class UserServices {
  Future<double> insertBasicInfos({required Map<String, dynamic> data});
  Future<double> insertUserPhotos({required Map<String, dynamic> data});
  Future<double> insertUserOtherInfos({required Map<String, dynamic> data});
  Future<double> insertUserProjectInfos({required Map<String, dynamic> data});
}