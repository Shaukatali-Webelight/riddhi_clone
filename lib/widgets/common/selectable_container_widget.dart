import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class SelectableContainerWidget extends StatelessWidget {
  const SelectableContainerWidget({
    required this.text,
    required this.isSelected,
    super.key,
    this.onTap,
  });

  final String text;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Durations.medium4,
        padding: const EdgeInsets.symmetric(horizontal: AppConst.k12, vertical: AppConst.k8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.secondaryText,
            width: 0.5,
          ),
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(AppConst.k8),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: isSelected
              ? AppStyles.getRegularStyle(
                  color: AppColors.white,
                )
              : AppStyles.getLightStyle(
                  fontSize: AppConst.k14,
                ),
        ),
      ),
    );
  }
}
