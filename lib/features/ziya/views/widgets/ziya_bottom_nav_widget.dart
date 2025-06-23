// Flutter imports:
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
// Project imports:
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class ZiyaBottomNavWidget extends StatefulWidget {
  const ZiyaBottomNavWidget({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });
  final int currentIndex;
  final Function(int) onTap;

  @override
  State<ZiyaBottomNavWidget> createState() => _ZiyaBottomNavWidgetState();
}

class _ZiyaBottomNavWidgetState extends State<ZiyaBottomNavWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.k72,
      decoration: BoxDecoration(
        color: const Color(0xFF1C6A9E).withOpacity(0.9),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConst.k8),
          topRight: Radius.circular(AppConst.k8),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConst.k8),
          topRight: Radius.circular(AppConst.k8),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(0, 'Home', Icons.home, isActive: widget.currentIndex == 0),
              _buildNavItem(1, 'MindCare', Icons.psychology, isActive: widget.currentIndex == 1),
              _buildCenterNavItem(2, 'Ask to Zora', Icons.chat_bubble, isActive: widget.currentIndex == 2),
              _buildNavItem(3, 'SleepCare', Icons.nightlight_round, isActive: widget.currentIndex == 3),
              _buildNavItem(4, 'LifeStage', Icons.group, isActive: widget.currentIndex == 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon, {bool isActive = false}) {
    return Expanded(
      child: InkWell(
        onTap: () => widget.onTap(index),
        child: Container(
          height: AppConst.k72,
          padding: const EdgeInsets.symmetric(horizontal: AppConst.k6, vertical: AppConst.k12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: AppConst.k24,
                height: AppConst.k24,
                child: Icon(
                  icon,
                  size: AppConst.k20,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: AppConst.k4),
              Text(
                label,
                style: AppStyles.getMediumStyle(
                  fontSize: AppConst.k12,
                  color: AppColors.white,
                ).copyWith(
                  fontFamily: 'Overlock',
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenterNavItem(int index, String label, IconData icon, {bool isActive = false}) {
    return Container(
      width: AppConst.k84,
      height: AppConst.k72,
      padding: const EdgeInsets.only(
        left: AppConst.k6,
        right: AppConst.k6,
        top: AppConst.k12,
        bottom: AppConst.k14,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => widget.onTap(index),
            child: Container(
              width: AppConst.k72,
              height: AppConst.k72, // Made it square like in Figma
              decoration: BoxDecoration(
                color: const Color(0xFF1C6A9E).withOpacity(0.9),
                borderRadius: BorderRadius.circular(AppConst.k36), // Perfect circle
                border: Border.all(
                  color: AppColors.white,
                  width: AppConst.k3,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppConst.k36),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Center(
                    child: Icon(
                      icon,
                      size: AppConst.k32, // Larger icon for better visibility
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppConst.k4),
          Text(
            label,
            style: AppStyles.getMediumStyle(
              fontSize: AppConst.k12,
              color: AppColors.white,
            ).copyWith(
              fontFamily: 'Overlock',
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
