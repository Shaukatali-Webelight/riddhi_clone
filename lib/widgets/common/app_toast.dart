import 'package:flutter/material.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class AppToast {
  factory AppToast() {
    return _instance;
  }

  AppToast._internal();
  static final AppToast _instance = AppToast._internal();

  static void showToast({
    required String message,
    required BuildContext context,
    ToastType toastType = ToastType.success,
    int? toastDuration,
  }) {
    FToast().init(context);
    FToast().removeQueuedCustomToasts();
    FToast().showToast(
      toastDuration: Duration(seconds: toastDuration ?? AppConst.k3.toInt()),
      gravity: ToastGravity.TOP,
      positionedToastBuilder: (context, child, gravity) => Positioned(
        top: AppConst.k60,
        left: AppConst.k12,
        right: AppConst.k12,
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            FToast().removeCustomToast();
          },
          child: child,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppConst.k12),
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(
            AppConst.k8,
          ),
        ),
        child: Text(
          message,
          style: AppStyles.getRegularStyle(),
        ),
      ),
    );
  }
}
