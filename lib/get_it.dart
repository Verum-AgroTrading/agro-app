import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:verum_agro_trading/data/iam_repository_impl.dart';
import 'package:verum_agro_trading/data/remote_db_repository_impl.dart';
import 'package:verum_agro_trading/domain/iam_repository.dart';
import 'package:verum_agro_trading/domain/remote_db_repository.dart';

final getIt = GetIt.instance;

void createSingletons() {
  getIt.registerLazySingleton<IamRepository>(
      () => IamRepositoryImpl(authProvider: FirebaseAuth.instance));
  getIt.registerLazySingleton<RemoteDbRepository>(
      () => RemoteDbRepositoryImpl(remoteDatabase: FirebaseFirestore.instance));
}
