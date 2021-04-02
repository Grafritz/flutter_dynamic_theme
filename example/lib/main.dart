import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_dynamic_theme/dynamic_colors.dart';
import 'package:flutter_dynamic_theme/flutter_dynamic_theme.dart';
import 'package:flutter_dynamic_theme/theme_switcher_widgets.dart';
import 'package:flutter_dynamic_theme/color_theme_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          title: 'Flutter Demo',
          theme: theme,
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Color _primarySwatch = DynamicColors.primaryColor[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Dynamic Theme'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: FlutterDynamicTheme.of(context).toggleBrightness,
              child: const Text('Toggle brightness'),
            ),
            ElevatedButton(
              onPressed: showChooser,
              child: const Text('Pop Up Change brightness'),
            ),
            Divider(),
            ElevatedButton(
              onPressed: showActionsSettingsColorTheme,
              child: const Text('Change color'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
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
          return ColorThemeDialog();
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
            FlutterDynamicTheme.of(context).setBrightness(brightness);
          },
        );
      },
    );
  }
}