// Flutter imports:
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
// Project imports:
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class ZiyaSelectedMoodWidget extends StatelessWidget {
  const ZiyaSelectedMoodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppConst.k16),
      padding: const EdgeInsets.only(
        left: AppConst.k16,
        right: AppConst.k16,
        top: AppConst.k12,
        bottom: AppConst.k16,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.139, 1.0],
          colors: [
            const Color(0xFF1C6A9E).withOpacity(0),
            const Color(0xFF1C6A9E).withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConst.k16),
        border: Border.all(
          color: AppColors.white.withOpacity(0.3),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConst.k16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Row(
            children: [
              // Mood content area - expand to fill
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Mood emoji
                        const Text(
                          '😊',
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: AppConst.k12),
                        // Mood text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected Mood',
                                style: AppStyles.getMediumStyle(
                                  fontSize: AppConst.k12,
                                  color: AppColors.white.withOpacity(0.8),
                                ).copyWith(
                                  fontFamily: 'Overlock',
                                ),
                              ),
                              const SizedBox(height: AppConst.k4),
                              Text(
                                'Happy & Peaceful',
                                style: AppStyles.getBoldStyle(
                                  fontSize: AppConst.k16,
                                  color: AppColors.white,
                                ).copyWith(
                                  fontFamily: 'Overlock',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
