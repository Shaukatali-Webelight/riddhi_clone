// Flutter imports:

import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

// Project imports:

class LoaderPage extends StatelessWidget {
  const LoaderPage({
    super.key,
    this.onRetry,
    this.hasError = false,
    this.errorMessage,
    this.tryAgainText,
    this.wentWrongIcon,
  });
  final void Function()? onRetry;
  final bool hasError;
  final String? errorMessage;
  final String? tryAgainText;
  final Widget? wentWrongIcon;

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (wentWrongIcon != null) ...[
              wentWrongIcon ?? const SizedBox.shrink(),
              const SizedBox(height: AppConst.k16),
            ],
            Padding(
              padding: const EdgeInsets.all(AppConst.k16),
              child: Text(
                errorMessage ?? AppStrings.somethingWentWrong,
                maxLines: AppConst.k4.toInt(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppStyles.getMediumStyle(
                  fontSize: AppConst.k18,
                  color: AppColors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: onRetry,
              style: TextButton.styleFrom(
                shape: const StadiumBorder(
                  side: BorderSide(color: AppColors.primary),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConst.k10),
                child: Text(
                  tryAgainText ?? AppStrings.retry,
                  style: AppStyles.getMediumStyle(
                    fontSize: AppConst.k18,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColors.primary),
          ),
          const SizedBox(height: AppConst.k5),
          Text(
            AppStrings.loading,
            style: AppStyles.getMediumStyle(
              fontSize: AppConst.k18,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
