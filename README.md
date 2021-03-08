# Flutter OTA Localization example

## Libraries

- [Flutter Intl](https://pub.dev/packages/intl)
- [Intl Translation](https://pub.dev/packages/intl_translation)

## Backend implementation

- Endpoint get Json

## Frontend implementation

### MessageLookup

- Create class `AppMessageLookupProxy` extends `MessageLookup`
- Override `lookupMessage` function to get string from json which was fetched from Backend

### AppLocalizations

- Run command `intl_translation:generate_from_arb` to generate language file (.dart)

### AppLocalizationsDelegate

- `shouldReload` : compare request time, if having new request => return `true` to trigger reload
- `load` : inject `AppMessageLookupProxy` to `package:intl/src/intl_helpers.dart` . `messageLookup`

### Main

- `MaterialApp.locale` <- initial locale, set it in future if need to change locale
- `MaterialApp.localizationsDelegates` <- pass `AppLocalizationsDelegate` with dynamic l10n data, set it in future if need to reload translation strings

## Ref

- https://flutter.dev/docs/development/accessibility-and-localization/internationalization
- http://site.icu-project.org/
