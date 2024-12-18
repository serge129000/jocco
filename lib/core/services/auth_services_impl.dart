import 'package:firebase_auth/firebase_auth.dart';
import 'package:jocco/core/services/auth_services.dart';

class AuthServicesImpl implements AuthServices {
  @override
  Future<void> registerWithPhoneNumber(
      {required String phoneNumber,
      required void Function(PhoneAuthCredential) verificationCompleted,
      required void Function(FirebaseAuthException) verificationFailed,
      required void Function(String, int?) codeSent,
      required void Function(String) codeAutoRetrievalTimeout}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  @override
  Future<void> verifyOtp({required String code, required String id}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: id,
      smsCode: code,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> resendOtp() async {
    // TODO: implement resendOtp
    throw UnimplementedError();
  }

  @override
  Future<void> disconectUser() async {
   await FirebaseAuth.instance.signOut();
  }
}
