import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:jocco/core/models/app_user.dart';
import 'package:jocco/core/streams/user_stream.dart';

import '../../utils/gender.dart';
import '../../utils/step_utils.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic> _filterData = {};
  Map<String, dynamic> get filterData => _filterData;
  List<AppUser>? _potentialMatchingUsers = [];
  List<AppUser>? get potentialMatchingUsers => _potentialMatchingUsers;
  List<AppUser> _finalUsers = [];
  List<AppUser> get finalUsers => _finalUsers;
  List<AppUser> _passedUser = [];
  List<AppUser> get passedUser => _passedUser;
  late AppinioSwiperController _controller;
  AppinioSwiperController get controller => _controller;

  void setDistance({required double distanceValue}) {
    _filterData['distance'] = distanceValue;
    notifyListeners();
  }

  void setActivateOrDesactivate({required bool st}) {
    _filterData['st'] = st;
    notifyListeners();
  }

  void setAgeRange({required int ageMin, required int ageMax}) {
    _filterData['ageMin'] = ageMin;
    _filterData['ageMax'] = ageMax;
    notifyListeners();
  }

  void setGender({required Gender gender}) {
    _filterData['gender'] = gender;
    notifyListeners();
  }

  void setProjectCat({required String projectCat}) {
    _filterData['projectCat'] = projectCat;
    notifyListeners();
  }

  void setInterestCat({required List<String> interests}) {
    _filterData['interests'] = interests;
    notifyListeners();
  }

  void setPersonnality({required String personnality}) {
    _filterData['personnality'] = personnality;
    notifyListeners();
  }

  void projectDebut({required ProjectTimes projectTimes}) {
    _filterData['projectTimes'] = projectTimes;
    notifyListeners();
  }

  void initMatching() {
    _controller = AppinioSwiperController();
    UserStream().initUserPotentialMatching();
  }

  void startMatching((int, int)? pagingData) {
    UserStream().fetchUserPotentialMatching(pagingData);
  }

  void passUser() {
    _passedUser.add(_finalUsers.removeAt(0));
    notifyListeners();
  }

  void getBackToUser() {
    _finalUsers.insert(0, _passedUser.last);
    notifyListeners();
  }

  void listenToUserMatching({required Function(Object) onError}) {
    UserStream.getPoMatchStream.listen((data) {
      _potentialMatchingUsers = data;
      _finalUsers.addAll(_potentialMatchingUsers ?? []);
      notifyListeners();
    }).onError(onError);
  }
}
