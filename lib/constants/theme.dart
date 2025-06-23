// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:riddhi_clone/config/assets/colors.gen.dart';

class AppTheme {
  //! LIGHT THEME
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBg,
    appBarTheme: const AppBarTheme(
      color: AppColors.white,
      elevation: 0,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryText,
      selectionColor: AppColors.primaryLight,
      selectionHandleColor: AppColors.primary,
    ),
  );

  //! DARK THEME
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      color: AppColors.primary,
      elevation: 0,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryText,
      selectionColor: AppColors.primaryLight,
      selectionHandleColor: AppColors.primary,
    ),
  );
}
