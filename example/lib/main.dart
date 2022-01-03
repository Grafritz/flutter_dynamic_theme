import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_dynamic_theme/flutter_dynamic_theme.dart';
import 'package:flutter_dynamic_theme/theme_switcher_widgets.dart';
import 'package:flutter_dynamic_theme/color_theme_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await FlutterDynamicTheme.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterDynamicTheme(
      defaultBrightness: Brightness.light,
      data: (Brightness brightness) => ThemeData(
        primarySwatch: Colors.indigo,
        brightness: brightness,
      ),
      loadBrightnessOnStart: true,
      themedWidgetBuilder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          title: 'F Dynamic Theme [ $_platformVersion ]',
          theme: theme,
          home: MyHomePage(title: 'Flutter Dynamic Theme [ $_platformVersion ]'),
        );
      },
    );
    /*return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );*/
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: FlutterDynamicTheme.of(context)?.toggleBrightness,
              child: const Text('Toggle brightness'),
            ),
            ElevatedButton(
              onPressed: showChooser,
              child: const Text('Pop Up Change brightness'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: showActionsSettingsColorTheme,
              child: const Text('Change color'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file),
            label: 'Tab 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Tab 2',
          ),
        ],
      ),
    );
  }

  showActionsSettingsColorTheme() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return const ColorThemeDialog();
        });
  }
  void showChooser() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BrightnessSwitcherDialog(
          activeToggleMode: true,
          activeColor: true,
          textDarkMode: 'Mode Dark :(',
          textLightMode: 'Light Mode :)',
          onSelectedTheme: (Brightness brightness) {
            FlutterDynamicTheme.of(context)?.setBrightness(brightness);
          },
        );
      },
    );
  }
}