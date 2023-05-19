import 'package:flutter/material.dart';

import '../mock_data/mock_theme_model.dart';
import 'colors/red_theme_color.dart';

class Mythemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xfff232446),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary:ThemeModel().mockTheme['app_bar']==null?    Colors.blue: Color(int.parse(ThemeModel().mockTheme['app_bar'].toString())),
      onPrimary: Colors.white,
      secondary: Colors.green,
      onSecondary: Colors.white,
      primaryContainer: Color(0xfff747d8),
      secondaryContainer: Color(0xfff11616),
      error: Color.fromARGB(255, 233, 74, 74),
      onError: Colors.white,
      background: Colors.blue,
      onBackground: Colors.white,
      surface: Color(0xff0c1542),
      onSurface: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xfff161933),
        selectedItemColor: Colors.black,
        unselectedItemColor: Color.fromARGB(255, 211, 213, 212)),
    // colorScheme: ColorScheme.dark(),
    textTheme: const TextTheme(

        //
        // bodySmall: GoogleFonts.montserrat(
        //   color: Color.fromARGB(255, 255, 255, 255),
        //   fontSize: 13,
        // ),
        ),
  );
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,
        brightness: Brightness.light,
        primary: Colors.blue,
      onPrimary: Colors.white,
      secondary: Colors.green,
      onSecondary: Colors.white,
      primaryContainer: Color(0xfff747d8f),
      secondaryContainer: Color(0xfff1e8d8f),
      error: Color.fromARGB(255, 233, 74, 74),
      onError: Colors.white,
      background: Colors.blue,
      onBackground: Colors.white,
      surface: Color(0xff0c1542),
      onSurface: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 128, 223, 255),
        selectedItemColor: Colors.black,
        unselectedItemColor: Color.fromARGB(255, 183, 185, 184)),

    textTheme: const TextTheme(),

    // colorScheme: ColorScheme.light(),
  );


}
