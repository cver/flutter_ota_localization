import 'dart:async';
import 'dart:convert';

import 'package:flutter_ota_localization/l10n_data_model.dart';
import 'package:http/http.dart' as http;

final _json = '''{
  "en": {
    "helloWorld": {
      "message": "Hello World! OTA",
      "description": "Description",
      "placeholders": {}
    }
  },
  "es": {
    "helloWorld": {
      "message": "B Hola Mundo! OTA",
      "description": "Description",
      "placeholders": {}
    }
  }
}''';

Future<String> _fetchL10nResponseBody() async {
  final response = await http.get(Uri.http('localhost:3006', 'l10n'));
  if (response.statusCode >= 200 && response.statusCode <= 299) {
    return response.body;
  }
  throw 'Error HTTP status code ${response.statusCode}';
}

Future<String> _fakeL10nResponseBody() async {
  await Future.delayed(Duration(seconds: 2));
  return Future.value(_json);
}

Future<L10nData> fetchL10n() async {
  try {
    final responseBody = await _fetchL10nResponseBody();
    // final responseBody = await _fakeL10nResponseBody();
    final parsed = jsonDecode(responseBody).cast<String, dynamic>();
    final data = parsed.map((key, value) => MapEntry(
      key,
      (value as Map<String, dynamic>).map((key, value) => MapEntry(
        key,
        Label.fromJson(value),
      )),
    )).cast<String, Map<String, Label>>();
    print(data);
    final fetchingTime = DateTime.now();
    return L10nData(data, fetchingTime);
  } catch (e) {
    print(e);
    return L10nData(const {}, DateTime.now());
  }
}
