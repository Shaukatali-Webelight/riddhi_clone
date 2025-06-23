// Flutter imports:
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
// Project imports:
import 'package:riddhi_clone/constants/app_dimensions.dart';

class ZiyaBackgroundElementsWidget extends StatelessWidget {
  const ZiyaBackgroundElementsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: SizedBox(
        width: double.infinity,
        height: AppConst.k440,
        child: Stack(
          children: [
            // Star 1
            Positioned(
              top: AppConst.k50,
              left: AppConst.k30,
              child: Opacity(
                opacity: 0.54,
                child: _buildStar(),
              ),
            ),

            // Star 2
            Positioned(
              top: AppConst.k120,
              right: AppConst.k50,
              child: Opacity(
                opacity: 0.54,
                child: _buildStar(),
              ),
            ),

            // Star 3
            Positioned(
              top: AppConst.k200,
              left: AppConst.k80,
              child: Opacity(
                opacity: 0.54,
                child: _buildStar(),
              ),
            ),

            // Additional floating elements
            Positioned(
              top: AppConst.k80,
              right: AppConst.k100,
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  width: AppConst.k4,
                  height: AppConst.k4,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConst.k2),
                  ),
                ),
              ),
            ),

            Positioned(
              top: AppConst.k180,
              right: AppConst.k30,
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  width: AppConst.k6,
                  height: AppConst.k6,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConst.k3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStar() {
    return SizedBox(
      width: AppConst.k20,
      height: AppConst.k20,
      child: CustomPaint(
        painter: StarPainter(),
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.4;

    for (var i = 0; i < 10; i++) {
      final angle = (i * math.pi) / 5;
      final radius = i.isEven ? outerRadius : innerRadius;
      final x = centerX + radius * math.cos(angle - math.pi / 2);
      final y = centerY + radius * math.sin(angle - math.pi / 2);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
