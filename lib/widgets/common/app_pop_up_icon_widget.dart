import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';

class AppPopUpIconWidget extends StatelessWidget {
  const AppPopUpIconWidget({required this.image, super.key});

  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConst.horizontalPadding.copyWith(top: AppConst.k16),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: AppColors.primaryLight,
        child: CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.primary,
          child: image,
        ),
      ),
    );
  }
}
