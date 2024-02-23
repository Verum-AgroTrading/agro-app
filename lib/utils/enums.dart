// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

// list of langauges supported by the app
enum SupportedLanguage {
  english("English", "en"),
  romanian("Romanian", "ro"),
  russian("Russian", "ru");

  final String name;
  final String code;

  const SupportedLanguage(this.name, this.code);

  // converts any locale to their corresponding app supported language
  static SupportedLanguage fromLocale({required Locale locale}) {
    for (final language in SupportedLanguage.values) {
      if (language.code == locale.languageCode) {
        return language;
      }
    }
    return SupportedLanguage.romanian;
  }

  // converts the current langauge into their corresponding locale
  Locale toLocale() {
    return Locale(this.code);
  }
}

extension StringX on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
