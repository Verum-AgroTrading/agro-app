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
    final users = _remoteDatabase.collection('users');
    DocumentSnapshot snapshot = await users.doc(userId).get();
    log("The user $userId exists? ${snapshot.exists}");
    return snapshot.exists;
  }

  /// [registerUser] registers user for the first time
  /// phoneNumber -> 8954042886
  @override
  Future<void> registerUser(
      {required String userId, required String phoneNumber}) async {
    final users = _remoteDatabase.collection('users');
    await users.doc(userId).set({
      "role": "user",
      "phoneNumber": phoneNumber,
    });
  }
}
