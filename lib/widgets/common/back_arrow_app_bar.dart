import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/assets.gen.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_semantic_labels.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/helpers/app_navigation.dart';
import 'package:riddhi_clone/widgets/common/app_divider.dart';
import 'package:riddhi_clone/widgets/common/tooltip_widget.dart';

class BackArrowAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackArrowAppBar({
    required this.title,
    super.key,
    this.onBackPressed,
    this.actions,
    this.isViewDetailsPage = false,
    this.backArrowEnable = true,
    this.centerTitle,
    this.isRspScreen,
  });

  final String title;
  final void Function()? onBackPressed;
  final bool isViewDetailsPage;
  final List<Widget>? actions;
  final bool backArrowEnable;
  final bool? centerTitle;
  final bool? isRspScreen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: AppDivider(
          height: AppConst.k0,
          dividerColor: AppColors.divider.withValues(alpha: 0.4),
        ),
      ),
      shadowColor: AppColors.divider,
      surfaceTintColor: AppColors.white,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      leading: backArrowEnable
          ? IconButton(
              icon: AppAssets.icons.backArrow.svg(
                semanticsLabel: AppSemanticLabels.backArrow,
                colorFilter: const ColorFilter.mode(AppColors.primaryText, BlendMode.srcIn),
              ),
              onPressed: onBackPressed ?? AppNavigation.back,
            )
          : null,
      leadingWidth: AppConst.k50,
      titleSpacing: backArrowEnable ? AppConst.k0 : AppConst.k16,
      centerTitle: centerTitle ?? true,
      title: isRspScreen ?? false
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TooltipWidget(
                  message: title,
                  child: Text(
                    title,
                    style: AppStyles.getBoldStyle(
                      color: AppColors.primaryText,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: AppConst.k1.toInt(),
                  ),
                ),
                AppConst.gap8,
                // const DemoChipWidget(
                //   title: AppStrings.revised,
                //   bgColor: AppColors.primaryText,
                //   textColor: AppColors.white,
                //   borderColor: AppColors.primaryText,
                // ),
              ],
            )
          : TooltipWidget(
              message: title,
              child: Text(
                title,
                style: AppStyles.getBoldStyle(
                  color: AppColors.primaryText,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: AppConst.k1.toInt(),
              ),
            ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
