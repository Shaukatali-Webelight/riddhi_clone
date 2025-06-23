import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({
    required this.title,
    required this.chipColor,
    this.titleColor,
    this.borderRadius,
    super.key,
  });

  final String title;
  final Color? titleColor;
  final Color chipColor;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConst.k8, vertical: AppConst.k3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: borderRadius ??
            const BorderRadius.all(
              Radius.circular(AppConst.k4),
            ),
        color: chipColor,
      ),
      child: Text(
        title,
        style: AppStyles.getBoldStyle(
          fontSize: AppConst.k10,
          color: titleColor ?? AppColors.white,
        ),
      ),
    );
  }
}
