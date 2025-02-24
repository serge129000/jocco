import 'package:firebase_auth/firebase_auth.dart';

import '../models/app_user.dart';

abstract class AuthServices {
  Future<void> registerWithPhoneNumber(
      {required String phoneNumber,
      required void Function(PhoneAuthCredential) verificationCompleted,
      required void Function(FirebaseAuthException) verificationFailed,
      required void Function(String, int?) codeSent,
      required void Function(String) codeAutoRetrievalTimeout});
  Future<void> verifyOtp({required String code, required String id});
  Future<void> resendOtp();
  Future<void> disconectUser();
  Future<AppUser> me();
}
