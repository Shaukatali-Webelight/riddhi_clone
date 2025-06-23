import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_semantic_labels.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class ButtonWithArrowWidget extends StatelessWidget {
  const ButtonWithArrowWidget({required this.title, super.key, this.onTap, this.padding, this.buttonColor, this.style});

  final String title;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? buttonColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: AppConst.k8, vertical: AppConst.k13),
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(AppConst.k6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppConst.gap10,
            Text(
              title,
              style: style ??
                  AppStyles.getBoldStyle(
                    color: AppColors.white,
                    fontSize: AppConst.k16,
                  ),
            ),
            AppConst.gap4,
            const Icon(
              Icons.arrow_right_outlined,
              color: AppColors.white,
              semanticLabel: AppSemanticLabels.arrowRight,
            ),
          ],
        ),
      ),
    );
  }
}
