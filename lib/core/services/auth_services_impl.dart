import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:jocco/core/models/app_user.dart';
import 'package:jocco/core/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:jocco/core/utils/request_utils.dart';

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

  @override
  Future<AppUser> me() async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      final meResponse = await http.get(kProdUri(endPoint: "api/v1/users/me"),
          headers: authHeaders(token: token));
      if (!checkIfSuccess(statusCode: meResponse.statusCode)) {
        debugPrint(meResponse.body);
        return AppUser.fromFirebaseUser(
          message: jsonDecode(utf8.decode(meResponse.bodyBytes))['message'],
            user: FirebaseAuth.instance.currentUser!);
      }
      final userData = jsonDecode(utf8.decode(meResponse.bodyBytes));
      return AppUser.fromJson(userData['data']);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  //Future
}
