import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class ChartLabelWidget extends StatelessWidget {
  const ChartLabelWidget({
    required this.color,
    required this.text,
    super.key,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppConst.k12,
          height: AppConst.k12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppConst.k2),
          ),
        ),
        AppConst.gap4,
        Text(
          text,
          style: AppStyles.getLightStyle(
            fontSize: AppConst.k12,
            color: AppColors.grayMid,
          ),
        ),
      ],
    );
  }
}
