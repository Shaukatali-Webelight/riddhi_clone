import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';

class CardComponentWidget extends StatelessWidget {
  const CardComponentWidget({super.key, this.width, this.height, this.padding, this.child});

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? AppConst.width,
      height: height,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: AppConst.k12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConst.k8),
        border: Border.all(
          color: AppColors.divider,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 4,
          ),
        ],
        color: AppColors.white,
      ),
      child: child,
    );
  }
}
