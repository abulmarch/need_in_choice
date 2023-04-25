import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';





class ThemeDataPrimary{
  static ThemeData primaryTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF909090),
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      selectedLabelStyle: TextStyle(color: Color(0xFF909090),fontSize: 13),

      unselectedItemColor: Color(0xFF909090),
      unselectedIconTheme: IconThemeData(color: Color(0xFFC4C4C4)),
      unselectedLabelStyle: TextStyle(color: Color(0xFF909090),fontSize:12)
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kPrimaryColor,      
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      )
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Color(0xFFF5F5F5),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1.5,color: Color(0xFFCACACA)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1.5, color: kPrimaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1.5,color: Color(0xFFCACACA)),
      ),
      hintStyle: TextStyle(color: Color(0xFFBCBCBC),fontFamily: kHintTextFontFamily),
      prefixIconColor: Colors.black,
    ),
    
    scaffoldBackgroundColor: kOffWhiteColor,
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        color: kPrimaryColor,
        fontSize: 21,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: kWhiteColor,
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        color: kLightGreyColor,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      displayLarge: TextStyle(
        color: kWhiteColor,
        fontSize: 27,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: TextStyle(
        color: kWhiteColor,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      )
    ),
  );
}