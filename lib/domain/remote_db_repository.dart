/// [RemoteDbRepository] is responsible for all the CRUD operations on the
/// remote database
abstract class RemoteDbRepository {
  /// [isUserRegistered] checks if the current user is already present
  /// in the firestore database, if yes it returns true, else false
  Future<bool> isUserRegistered({required String userId});

  /// [registerUser] registers user for the first time
  /// phoneNumber -> 8954042886
  Future<void> registerUser(
      {required String userId, required String phoneNumber});

  /// [isUserAdmin] checks if the user is and admin based on the list of
  /// phone numbers available in the admins document.
  /// phoneNumber -> 8954042886
  Future<bool> isUserAdmin({required String phoneNumber});
}
