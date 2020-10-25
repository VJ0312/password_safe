import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'Login.dart';

StreamController<bool> theme = StreamController();
StreamController<String> font = StreamController();

String fontType = 'Poppins';

bool darkTheme = false;

Future <bool> setTheme() async {
  darkTheme = !darkTheme;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("darkTheme", darkTheme);
  theme.add(!prefs.getBool("darkTheme"));
  return prefs.getBool("darkTheme");
}

Future <bool> getTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  darkTheme = prefs.getBool("darkTheme") ?? false;
  theme.add(!prefs.getBool("darkTheme"));
  return darkTheme;
}

Future <String> setFontType(_fontText) async {
  fontType = _fontText;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("fontType", fontType);
  font.add(fontType);
  return fontType;
}

Future <String>  getFontType() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  fontType = prefs.getString("fontType") ?? 'Poppins';
  font.add(prefs.getString("fontType"));
  return prefs.getString("fontType");
}

void main() async {
   runApp(MyApp());
}

class MyApp extends StatefulWidget {
  myApp createState() => myApp();
}

class myApp extends State<MyApp> {
  var s;
  void initState() {
    super.initState();
    getTheme();
    getFontType();
  }

  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData:  !darkTheme ?? false,
      stream: theme.stream,
      builder: (context, snap1) {
        return StreamBuilder <String>(
            initialData: fontType ?? 'Poppins',
            stream: font.stream,
            builder: (context, snap2) {
              return MaterialApp(
                theme: snap1.data ? ThemeData(fontFamily: fontType,
                    brightness: Brightness.light,
                    primaryColor: Colors.redAccent
                ) : ThemeData(fontFamily: fontType,
                    brightness: Brightness.dark,
                    primaryColor: Colors.redAccent
                ),
                debugShowCheckedModeBanner: false,
                home: HomeState(snap1),
              );
            }
        );
      },
    );
  }
}
