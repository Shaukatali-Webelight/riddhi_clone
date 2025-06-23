// Flutter imports:
// Project imports:

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Package imports:
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_date_formats.dart';
import 'package:riddhi_clone/constants/app_strings.dart';

class DatePicker {
  static final BuildContext _context = NavigationService.context;
  static Future<void> showDatePickerCustom(
    TextEditingController controller, {
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
  }) async {
    DateTime? preSelectedDate;
    if (controller.text.isNotEmpty) {
      try {
        preSelectedDate = DateFormat(AppDateFormats.ddMMyyyy).parse(controller.text);
      } catch (e) {
        LogHelper.logError('Error parsing date: $e');
      }
    }
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      cancelText: AppStrings.cancel,
      confirmText: AppStrings.ok,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
            datePickerTheme: DatePickerThemeData(
              //* Today's date styling
              todayForegroundColor: WidgetStateProperty.all(AppColors.primary),
              todayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
              todayBorder: const BorderSide(color: AppColors.primary),
            ),
          ),
          child: child ?? Container(),
        );
      },
      context: _context,
      initialDate: preSelectedDate ?? initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(now.year, now.month, now.day + 6),
    );

    if (selectedDate != null) {
      final formattedDate = DateFormat(AppDateFormats.ddMMyyyy).format(selectedDate);
      controller.text = formattedDate;
    }
  }
}
