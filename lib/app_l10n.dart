import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ota_localization/l10n/generated/messages_all.dart';
import 'package:flutter_ota_localization/l10n_data_model.dart';
import 'package:flutter_ota_localization/message_lookup_proxy.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('es')];

  String get helloWorld =>
      Intl.message('Hello world', name: 'helloWorld', args: [], desc: 'Hello world message');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate(this._l10nData);

  final L10nData _l10nData;

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    injectMessageLookupProxy(_l10nData?.data);

    final String name = locale.countryCode?.isEmpty ?? true ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return _l10nData != null && old?._l10nData?.fetchingTime != _l10nData.fetchingTime;
  }
}
