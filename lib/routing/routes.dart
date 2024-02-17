import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:verum_agro_trading/bloc/iam/iam_bloc.dart';
import 'package:verum_agro_trading/domain/iam_repository.dart';
import 'package:verum_agro_trading/domain/remote_db_repository.dart';
import 'package:verum_agro_trading/get_it.dart';
import 'package:verum_agro_trading/presentation/home/home_page.dart';
import 'package:verum_agro_trading/presentation/login/login_page.dart';
import 'package:verum_agro_trading/presentation/login/opt_verification_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: FirebaseAuth.instance.currentUser == null
      ? RoutingPaths.login
      : RoutingPaths.home,
  routes: [
    GoRoute(
      path: RoutingPaths.login,
      name: RoutingPaths.login,
      builder: (context, state) => BlocProvider(
          create: (context) => IamBloc(getIt.get<IamRepository>(),
              FirebaseAuth.instance, getIt.get<RemoteDbRepository>()),
          child: const LoginPage()),
    ),
    GoRoute(
      path: RoutingPaths.verifyOtp,
      name: RoutingPaths.verifyOtp,
      builder: (context, state) => BlocProvider.value(
        value: state.extra as IamBloc,
        child: OtpVerificationPage(
          phoneNumber: state.pathParameters['phoneNumber'] as String,
        ),
      ),
    ),
    GoRoute(
      path: RoutingPaths.home,
      name: RoutingPaths.home,
      builder: (context, state) {
        if (state.extra != null) {
          return BlocProvider.value(
              value: state.extra as IamBloc, child: const HomePage());
        } else {
          return BlocProvider(
              create: (context) => IamBloc(getIt.get<IamRepository>(),
                  FirebaseAuth.instance, getIt.get<RemoteDbRepository>()),
              child: const HomePage());
        }
      },
    ),
  ],
);

class RoutingPaths {
  static const home = "/home";
  static const login = "/login";
  static const verifyOtp = "/verifyOtp/:phoneNumber";
}
