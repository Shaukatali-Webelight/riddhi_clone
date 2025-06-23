import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';

class CommonContainerWidget extends StatelessWidget {
  const CommonContainerWidget({
    required this.child,
    super.key,
    this.height,
    this.width,
    this.color,
    this.padding,
    this.margin,
    this.borderRadius,
    this.border,
    this.decoration,
  });

  final Widget child;
  final double? height;
  final double? width;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      width: width ?? AppConst.width,
      padding: padding ?? const EdgeInsets.all(AppConst.k12),
      decoration: decoration ??
          BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.14),
                blurRadius: AppConst.k4,
              ),
            ],
            borderRadius: borderRadius ?? BorderRadius.circular(AppConst.k8),
            border: border ??
                Border.all(
                  color: AppColors.divider,
                  width: 0.5,
                ),
            color: color ?? AppColors.white,
          ),
      child: child,
    );
  }
}
