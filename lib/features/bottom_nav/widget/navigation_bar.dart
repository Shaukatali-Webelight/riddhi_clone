import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/features/bottom_nav/widget/body_widget.dart';
import 'package:riddhi_clone/features/bottom_nav/widget/navigation_bar_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
    this.dotIndicatorColor,
    this.marginR = const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
    this.paddingR = const EdgeInsets.only(bottom: 5, top: 10),
    this.borderRadius = 100,
    this.splashBorderRadius,
    this.backgroundColor = AppColors.primary,
    this.boxShadow = const [
      BoxShadow(
        color: AppColors.transparent,
      ),
    ],
    this.enablePaddingAnimation = true,
    this.splashColor,
    super.key,
    this.bottomNavWidth,
  });

  final List<NavigationBarItem> items;
  final int currentIndex;
  final void Function(int)? onTap;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final EdgeInsets margin;
  final EdgeInsets itemPadding;
  final Duration duration;
  final Curve curve;
  final Color? dotIndicatorColor;
  final EdgeInsetsGeometry? marginR;
  final EdgeInsetsGeometry? paddingR;
  final double? borderRadius;
  final Color? backgroundColor;
  final List<BoxShadow> boxShadow;
  final bool enablePaddingAnimation;
  final Color? splashColor;
  final double? splashBorderRadius;
  final double? bottomNavWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius!),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.2),
            blurRadius: AppConst.k4,
          ),
        ],
      ),
      margin: margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: marginR!,
            child: Container(
              padding: paddingR,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius!),
                color: backgroundColor,
                boxShadow: boxShadow,
              ),
              width: bottomNavWidth ?? AppConst.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConst.k4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConst.k8),
                  child: NavigationBodyWidget(
                    items: items,
                    currentIndex: currentIndex,
                    curve: curve,
                    duration: duration,
                    selectedItemColor: selectedItemColor,
                    theme: theme,
                    unselectedItemColor: unselectedItemColor,
                    onTap: onTap!,
                    itemPadding: itemPadding,
                    dotIndicatorColor: dotIndicatorColor,
                    enablePaddingAnimation: enablePaddingAnimation,
                    splashColor: splashColor,
                    splashBorderRadius: splashBorderRadius,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
