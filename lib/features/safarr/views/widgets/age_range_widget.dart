import 'package:flutter/material.dart';

class AgeRangeWidget extends StatelessWidget {
  const AgeRangeWidget({
    required this.minAge,
    required this.maxAge,
    required this.onAgeChanged,
    super.key,
  });
  final double minAge;
  final double maxAge;
  final Function(double, double) onAgeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Age Range Header with exact styling
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Age Range',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.9375, // 0.937500037252903%
                color: Color(0xFFF0ECE9),
              ),
            ),
            Text(
              '${minAge.toInt()} - ${maxAge.toInt()}',
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.31, // 1.310021264212472em
                letterSpacing: 0.8188, // 0.8187633539949144%
                color: Color(0xFFF0ECE9),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Age Range Slider with exact Figma styling
        SizedBox(
          width: 320,
          height: 13,
          child: Stack(
            children: [
              // Background track
              Positioned(
                left: 0,
                right: 0,
                top: 4,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(7.64),
                  ),
                ),
              ),

              // Active track (yellow part)
              Positioned(
                left: 28.68,
                right: 79.32, // 320 - 28.68 - 212 = 79.32
                top: 4,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9900),
                    borderRadius: BorderRadius.circular(7.64),
                  ),
                ),
              ),

              // Min age thumb (left circle)
              Positioned(
                left: 28.68,
                top: 0,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF9900),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Max age thumb (right circle)
              Positioned(
                left: 28.68 + 199, // Start position + track width - thumb width
                top: 0,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF9900),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Gesture detector for interaction
              Positioned.fill(
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final box = context.findRenderObject()! as RenderBox;
                    final localPosition = box.globalToLocal(details.globalPosition);
                    final percentage = (localPosition.dx - 28.68) / 212; // Account for track positioning
                    final newAge = 18 + percentage * (60 - 18);

                    if (percentage < 0 || percentage > 1) return;

                    // Determine which thumb is closer
                    final distanceToMin = ((localPosition.dx - 28.68) - ((minAge - 18) / (60 - 18) * 212)).abs();
                    final distanceToMax = ((localPosition.dx - 28.68) - ((maxAge - 18) / (60 - 18) * 212)).abs();

                    if (distanceToMin < distanceToMax) {
                      // Update min age
                      final clampedAge = newAge.clamp(18.0, maxAge - 1);
                      onAgeChanged(clampedAge, maxAge);
                    } else {
                      // Update max age
                      final clampedAge = newAge.clamp(minAge + 1, 60.0);
                      onAgeChanged(minAge, clampedAge);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
