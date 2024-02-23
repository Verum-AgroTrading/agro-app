import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verum_agro_trading/domain/remote_db_repository.dart';

/// [RemoteDbRepositoryImpl] is the implementation class for [RemoteDbRepository].
/// It uses [FireStore] as a remote database.
class RemoteDbRepositoryImpl extends RemoteDbRepository {
  final FirebaseFirestore _remoteDatabase;

  RemoteDbRepositoryImpl({required FirebaseFirestore remoteDatabase})
      : _remoteDatabase = remoteDatabase;

  /// [isUserRegistered] checks if the current user is already present
  /// in the firestore database, if yes it returns true, else false
  @override
  Future<bool> isUserRegistered({required String userId}) async {
    try {
      final users = _remoteDatabase.collection('users');
      DocumentSnapshot snapshot = await users.doc(userId).get();
      log("The user $userId exists? ${snapshot.exists}");
      return snapshot.exists;
    } catch (err, st) {
      log(err.toString());
      log(st.toString());
      rethrow;
    }
  }

  /// [registerUser] registers user for the first time
  /// phoneNumber -> 8954042886
  @override
  Future<void> registerUser(
      {required String userId,
      required String phoneNumber,
      isAdmin = false}) async {
    try {
      final users = _remoteDatabase.collection('users');

      Map<String, dynamic> registrationBody = {
        "role": "user",
        "phoneNumber": phoneNumber,
      };

      if (isAdmin) {
        registrationBody.addAll({'admin': {}});
      }
      await users.doc(userId).set(registrationBody);
    } catch (err, st) {
      log(err.toString());
      log(st.toString());
      rethrow;
    }
  }

  /// [isUserAdmin] checks if the user is and admin based on the list of
  /// phone numbers available in the admins document.
  /// phoneNumber -> 8954042886
  @override
  Future<bool> isUserAdmin({required String phoneNumber}) async {
    try {
      final admins = _remoteDatabase.collection('admins');
      final result = await admins.doc(phoneNumber).get();
      if (result.exists) {
        return true;
      } else {
        return false;
      }
    } catch (err, st) {
      log(err.toString());
      log(st.toString());
      rethrow;
    }
  }
}
