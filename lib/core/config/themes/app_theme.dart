import 'package:flutter/material.dart';
import '../../fonts/fonts.dart';

class AppTheme {
  static ThemeData get basic => ThemeData(
    // fontFamily: Font.poppins,
    scaffoldBackgroundColor: Colors.white,
    primaryColorDark: const Color.fromRGBO(111, 88, 255, 1),
    primaryColor: Colors.white,
    primaryColorLight: const Color.fromRGBO(159, 84, 252, 1),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
      color: Colors.white
    ),
    primarySwatch: Colors.blue,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: const Color(0xffFDBE44),
        ).merge(
          ButtonStyle(elevation: MaterialStateProperty.all(0)),
        )),
    canvasColor: Colors.white,
    cardColor: const Color.fromRGBO(38, 40, 55, 1),
  );

  static const MaterialColor colorMain = MaterialColor(
    0xffFFFFFF,
    <int, Color>{
      50: Color(0xFFE8F5E9),
      100: Color(0xFFC8E6C9),
      200: Color(0xFFA5D6A7),
      300: Color(0xFF81C784),
      400: Color(0xFF66BB6A),
      500: Color(0xFF66BB6A),
      600: Color(0xFF43A047),
      700: Color(0xFF388E3C),
      800: Color(0xFF2E7D32),
      900: Color(0xFF1B5E20),
    },
  );


}