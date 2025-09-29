import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/theme/text_theme.dart';
import 'package:xlo_flutter_v2/src/core/utils/contants.dart';
import 'package:xlo_flutter_v2/src/core/widgets/ds_icon_button.dart';

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
      scaffoldBackgroundColor: AppColors.secondaryBackground,
      appBarTheme: _appBarTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _outlineButtonStyle(),
      ),
      textTheme: textTheme,
      actionIconTheme: _actionIconThemeData(),
    );
  }

  ActionIconThemeData _actionIconThemeData() {
    return ActionIconThemeData(
      backButtonIconBuilder:
          (context) =>
              DSIconButton(icon: Icons.arrow_back_ios_sharp, iconSize: 20),
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

    TextStyle errorStyle = TextTheme.of(context).bodySmall!.copyWith(
      fontFamily: fontFamily,
      color: AppColors.error,
      letterSpacing: 0.0,
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
      backgroundColor: AppColors.secondaryBackground,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.primaryText),
      centerTitle: false,
      titleTextStyle: const TextStyle(
        fontFamily: fontFamily,
        color: AppColors.primaryText,
        fontSize: 24,
        fontWeight: FontWeight.bold,
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
