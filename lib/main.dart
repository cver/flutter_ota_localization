import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ota_localization/app_l10n.dart';
import 'package:flutter_ota_localization/fetcher.dart';
import 'package:flutter_ota_localization/l10n_data_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');
  L10nData _l10nData;
  bool _isLoading = false;

  @override
  void initState() {
    _onReload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter L10n OTA Demo',
      locale: _locale,
      localizationsDelegates: [
        AppLocalizationsDelegate(_l10nData),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        onChange: _onChange,
        onReload: _onReload,
        isLoading: _isLoading,
      ),
    );
  }

  Future<void> _onReload() async {
    setState(() {
      _isLoading = true;
    });

    final data = await fetchL10n();

    setState(() {
      _isLoading = false;
      this._l10nData = data;
    });
  }

  void _onChange(String locale) {
    setState(() {
      _locale = Locale(locale);
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.onReload, this.onChange, this.isLoading});

  final VoidCallback onReload;
  final Function(String) onChange;
  final bool isLoading;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).helloWorld),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: widget.isLoading,
              child: CircularProgressIndicator(),
            ),
            TextButton(
              onPressed: () => widget.onChange('en'),
              child: Text('EN'),
            ),
            TextButton(
              onPressed: () => widget.onChange('es'),
              child: Text('ES'),
            ),
            TextButton(
              onPressed: widget.onReload,
              child: Text('RELOAD'),
            ),
            Text(AppLocalizations.of(context).helloWorld),
          ],
        ),
      ),
    );
  }
}
