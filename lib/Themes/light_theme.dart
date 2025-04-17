import 'package:flutter/material.dart';

/// 🌟 LIGHT THEME
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue, // Colore principale
  scaffoldBackgroundColor: Colors.white, // Sfondo principale
  secondaryHeaderColor: Colors.teal, // Colore secondario
  cardColor: Colors.blueGrey[50], // Sfondo delle card

  appBarTheme: AppBarTheme(
    color: Colors.blue, // Sfondo AppBar
    foregroundColor: Colors.white, // Testo e icone AppBar
    elevation: 4,
    titleTextStyle: TextStyle(
      color: Colors.white, // Assicura visibilità del titolo
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.blue),
      backgroundColor: WidgetStateProperty.all(Colors.blueGrey[100]),
    ),
  ),

  iconTheme: IconThemeData(color: Colors.blue),

  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),

  textTheme: TextTheme(
    labelLarge: TextStyle(color: Colors.blue, fontSize: 30),
    titleLarge: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: Colors.blue,
          width: 4.0,
        ),
      ),
      elevation: 0,
    ),
  ),

  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.blue[50],
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    ),
    textStyle: TextStyle(color: Colors.black, fontSize: 18),
  ),
);
