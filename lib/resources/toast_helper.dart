// Package imports:
import 'package:flutter/material.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/features/common/models/failure_model.dart';
import 'package:toastification/toastification.dart';
// Project imports:

class AppToastHelper {
  AppToastHelper._();
  static void showError(String message) {
    _showToast(message, ToastificationType.error);
  }

  static void showSuccess(String message) {
    _showToast(message, ToastificationType.success);
  }

  static void showInfo(String message) {
    _showToast(message, ToastificationType.info);
  }

  static void _showToast(String message, ToastificationType? type) {
    toastification
      ..dismissAll()
      ..show(
        type: type,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 300),
        showProgressBar: false,
        description: Text(
          message,
          style: AppStyles.getRegularStyle(color: AppColors.primaryText),
          maxLines: AppConst.k5.toInt(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.topCenter,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      );
  }
}

class AppErrorHandler {
  AppErrorHandler._();

  static void showError(Failure failure) {
    failure.statusCode == StatusCode.UNAUTHORIZED.value
        ? AppToastHelper.showError(AppStrings.sessionExpired)
        : AppToastHelper.showError(failure.message);
  }
}
