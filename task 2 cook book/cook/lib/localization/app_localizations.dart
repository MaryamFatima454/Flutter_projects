import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const _localizedValues = {
    'en': {
      'settings': 'Settings',
      'notifications': 'Notifications',
      'dark_mode': 'Dark Mode',
      'language': 'Language',
      'logout': 'Logout',
    },
    'ur': {
      'settings': 'سیٹنگز',
      'notifications': 'اطلاعات',
      'dark_mode': 'ڈارک موڈ',
      'language': 'زبان',
      'logout': 'لاگ آؤٹ',
    },
    'es': {
      'settings': 'Configuraciones',
      'notifications': 'Notificaciones',
      'dark_mode': 'Modo Oscuro',
      'language': 'Idioma',
      'logout': 'Cerrar sesión',
    },
    'fr': {
      'settings': 'Paramètres',
      'notifications': 'Notifications',
      'dark_mode': 'Mode Sombre',
      'language': 'Langue',
      'logout': 'Déconnexion',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']![key]!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ur', 'es', 'fr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
