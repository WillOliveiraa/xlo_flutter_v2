import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/theme/text_theme.dart';
import 'package:xlo_flutter_v2/src/core/utils/contants.dart';

import './app_colors.dart';

class AppTheme {
  final BuildContext context;

  AppTheme(this.context);

  ThemeData buildAppTheme() {
    return ThemeData(
      fontFamily: fontFamily,
      primaryColor: AppColors.primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
      ),
      appBarTheme: _appBarTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _outlineButtonStyle(),
      ),
      textTheme: textTheme,
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    TextStyle labelStyle = TextTheme.of(context).labelMedium!.copyWith(
      fontFamily: fontFamily,
      color: AppColors.primaryColor,
      fontSize: 14,
      letterSpacing: 0.0,
    );

    TextStyle hintStyle = TextTheme.of(context).labelMedium!.copyWith(
      fontFamily: fontFamily,
      color: AppColors.black40,
      fontSize: 17,
      letterSpacing: 0.0,
      fontWeight: FontWeight.normal,
    );

    TextStyle errorStyle = TextTheme.of(context).bodyMedium!.copyWith(
      fontFamily: fontFamily,
      color: AppColors.error,
      fontSize: 15,
      letterSpacing: 0.0,
      // lineHeight: 1.2,
    );

    OutlineInputBorder enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderColor, width: 1),
      borderRadius: BorderRadius.circular(12),
    );

    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
      borderRadius: BorderRadius.circular(12),
    );

    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error, width: 1),
      borderRadius: BorderRadius.circular(12),
    );

    OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error, width: 1),
      borderRadius: BorderRadius.circular(12),
    );

    return InputDecorationTheme(
      contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 13, 16, 12),
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: focusedErrorBorder,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      errorStyle: errorStyle,
    );
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontFamily: fontFamily,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  ButtonStyle _outlineButtonStyle() {
    TextStyle textStyle = TextTheme.of(context).titleSmall!.copyWith(
      fontFamily: fontFamily,
      color: AppColors.secondaryBackground,
      fontSize: 18,
      letterSpacing: 0.0,
      fontWeight: FontWeight.bold,
      // lineHeight: 1.2,
    );

    return OutlinedButton.styleFrom(
      foregroundColor: AppColors.secondaryBackground,
      backgroundColor: AppColors.primaryColor,
      minimumSize: Size(double.infinity, 56),
      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      elevation: 0,
      textStyle: textStyle,
    );
  }
}
