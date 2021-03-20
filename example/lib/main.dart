import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_dynamic_theme/dynamic_colors.dart';
import 'package:flutter_dynamic_theme/flutter_dynamic_theme.dart';
import 'package:flutter_dynamic_theme/theme_switcher_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterDynamicTheme(
      defaultBrightness: Brightness.light,
      data: (Brightness brightness) => ThemeData(
        primarySwatch: Colors.purple,
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
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.1, 0.8],
                        colors: [Theme.of(context).primaryColor, Colors.black ]),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Text( 'Color Theme', style: TextStyle(color: Colors.white),),
                      Spacer(),
                      Icon(Icons.close),
                    ],
                  )
              ),
              titlePadding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0, bottom: 0),
              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0, bottom: 0),
              content:
              Container(
                width: double.maxFinite,
                height: 300.0,
                child: ListView.builder(shrinkWrap: true,
                    itemCount: DynamicColors.primaryColor.length,
                    itemBuilder: (BuildContext context, int i){
                      return ListTile(
                        leading: Container(
                          decoration: BoxDecoration( borderRadius: BorderRadius.circular(20), color: DynamicColors.primaryColor[i],),
                          width: 34, height: 34,),
                        title: Text('${DynamicColors.primaryColorStr[i].toString().toUpperCase()}',),
                        trailing: Icon(Icons.color_lens),
                        onTap: () {
                          setState(() {
                            _primarySwatch = DynamicColors.primaryColor[i];
                            FlutterDynamicTheme.of(context).setThemeData(new ThemeData(primarySwatch: _primarySwatch, ));
                          });
                          Navigator.pop(context);
                        },
                      );
                    }
                ),
              )
          );
        });
  }
  void showChooser() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BrightnessSwitcherDialog(
          onSelectedTheme: (Brightness brightness) {
            FlutterDynamicTheme.of(context).setBrightness(brightness);
          },
        );
      },
    );
  }

  void changeColor() {
    FlutterDynamicTheme.of(context).setThemeData(
      ThemeData(
        primaryColor: Theme.of(context).primaryColor == Colors.indigo
            ? Colors.red
            : Colors.indigo,
      ),
    );
  }
}