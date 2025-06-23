// Flutter imports:
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/features/auth/controllers/auth_state_notifier.dart';
import 'package:riddhi_clone/features/auth/views/auth_screen.dart';
// Project imports:

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
    this.phoneNumber,
  });

  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authStateNotifierProvider);
        final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
        return GestureDetector(
          onTap: authState.isLoading
              ? null
              : () {
                  authStateNotifier.resetPasswordError();
                  NavigationHelper.navigatePushRemoveUntil(
                    route: AuthScreen(
                      phoneNumber: phoneNumber,
                    ),
                  );
                },
          child: Container(
            padding: EdgeInsets.only(bottom: Platform.isIOS ? AppConst.k0 : AppConst.bottomPadding + AppConst.k10),
            height: AppConst.k40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                  size: AppConst.k20,
                ),
                AppConst.gap5,
                Text(
                  AppStrings.backToLogin,
                  style: AppStyles.getRegularStyle(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
