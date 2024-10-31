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
  List<String> _selectedTraits = [];
  List<String> get selectedTraits => _selectedTraits;

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
}
