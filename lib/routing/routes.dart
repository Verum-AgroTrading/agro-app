import 'package:go_router/go_router.dart';
import 'package:verum_agro_trading/main.dart';
import 'package:verum_agro_trading/presentation/login/login_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
