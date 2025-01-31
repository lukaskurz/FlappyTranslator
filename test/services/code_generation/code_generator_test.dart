import 'package:flappy_translator/src/services/code_generation/code_generator.dart';
import 'package:test/test.dart';

void main() {
  test('formattedString', () {
    final codeGenerator = CodeGenerator(
      className: 'I18n',
      dependOnContext: false,
      useSingleQuotes: true,
    );

    expect(
      codeGenerator.formattedString,
      '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: public_member_api_docs, prefer_single_quotes, avoid_escaping_inner_quotes, prefer_const_constructors, sort_constructors_first, always_specify_types

import 'dart:async';

import 'package:flutter/widgets.dart';

/// A class generated by flappy_translator package containing localized strings
class I18n {
  /// Fields area

  static late Map<String, String> _localizedValues;

  /// Values area

  I18n(Locale locale) {
    _locale = locale;
    _localizedValues = {};
  }

  static late Locale _locale;

  static String _getText(String key) =>
      _localizedValues[key] ?? '** \$key not found';

  static Locale get currentLocale => _locale;

  static String get currentLanguage => _locale.languageCode;

  static Future<I18n> load(Locale locale) async {
    final translations = I18n(locale);
    _localizedValues = _allValues[locale.toString()]!;
    return translations;
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  /// SupportedLanguages area

  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);

  @override
  bool shouldReload(I18nDelegate old) => false;
}
''',
    );
  });

  test('formattedString', () {
    final codeGenerator = CodeGenerator(
      className: 'I18n',
      dependOnContext: false,
      useSingleQuotes: true,
    );
    codeGenerator.setSupportedLanguages(['en_US', 'de']);

    expect(
      codeGenerator.formattedString,
      '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: public_member_api_docs, prefer_single_quotes, avoid_escaping_inner_quotes, prefer_const_constructors, sort_constructors_first, always_specify_types

import 'dart:async';

import 'package:flutter/widgets.dart';

/// A class generated by flappy_translator package containing localized strings
class I18n {
  /// Fields area

  static late Map<String, String> _localizedValues;

  /// Values area

  I18n(Locale locale) {
    _locale = locale;
    _localizedValues = {};
  }

  static late Locale _locale;

  static String _getText(String key) =>
      _localizedValues[key] ?? '** \$key not found';

  static Locale get currentLocale => _locale;

  static String get currentLanguage => _locale.languageCode;

  static Future<I18n> load(Locale locale) async {
    final translations = I18n(locale);
    _localizedValues = _allValues[locale.toString()]!;
    return translations;
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  static final Set<Locale> supportedLocals = {
    Locale('en', 'US'),
    Locale('de'),
  };

  @override
  bool isSupported(Locale locale) => supportedLocals.contains(locale);

  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);

  @override
  bool shouldReload(I18nDelegate old) => false;
}
''',
    );
  });

  test('finalize', () {
    final codeGenerator = CodeGenerator(
      className: 'I18n',
      dependOnContext: false,
      useSingleQuotes: true,
      replaceNoBreakSpaces: true,
    );
    codeGenerator.setSupportedLanguages(['en_US', 'de']);
    codeGenerator
        .addField('test', 'Hello, World!', ['Hello, World!', 'Hallo, Welt!']);
    codeGenerator.addField(
        'test', 'Hello %name\$s!', ['Hello %name\$s!', 'Hallo %name\$s!']);
    codeGenerator.finalize();

    expect(
      codeGenerator.formattedString,
      '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: public_member_api_docs, prefer_single_quotes, avoid_escaping_inner_quotes, prefer_const_constructors, sort_constructors_first, always_specify_types

import 'dart:async';

import 'package:flutter/widgets.dart';

/// A class generated by flappy_translator package containing localized strings
class I18n {
  static String get test => _getText('test');

  static String test({
    required String name,
  }) =>
      _getText('test').replaceAll('%name\\\$s', name);

  static late Map<String, String> _localizedValues;

  static const _enUSValues = {
    'test': 'Hello %name\\\$s!',
  };

  static const _deValues = {
    'test': 'Hallo %name\\\$s!',
  };

  static const _allValues = {
    'en_US': _enUSValues,
    'de': _deValues,
  };

  I18n(Locale locale) {
    _locale = locale;
    _localizedValues = {};
  }

  static late Locale _locale;

  static String _getText(String key) =>
      _localizedValues[key] ?? '** \$key not found';

  static Locale get currentLocale => _locale;

  static String get currentLanguage => _locale.languageCode;

  static Future<I18n> load(Locale locale) async {
    final translations = I18n(locale);
    _localizedValues = _allValues[locale.toString()]!;
    return translations;
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  static final Set<Locale> supportedLocals = {
    Locale('en', 'US'),
    Locale('de'),
  };

  @override
  bool isSupported(Locale locale) => supportedLocals.contains(locale);

  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);

  @override
  bool shouldReload(I18nDelegate old) => false;
}
''',
    );
  });

  test(
      'When a variable name begining with a number is given, expect var is prepended',
      () {
    final codeGenerator = CodeGenerator(
      className: 'I18n',
      dependOnContext: false,
      useSingleQuotes: true,
      replaceNoBreakSpaces: true,
    );
    codeGenerator.setSupportedLanguages(['en']);
    codeGenerator.addField('test', 'Hello %1\$s!', ['Hello %1\$s!']);
    codeGenerator.finalize();

    expect(
      codeGenerator.formattedString,
      '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: public_member_api_docs, prefer_single_quotes, avoid_escaping_inner_quotes, prefer_const_constructors, sort_constructors_first, always_specify_types

import 'dart:async';

import 'package:flutter/widgets.dart';

/// A class generated by flappy_translator package containing localized strings
class I18n {
  static String test({
    required String var1,
  }) =>
      _getText('test').replaceAll('%1\\\$s', var1);

  static late Map<String, String> _localizedValues;

  static const _enValues = {
    'test': 'Hello %1\\\$s!',
  };

  static const _allValues = {
    'en': _enValues,
  };

  I18n(Locale locale) {
    _locale = locale;
    _localizedValues = {};
  }

  static late Locale _locale;

  static String _getText(String key) =>
      _localizedValues[key] ?? '** \$key not found';

  static Locale get currentLocale => _locale;

  static String get currentLanguage => _locale.languageCode;

  static Future<I18n> load(Locale locale) async {
    final translations = I18n(locale);
    _localizedValues = _allValues[locale.toString()]!;
    return translations;
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  static final Set<Locale> supportedLocals = {
    Locale('en'),
  };

  @override
  bool isSupported(Locale locale) => supportedLocals.contains(locale);

  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);

  @override
  bool shouldReload(I18nDelegate old) => false;
}
''',
    );
  });

  test('When a variable name is a reserved word, expect var is prepended', () {
    final codeGenerator = CodeGenerator(
      className: 'I18n',
      dependOnContext: false,
      useSingleQuotes: true,
      replaceNoBreakSpaces: true,
    );
    codeGenerator.setSupportedLanguages(['en']);
    codeGenerator.addField('test', 'Hello %for\$s!', ['Hello %for\$s!']);
    codeGenerator.finalize();

    expect(
      codeGenerator.formattedString,
      '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: public_member_api_docs, prefer_single_quotes, avoid_escaping_inner_quotes, prefer_const_constructors, sort_constructors_first, always_specify_types

import 'dart:async';

import 'package:flutter/widgets.dart';

/// A class generated by flappy_translator package containing localized strings
class I18n {
  static String test({
    required String varfor,
  }) =>
      _getText('test').replaceAll('%for\\\$s', varfor);

  static late Map<String, String> _localizedValues;

  static const _enValues = {
    'test': 'Hello %for\\\$s!',
  };

  static const _allValues = {
    'en': _enValues,
  };

  I18n(Locale locale) {
    _locale = locale;
    _localizedValues = {};
  }

  static late Locale _locale;

  static String _getText(String key) =>
      _localizedValues[key] ?? '** \$key not found';

  static Locale get currentLocale => _locale;

  static String get currentLanguage => _locale.languageCode;

  static Future<I18n> load(Locale locale) async {
    final translations = I18n(locale);
    _localizedValues = _allValues[locale.toString()]!;
    return translations;
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  static final Set<Locale> supportedLocals = {
    Locale('en'),
  };

  @override
  bool isSupported(Locale locale) => supportedLocals.contains(locale);

  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);

  @override
  bool shouldReload(I18nDelegate old) => false;
}
''',
    );
  });

  test('When a variable name is a type, expect var is prepended', () {
    final codeGenerator = CodeGenerator(
      className: 'I18n',
      dependOnContext: false,
      useSingleQuotes: true,
      replaceNoBreakSpaces: true,
    );
    codeGenerator.setSupportedLanguages(['en']);
    codeGenerator.addField('test', 'Hello %int\$s!', ['Hello %int\$s!']);
    codeGenerator.finalize();

    expect(
      codeGenerator.formattedString,
      '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: public_member_api_docs, prefer_single_quotes, avoid_escaping_inner_quotes, prefer_const_constructors, sort_constructors_first, always_specify_types

import 'dart:async';

import 'package:flutter/widgets.dart';

/// A class generated by flappy_translator package containing localized strings
class I18n {
  static String test({
    required String varint,
  }) =>
      _getText('test').replaceAll('%int\\\$s', varint);

  static late Map<String, String> _localizedValues;

  static const _enValues = {
    'test': 'Hello %int\\\$s!',
  };

  static const _allValues = {
    'en': _enValues,
  };

  I18n(Locale locale) {
    _locale = locale;
    _localizedValues = {};
  }

  static late Locale _locale;

  static String _getText(String key) =>
      _localizedValues[key] ?? '** \$key not found';

  static Locale get currentLocale => _locale;

  static String get currentLanguage => _locale.languageCode;

  static Future<I18n> load(Locale locale) async {
    final translations = I18n(locale);
    _localizedValues = _allValues[locale.toString()]!;
    return translations;
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  static final Set<Locale> supportedLocals = {
    Locale('en'),
  };

  @override
  bool isSupported(Locale locale) => supportedLocals.contains(locale);

  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);

  @override
  bool shouldReload(I18nDelegate old) => false;
}
''',
    );
  });

  test(
      'When comment generation is true, documentation style comments with translations are added',
      () {
    final codeGenerator = CodeGenerator();
    codeGenerator.setSupportedLanguages(['en', 'de', 'es']);
    codeGenerator.enableCommentGeneration();
    codeGenerator.addField(
        'test', 'Hello', ['Hello', 'Hello in german', 'Hello in spanish']);
    codeGenerator.finalize();

    expect(
      codeGenerator.formattedString,
      '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: public_member_api_docs, prefer_single_quotes, avoid_escaping_inner_quotes, prefer_const_constructors, sort_constructors_first, always_specify_types

import 'dart:async';

import 'package:flutter/widgets.dart';

/// A class generated by flappy_translator package containing localized strings
class I18n {
  /// * en: Hello
  /// * de: Hello in german
  /// * es: Hello in spanish
  String get test => _getText("test");

  static late Map<String, String> _localizedValues;

  static const _enValues = {
    "test": "Hello",
  };

  static const _deValues = {
    "test": "Hello in german",
  };

  static const _esValues = {
    "test": "Hello in spanish",
  };

  static const _allValues = {
    "en": _enValues,
    "de": _deValues,
    "es": _esValues,
  };

  I18n(Locale locale) : _locale = locale {
    _localizedValues = {};
  }

  final Locale _locale;

  static I18n of(BuildContext context) =>
      Localizations.of<I18n>(context, I18n)!;

  String _getText(String key) => _localizedValues[key] ?? '** \$key not found';

  Locale get currentLocale => _locale;

  String get currentLanguage => _locale.languageCode;

  static Future<I18n> load(Locale locale) async {
    final translations = I18n(locale);
    _localizedValues = _allValues[locale.toString()]!;
    return translations;
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  static final Set<Locale> supportedLocals = {
    Locale('en'),
    Locale('de'),
    Locale('es'),
  };

  @override
  bool isSupported(Locale locale) => supportedLocals.contains(locale);

  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);

  @override
  bool shouldReload(I18nDelegate old) => false;
}
''',
    );
  });

  test(
      'When when comment languages are supplied, only the selected languages are added to comments',
      () {
    final codeGenerator = CodeGenerator();
    codeGenerator.setSupportedLanguages(['en', 'de', 'es']);
    codeGenerator.enableCommentGeneration(['de', 'es']);
    codeGenerator.addField(
        'test', 'Hello', ['Hello', 'Hello in german', 'Hello in spanish']);
    codeGenerator.finalize();

    expect(
      codeGenerator.formattedString,
      '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: public_member_api_docs, prefer_single_quotes, avoid_escaping_inner_quotes, prefer_const_constructors, sort_constructors_first, always_specify_types

import 'dart:async';

import 'package:flutter/widgets.dart';

/// A class generated by flappy_translator package containing localized strings
class I18n {
  /// * de: Hello in german
  /// * es: Hello in spanish
  String get test => _getText("test");

  static late Map<String, String> _localizedValues;

  static const _enValues = {
    "test": "Hello",
  };

  static const _deValues = {
    "test": "Hello in german",
  };

  static const _esValues = {
    "test": "Hello in spanish",
  };

  static const _allValues = {
    "en": _enValues,
    "de": _deValues,
    "es": _esValues,
  };

  I18n(Locale locale) : _locale = locale {
    _localizedValues = {};
  }

  final Locale _locale;

  static I18n of(BuildContext context) =>
      Localizations.of<I18n>(context, I18n)!;

  String _getText(String key) => _localizedValues[key] ?? '** \$key not found';

  Locale get currentLocale => _locale;

  String get currentLanguage => _locale.languageCode;

  static Future<I18n> load(Locale locale) async {
    final translations = I18n(locale);
    _localizedValues = _allValues[locale.toString()]!;
    return translations;
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  static final Set<Locale> supportedLocals = {
    Locale('en'),
    Locale('de'),
    Locale('es'),
  };

  @override
  bool isSupported(Locale locale) => supportedLocals.contains(locale);

  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);

  @override
  bool shouldReload(I18nDelegate old) => false;
}
''',
    );
  });
}
