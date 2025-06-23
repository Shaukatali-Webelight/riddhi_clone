import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MonthRangePicker {
  static void pickMonths(
    BuildContext context,
    TextEditingController monthController,
    DateRangePickerController controller,
    void Function(DateTime start, DateTime end)? onRangeSelected,
  ) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: AppConst.width * 0.8,
            height: AppConst.height * 0.35,
            child: SfDateRangePicker(
              viewSpacing: 160,
              rangeTextStyle: AppStyles.getRegularStyle(
                fontSize: AppConst.k16,
              ),
              selectionTextStyle: AppStyles.getRegularStyle(
                color: AppColors.white,
                fontSize: AppConst.k16,
              ),
              headerStyle: DateRangePickerHeaderStyle(
                textStyle: AppStyles.getRegularStyle(
                  fontSize: AppConst.k16,
                ),
              ),
              yearCellStyle: DateRangePickerYearCellStyle(
                textStyle: AppStyles.getRegularStyle(
                  fontSize: AppConst.k16,
                ),
                todayTextStyle: AppStyles.getRegularStyle(
                  color: AppColors.primary,
                ),
              ),
              onCancel: () {
                Navigator.of(context).pop();
              },
              onSubmit: (p0) {
                if (controller.selectedRange?.startDate != null && controller.selectedRange?.endDate != null) {
                  final selectedRange = controller.selectedRange;
                  if (selectedRange != null) {
                    final startDate = selectedRange.startDate;
                    final endDate = selectedRange.endDate;
                    final dateFormat = DateFormat('MMM yyyy');
                    final formattedRange = '${dateFormat.format(startDate!)} - ${dateFormat.format(endDate!)}';
                    monthController.text = formattedRange;
                    LogHelper.logCyan('Selected Month:${monthController.text}');
                  }

                  if (onRangeSelected != null) {
                    onRangeSelected(
                      controller.selectedRange!.startDate!,
                      controller.selectedRange!.endDate!,
                    );
                  }
                  Navigator.pop(context);
                }
              },
              startRangeSelectionColor: AppColors.primary,
              endRangeSelectionColor: AppColors.primary,
              todayHighlightColor: AppColors.primary,
              selectionColor: AppColors.primary,
              showActionButtons: true,
              controller: controller,
              view: DateRangePickerView.year,
              minDate: DateTime(2000),
              maxDate: DateTime(2099, 12, 31),
              allowViewNavigation: false,
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  final selectedRange = args.value as PickerDateRange;
                  controller.selectedRange = selectedRange;
                }
              },
            ),
          ),
        );
      },
    );
  }
}
