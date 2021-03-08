import 'package:flutter_ota_localization/l10n_data_model.dart';
import 'package:intl/intl.dart';

// ignore_for_file:implementation_imports
import 'package:intl/src/intl_helpers.dart';
import 'package:intl/message_lookup_by_library.dart';

void injectMessageLookupProxy(Map<String, Map<String, Label>> data) {
  messageLookup = AppMessageLookupProxy(data ?? const {});
}

MessageLookup _getDefaultMessageLookup() {
  if (messageLookup is UninitializedLocaleData) {
    return CompositeMessageLookup();
  } else if (messageLookup is AppMessageLookupProxy) {
    return (messageLookup as AppMessageLookupProxy).defaultMessageLookup;
  } else {
    return messageLookup;
  }
}

class AppMessageLookupProxy implements MessageLookup {
  AppMessageLookupProxy(Map<String, Map<String, Label>> data):
        this.defaultMessageLookup = _getDefaultMessageLookup(),
        this._data = data ?? const {};

  final MessageLookup defaultMessageLookup;
  final Map<String, Map<String, Label>> _data;

  @override
  void addLocale(String localeName, Function findLocale) {
    defaultMessageLookup.addLocale(localeName, findLocale);
  }

  @override
  String lookupMessage(String messageText, String locale, String name, List<Object> args, String meaning, {ifAbsent}) {
    print('[LOOKUP] messageText: $messageText, locale: $locale, name: $name, args: $args, meaning: $meaning, ifAbsent: $ifAbsent');

    try {
      final currentLocale = locale ?? Intl.getCurrentLocale();
      final localeData = _data[currentLocale];
      if (localeData == null) {
        throw 'localeData == null';
      }
      final label = localeData[name];
      if (label?.message == null) {
        throw 'label?.message == null';
      }
      print('locale: $currentLocale, msg: ${label.message}');
      return label.message;
    } catch (e) {
      print(e);
      return defaultMessageLookup.lookupMessage(messageText, locale, name, args, meaning, ifAbsent: ifAbsent);
    }
  }
}