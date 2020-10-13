import 'package:flutter/material.dart';

Color accentColor = Colors.amber;

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final ThemeData kAndroidTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final ThemeData kAndroidDarkTheme = ThemeData(
  primarySwatch: Colors.lightGreen,
  brightness: Brightness.dark,
  accentColor: Colors.lightGreenAccent,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
