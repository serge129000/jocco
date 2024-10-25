import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';

class Themes {
  static ThemeData appTheme = ThemeData(
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: const OutlineInputBorder(
          //gapPadding: 5.67,
          borderSide: BorderSide(
            color: PrimaryColors.first,
            //width: 1.5
          )
        ),
        border: OutlineInputBorder(
          //gapPadding: 5.67,
          borderSide: BorderSide(
            color: borderColor,
            //width: 1.5
          )
        ),
        errorBorder: OutlineInputBorder(
          //gapPadding: 5.67,
          borderSide: BorderSide(
            color: borderColor,
            //width: 1.5
          )
        ),
        enabledBorder: OutlineInputBorder(
          //gapPadding: 5.67,
          borderSide: BorderSide(
            color: borderColor,
            //width: 1.5
          )
        ),
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontFamily: 'Branding', fontSize: 18),
        bodyLarge: TextStyle(fontFamily: 'Branding', fontSize: 35),
        bodyMedium: TextStyle(fontFamily: 'Branding', fontSize: 28),       
        labelLarge: TextStyle(fontFamily: 'Branding', fontSize: 17),
        labelMedium: TextStyle(fontFamily: 'Branding', fontSize: 17),
        labelSmall: TextStyle(fontFamily: 'Branding', fontSize: 17),
      ));
}
