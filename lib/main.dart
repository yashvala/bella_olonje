import 'package:bella_olonje/view/splash_screen.dart';
import 'package:flutter/material.dart';

import 'view/home_screen.dart';

void main() {
  runApp(new MaterialApp(
    theme: appTheme,
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new HomeScreen()
    },
  ));
}

ThemeData appTheme = ThemeData(
  fontFamily: 'Poppins',
  primaryColor: Color(0xff003649),
  accentColor: Color(0xffF89630),
);
