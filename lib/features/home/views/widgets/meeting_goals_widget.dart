import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class MeetingGoalsWidget extends StatelessWidget {
  const MeetingGoalsWidget({this.progress, super.key});
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.k65,
      width: AppConst.width,
      padding: const EdgeInsets.symmetric(horizontal: AppConst.k12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(AppConst.k8),
        border: Border.all(
          color: AppColors.divider,
          width: 0.5,
        ),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // keeping static for now
            'Meeting Goals',
            style: AppStyles.getBoldStyle(fontSize: AppConst.k18),
          ),
          AppConst.gap8,
          Stack(
            children: [
              Container(
                height: AppConst.k8,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppConst.k30),
                ),
              ),
              Container(
                height: AppConst.k8,
                width: AppConst.width * (progress ?? 0.0),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppConst.k30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
