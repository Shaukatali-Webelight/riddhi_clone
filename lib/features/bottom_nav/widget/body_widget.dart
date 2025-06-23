import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/features/bottom_nav/widget/navigation_bar_item.dart';

class NavigationBodyWidget extends StatelessWidget {
  const NavigationBodyWidget({
    required this.items,
    required this.currentIndex,
    required this.curve,
    required this.duration,
    required this.selectedItemColor,
    required this.theme,
    required this.unselectedItemColor,
    required this.onTap,
    required this.itemPadding,
    required this.dotIndicatorColor,
    required this.enablePaddingAnimation,
    this.splashBorderRadius,
    this.splashColor,
    super.key,
  });

  final List<NavigationBarItem> items;
  final int currentIndex;
  final Curve curve;
  final Duration duration;
  final Color? selectedItemColor;
  final ThemeData theme;
  final Color? unselectedItemColor;
  final void Function(int index) onTap;
  final EdgeInsets itemPadding;
  final Color? dotIndicatorColor;
  final bool enablePaddingAnimation;
  final Color? splashColor;
  final double? splashBorderRadius;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppConst.k8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.map((item) {
            final index = items.indexOf(item);

            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap.call(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: AppConst.k55,
                      height: AppConst.k32,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: index == currentIndex ? AppColors.white : AppColors.transparent,
                        shape: const StadiumBorder(),
                      ),
                      child: item.icon,
                    ),
                    AppConst.gap4,
                    Text(
                      item.label,
                      style: AppStyles.getLightStyle(
                        fontSize: AppConst.k11,
                        color: AppColors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
