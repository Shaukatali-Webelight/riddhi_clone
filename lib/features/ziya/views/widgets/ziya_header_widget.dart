// Flutter imports:
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
// Project imports:
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class ZiyaHeaderWidget extends StatelessWidget {
  const ZiyaHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppConst.k400,
      child: Stack(
        children: [
          // Background image with gradients
          Container(
            width: double.infinity,
            height: AppConst.k451,
            decoration: const BoxDecoration(
              color: Color(0xFFB92B2B),
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&auto=format&fit=crop&w=360&q=80',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF40A6E8).withOpacity(0.5),
                    const Color(0xFF40A6E8).withOpacity(0),
                  ],
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.104, 0.248, 1.0],
                    colors: [
                      const Color(0xFF32438C).withOpacity(0.8),
                      const Color(0xFF32438C).withOpacity(0.6),
                      const Color(0xFF32438C).withOpacity(0.2),
                      const Color(0xFFFFFFFF).withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Header content
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppConst.k24),
                child: Column(
                  children: [
                    // App bar section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.menu,
                          color: AppColors.white,
                          size: AppConst.k24,
                        ),
                        Text(
                          'Zora',
                          style: AppStyles.getBoldStyle(
                            fontSize: AppConst.k40,
                            color: AppColors.white,
                          ).copyWith(
                            fontFamily: 'Overlock',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Icon(
                          Icons.notifications_outlined,
                          color: AppColors.white,
                          size: AppConst.k24,
                        ),
                      ],
                    ),

                    const SizedBox(height: AppConst.k16),

                    // Greeting section
                    Row(
                      children: [
                        Text(
                          'Good Morning, ',
                          style: AppStyles.getMediumStyle(
                            fontSize: AppConst.k16,
                            color: AppColors.white,
                          ).copyWith(
                            fontFamily: 'Overlock',
                          ),
                        ),
                        Text(
                          'Jonathan',
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

                    const SizedBox(height: AppConst.k8),

                    // Mood selection row
                    Row(
                      children: [
                        const Text(
                          '😊',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: AppConst.k8),
                        Text(
                          "You're feeling: ",
                          style: AppStyles.getRegularStyle(
                            fontSize: AppConst.k14,
                            color: AppColors.white,
                          ).copyWith(
                            fontFamily: 'Overlock',
                          ),
                        ),
                        Text(
                          'Bored',
                          style: AppStyles.getBoldStyle(
                            fontSize: AppConst.k14,
                            color: AppColors.white,
                          ).copyWith(
                            fontFamily: 'Overlock',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: AppConst.k8),
                        const Icon(
                          Icons.close,
                          color: AppColors.white,
                          size: AppConst.k16,
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.white,
                          size: AppConst.k16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Gradient overlay at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: AppConst.k60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.439, 0.535, 0.652, 0.741, 0.890, 1.0],
                  colors: [
                    const Color(0xFF51ADE8).withOpacity(0),
                    const Color(0xFF51ADE8).withOpacity(0.3),
                    const Color(0xFF51ADE8).withOpacity(0.45),
                    const Color(0xFF51ADE8).withOpacity(0.7),
                    const Color(0xFF51ADE8).withOpacity(0.85),
                    const Color(0xFF51ADE8).withOpacity(1),
                    const Color(0xFF51ADE8).withOpacity(1),
                  ],
                ),
              ),
            ),
          ),

          // Quick Navigation
          Positioned(
            bottom: AppConst.k24,
            left: 0,
            right: 0,
            child: SizedBox(
              height: AppConst.k75,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppConst.k16),
                children: [
                  _buildQuickNavItem('😊', 'Meditation'),
                  const SizedBox(width: AppConst.k12),
                  _buildQuickNavItem('🧘‍♀️', 'Sleep'),
                  const SizedBox(width: AppConst.k12),
                  _buildQuickNavItem('🎯', 'Focus'),
                  const SizedBox(width: AppConst.k12),
                  _buildQuickNavItem('😌', 'Relax'),
                  const SizedBox(width: AppConst.k12),
                  _buildQuickNavItem('💪', 'Strength'),
                  const SizedBox(width: AppConst.k12),
                  _buildQuickNavItem('🌟', 'Positivity'),
                  const SizedBox(width: AppConst.k12),
                  _buildQuickNavItem('🎵', 'Music'),
                  const SizedBox(width: AppConst.k12),
                  _buildQuickNavItem('📚', 'Learn'),
                  const SizedBox(width: AppConst.k12),
                  _buildQuickNavItem('🌱', 'Growth'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickNavItem(String emoji, String title) {
    return Container(
      width: AppConst.k110,
      height: AppConst.k75,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConst.k8,
        vertical: AppConst.k16,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x331C6A9E), // 0.2 opacity
            Color(0xFF1C6A9E), // 1.0 opacity
          ],
        ),
        borderRadius: BorderRadius.circular(AppConst.k16),
        border: Border.all(
          color: AppColors.white.withOpacity(0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1C6A9E).withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConst.k16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: AppConst.k4),
              Text(
                title,
                style: AppStyles.getMediumStyle(
                  fontSize: AppConst.k12,
                  color: AppColors.white,
                ).copyWith(
                  fontFamily: 'Overlock',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
