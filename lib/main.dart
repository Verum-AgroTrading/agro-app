import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:verum_agro_trading/firebase_options.dart';
import 'package:verum_agro_trading/get_it.dart';
import 'package:verum_agro_trading/routing/routes.dart';
import 'package:verum_agro_trading/theme/theme.dart';
import 'package:verum_agro_trading/utils/enums.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  createSingletons();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales:
          SupportedLanguage.values.map((e) => e.toLocale()).toList(),
      path: 'assets/translations',
      fallbackLocale: SupportedLanguage.romanian.toLocale(),
      useOnlyLangCode: true,
      startLocale: SupportedLanguage.romanian.toLocale(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: themeDataDark,
      title: 'Verum Agro Trading',
      routerConfig: router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
