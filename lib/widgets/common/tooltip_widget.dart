import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class TooltipWidget extends StatelessWidget {
  const TooltipWidget({super.key, this.child, this.message, this.triggerMode});
  final Widget? child;
  final String? message;
  final TooltipTriggerMode? triggerMode;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: triggerMode ?? TooltipTriggerMode.tap,
      message: message,
      padding: const EdgeInsets.all(AppConst.k16),
      margin: const EdgeInsets.symmetric(horizontal: AppConst.k50),
      textStyle: AppStyles.getRegularStyle(),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppConst.k8),
      ),
      preferBelow: true,
      verticalOffset: AppConst.k20,
      child: child,
    );
  }
}
