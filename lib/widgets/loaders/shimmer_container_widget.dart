import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainerWidget extends StatelessWidget {
  const ShimmerContainerWidget({
    this.child,
    super.key,
    this.height = 0,
    this.width = 0,
    this.margin,
    this.borderRadius,
  });

  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.secondaryText.withValues(alpha: 0.1),
      highlightColor: AppColors.primary.withValues(alpha: 0.6),
      child: child ??
          Container(
            height: height,
            width: width,
            margin: margin,
            decoration: BoxDecoration(
              color: AppColors.secondaryText,
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
          ),
    );
  }
}
