import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/helpers/app_navigation.dart';
import 'package:riddhi_clone/widgets/common/will_pop_scope_widget.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({this.title, super.key});
  final String? title;

  void show() {
    showCupertinoDialog<void>(
      context: globalContext,
      builder: (context) => this,
    );
  }

  static void hide() {
    AppNavigation.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScopeWidget(
      canPop: false,
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        shape: LinearBorder.none,
        backgroundColor: AppColors.black.withValues(alpha: 0.2),
        child: Center(
          child: Card(
            color: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConst.k20),
            ),
            child: SizedBox(
              height: AppConst.k100,
              width: AppConst.k100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryLight),
                  ),
                  Text(
                    title ?? AppStrings.uploading,
                    textAlign: TextAlign.center,
                    style: AppStyles.getBoldStyle(
                      color: AppColors.white,
                      fontSize: AppConst.k14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
