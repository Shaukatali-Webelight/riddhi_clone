import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class CommonBottomSheetContainerWidget extends StatelessWidget {
  const CommonBottomSheetContainerWidget({required this.text, super.key, this.onTap, this.isSelected});

  final String text;
  final void Function()? onTap;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppConst.width,
        padding: const EdgeInsets.all(AppConst.k12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConst.k8),
          border: Border.all(
            color: isSelected ?? false ? AppColors.primary : AppColors.divider,
            width: 0.5,
          ),
          color: AppColors.white,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppStyles.getBoldStyle(
            fontSize: AppConst.k14,
            color: isSelected ?? false ? AppColors.primary : AppColors.primaryText,
          ),
        ),
      ),
    );
  }
}
