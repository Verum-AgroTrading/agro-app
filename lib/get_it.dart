import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:verum_agro_trading/data/iam_repository_impl.dart';
import 'package:verum_agro_trading/domain/iam_repository.dart';

final getIt = GetIt.instance;

void createSingletons() {
  getIt.registerLazySingleton<IamRepository>(
      () => IamRepositoryImpl(authProvider: FirebaseAuth.instance));
}
