import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/assets.gen.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class RiddhiNavBar extends StatelessWidget {
  const RiddhiNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavItem(
                index: 0,
                icon: AppAssets.icons.homeIcon.svg(
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                  width: 16,
                  height: 18,
                ),
                label: AppStrings.home,
              ),
              const SizedBox(width: 2),
              _buildNavItem(
                index: 1,
                icon: AppAssets.icons.customerIcon.svg(
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                  width: 22,
                  height: 16,
                ),
                label: AppStrings.customers,
              ),
              const SizedBox(width: 2),
              _buildNavItem(
                index: 2,
                icon: AppAssets.icons.calenderToday.svg(
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                  width: 18,
                  height: 20,
                ),
                label: AppStrings.startDay,
              ),
              const SizedBox(width: 2),
              _buildNavItem(
                index: 3,
                icon: AppAssets.icons.meetingsIcon.svg(
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                  width: 20,
                  height: 20,
                ),
                label: AppStrings.meetings,
              ),
              const SizedBox(width: 2),
              _buildNavItem(
                index: 4,
                icon: const Icon(
                  Icons.more_horiz,
                  color: AppColors.white,
                  size: 16,
                ),
                label: AppStrings.more,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required Widget icon,
    required String label,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF39B26F) : const Color(0xFF242424).withOpacity(0.6),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Center(child: icon),
            ),
            if (isSelected) ...[
              const SizedBox(width: 4),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 1.0 : 0.0,
                child: Text(
                  label,
                  style: AppStyles.getRegularStyle(
                    fontSize: 12,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
