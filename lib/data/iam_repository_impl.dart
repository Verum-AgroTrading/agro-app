import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:verum_agro_trading/domain/iam_repository.dart';

/// [IamRepositoryImpl] is the implementation class for [IamRepository].
/// It uses [FirebaseAuth] to implement authentication.
class IamRepositoryImpl implements IamRepository {
  final FirebaseAuth _authProvider;
  late String _verificationId;

  IamRepositoryImpl({required FirebaseAuth authProvider})
      : _authProvider = authProvider;

  /// [loginViaPhoneNumber] allows uers to login via phone number with country
  /// code.
  ///
  /// Input:
  /// phoneNumber -> +91-8954042886
  /// resendToken -> int?, if not null, it will be used to resend the otp
  @override
  Future<void> loginViaPhoneNumber({required String phoneNumber}) async {
    try {
      await _authProvider.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (phoneAuthCredential) async {
            // only for Android that supports automatic SMS code resolution
            // it will automatically login user without requiring them to
            // putin OTP.
            // await _authProvider.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (firebaseException) {
            throw firebaseException;
          },
          codeSent: (verificationId, resendToken) {
            _verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } catch (err, st) {
      log(err.toString());
      log(st.toString());
      rethrow;
    }
  }

  /// [verifyOTP] verifies the OTP and returns `true` if the OTP matches
  /// else it returns `false`
  @override
  Future<bool> verifyOTP({required String otp}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: otp);
      final userCredential =
          await _authProvider.signInWithCredential(credential);

      return userCredential.user != null;
    } catch (err, st) {
      log(err.toString());
      log(st.toString());
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _authProvider.signOut();
  }
}
