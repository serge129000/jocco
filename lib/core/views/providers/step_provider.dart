import 'package:flutter/foundation.dart';
import 'package:jocco/core/utils/gender.dart';
import 'package:jocco/core/utils/step_utils.dart';

class StepProvider with ChangeNotifier {
  StepJ _currentStep = StepJ.first;
  StepJ get currentStep => _currentStep;
  Gender? _selectedGender;
  Gender? get selectedGender => _selectedGender;
  Gender? _choosenGender;
  Gender? get choosenGender => _choosenGender;
  final List<String> _selectedTraits = [];
  List<String> get selectedTraits => _selectedTraits;
  final List<String> _selectedInterest = [];
  List<String> get selectedInterest => _selectedInterest;
  IfProject? _selectedIfProject;
  IfProject? get selectedIfProject => _selectedIfProject;
  LeaveAll _leaveAll = LeaveAll.yes;
  LeaveAll get leaveAll => _leaveAll;
  bool _hasChildren = false;
  bool get hasChildren => _hasChildren;
  String? _projectCat;
  String? get projectCat => _projectCat;
  Map<int, String> _selectedImages = {};
  Map<int, String> get selectedImages => _selectedImages;
  ProjectTimes _projectTimes = ProjectTimes.immediately;
  ProjectTimes get projectTimes => _projectTimes;

  void nextStep() {
    _currentStep = StepJ.stepFromValue(step: _currentStep.value + 1);
    notifyListeners();
  }

  void backStep() {
    _currentStep = StepJ.stepFromValue(step: _currentStep.value - 1);
    notifyListeners();
  }

  void setGender({required Gender gender}) {
    _selectedGender = gender;
    notifyListeners();
  }

  void chooseGender({required Gender gender}) {
    _choosenGender = gender;
    notifyListeners();
  }

  void addTraits({required String trait}) {
    _selectedTraits.add(trait);
    notifyListeners();
  }

  void deleteTrait({required String trait}) {
    _selectedTraits.removeWhere((e) => e == trait);
    notifyListeners();
  }

  void addInterest({required String interest}) {
    _selectedInterest.add(interest);
    notifyListeners();
  }

  void deleteInterest({required String interest}) {
    _selectedInterest.removeWhere((e) => e == interest);
    notifyListeners();
  }

  void setSelectedIfProjet({required IfProject ifProject}) {
    _selectedIfProject = ifProject;
    notifyListeners();
  }

  void setSelectedLeavingAll({required LeaveAll leaveAlls}) {
    _leaveAll = leaveAlls;
    notifyListeners();
  }

  void changeHasChildrenState(bool hs) {
    _hasChildren = hs;
    notifyListeners();
  }

  void addProjectCat({required String category}) {
    _projectCat = category;
    notifyListeners();
  }

  void addImage({required int key, required String imagePath}) {
    try {
      _selectedImages[key] = imagePath;
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  void removeImage({required int key}) {
    _selectedImages.removeWhere((e, v) => e == key);
    notifyListeners();
  }

  void setProjectTimes({required ProjectTimes times}) {
    _projectTimes = times;
    notifyListeners();
  }
}
