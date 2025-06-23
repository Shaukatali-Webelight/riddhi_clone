// Flutter imports:
// Project imports:

import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({
    required this.title,
    required this.bgColor,
    required this.fontColor,
    super.key,
    this.onPressed,
    this.height,
    this.showLoader = false,
  });
  final void Function()? onPressed;
  final String title;
  final Color bgColor;
  final Color fontColor;
  final double? height;
  final bool showLoader;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: const WidgetStatePropertyAll(AppColors.grayLight),
          shadowColor: const WidgetStatePropertyAll(AppColors.transparent),
          backgroundColor: WidgetStatePropertyAll(bgColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConst.k8),
            ),
          ),
        ),
        child: showLoader
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.grayLight),
              )
            : Text(
                title,
                maxLines: 1,
                style: AppStyles.getRegularStyle(color: fontColor),
              ),
      ),
    );
  }
}
