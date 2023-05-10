import 'dart:convert';
// ignore: unused_import
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  late final Locale locale;
  AppLocalizations(this.locale);
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  late Map<String, String> _localizedString;
  Future<bool> load() async {
    //load the language JSON file from asset folder
    final jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedString =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    // reture not necessary because i use bool thats why there is no need to return any value
    return true;
  }

  String? translate(String key) {
    return _localizedString[key];
  }

  static const supportedLocales = [
    Locale('en', 'US'),
    Locale('ar', 'AR'),
    Locale('sk', 'SK'),
  ];
  // localeResolutionCallback(locale, supportedLocales) {
  //   for (var supportedLocales in supportedLocales) {
  //     if (supportedLocales.) {}
  //   }
  // }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'sk', 'ur'].contains(locale.languageCode);
  }

  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
