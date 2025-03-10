import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:jocco/core/models/app_user.dart';
import 'package:jocco/core/services/auth_services_impl.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:devicelocale/devicelocale.dart';

class AppAuthProvider with ChangeNotifier {
  final authServicesImpl = AuthServicesImpl();
  Status _registerStatus = Status.initial;
  Status get registerStatus => _registerStatus;
  Status _verifyingOtpStatus = Status.initial;
  Status get verifyingOtpStatus => _verifyingOtpStatus;
  Status _logoutStatus = Status.initial;
  Status get logoutStatus => _logoutStatus;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  String? _currentLocale;
  String? get currentLocale => _currentLocale;
  AppUser? _currentAppUser;
  AppUser? get currentAppUser => _currentAppUser;

  void verifyPhoneNumber(
      {required String phoneNumber,
      required void Function(PhoneAuthCredential) verificationCompleted,
      required void Function(FirebaseAuthException) verificationFailed,
      required void Function(String, int?) codeSent,
      required void Function(String) codeAutoRetrievalTimeout}) async {
    _registerStatus = Status.loading;
    notifyListeners();
    try {
      await authServicesImpl.registerWithPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      _registerStatus = Status.loaded;
      notifyListeners();
    } catch (e) {
      //print(e);
      _registerStatus = Status.error;
      notifyListeners();
    }
  }

  void verifyOtp({required String code, required String id}) async {
    _verifyingOtpStatus = Status.loading;
    notifyListeners();
    try {
      await authServicesImpl.verifyOtp(code: code, id: id);
      _verifyingOtpStatus = Status.loaded;
      notifyListeners();
    } catch (e) {
      _verifyingOtpStatus = Status.error;
      notifyListeners();
    } finally {
      _verifyingOtpStatus = Status.initial;
      notifyListeners();
    }
  }

  void logoutUser() async {
    _logoutStatus = Status.loading;
    notifyListeners();
    try {
      await authServicesImpl.disconectUser();
      _logoutStatus = Status.loaded;
      notifyListeners();
      debugPrint('Succesfully logout');
    } catch (e) {
      _logoutStatus = Status.error;
      notifyListeners();
    }
  }

  void changeHistoryPage({required int index}) {
    _currentIndex = index;
    notifyListeners();
  }

  void init() async {
    _currentLocale = await Devicelocale.currentLocale;
    _currentLocale = (_currentLocale ?? 'FR').split('-').last;
    //debugPrint('current Locale ${_currentLocale}');
  }

  Future<void> me() async {
    _currentAppUser = await AuthServicesImpl().me();
    notifyListeners();
  }
}
