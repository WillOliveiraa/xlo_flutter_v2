import 'package:flutter/material.dart';

import './app_colors.dart';

final appTheme = ThemeData(
  fontFamily: 'NotoSans',
  primaryColor: AppColors.kPrimaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.kPrimaryColor,
    primary: AppColors.kPrimaryColor,
    secondary: AppColors.kSecondaryColor,
  ),
  appBarTheme: appBarTheme(),
  inputDecorationTheme: inputDecorationTheme(),
);

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: AppColors.kTextColor),
  );
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    backgroundColor: AppColors.kPrimaryColor,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  );
}
