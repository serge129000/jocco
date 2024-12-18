import 'package:flutter/foundation.dart';

import '../../utils/gender.dart';
import '../../utils/step_utils.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic> _filterData = {};
  Map<String, dynamic> get filterData => _filterData;

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
}
