class HelperFunctions {
  /// [stripCountryCode] strips off the prefix country code from the phone
  /// number.
  /// Input -> +918954042886, Output -> 8954042886
  /// Input -> 918954042886, Output -> 8954042886
  static String stripCountryCode({required String phoneNumber}) {
    if (phoneNumber.length == 13) {
      return phoneNumber.substring(3);
    } else if (phoneNumber.length == 12) {
      return phoneNumber.substring(2);
    } else {
      return phoneNumber;
    }
  }
}
