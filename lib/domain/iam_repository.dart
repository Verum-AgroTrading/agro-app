/// [IamRepository] is responsible for all the authentication and
/// authorization related data for the user
abstract class IamRepository {
  /// [loginViaPhoneNumber] allows uers to login via phone number with country
  /// code.
  /// Input: phoneNumber -> +91-8954042886
  Future<void> loginViaPhoneNumber({required String phoneNumber});

  /// [verifyOTP] verifies the OTP and returns `true` if the OTP matches
  /// else it returns `false`
  /// Input: otp -> 123456
  Future<bool> verifyOTP({required String otp});

  Future<void> signOut();
}
