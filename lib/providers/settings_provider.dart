import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// Configuración de la app
class AppSettings {
  final ThemeMode themeMode;
  final String currency; // USD, EUR, COP
  final String locale; // en, es

  AppSettings({
    this.themeMode = ThemeMode.light,
    this.currency = 'USD',
    this.locale = 'en',
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? currency,
    String? locale,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      currency: currency ?? this.currency,
      locale: locale ?? this.locale,
    );
  }
}

final settingsProvider = StateProvider<AppSettings>((ref) {
  return AppSettings();
});

// Provider para el tema
final themeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(settingsProvider).themeMode;
});

// Provider para la moneda
final currencyProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider).currency;
});

// Provider para el idioma
final localeProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider).locale;
});
