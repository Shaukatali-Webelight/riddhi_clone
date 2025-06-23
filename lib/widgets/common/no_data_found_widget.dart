import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message ?? AppStrings.noDataFoundForSearchResults,
        style: AppStyles.getMediumStyle(
          fontSize: AppConst.k18,
          color: AppColors.primary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
