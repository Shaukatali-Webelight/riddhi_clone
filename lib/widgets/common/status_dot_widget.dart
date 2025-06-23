import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';

class StatusDotWidget extends StatelessWidget {
  const StatusDotWidget({super.key, this.radius, this.color});

  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color ?? AppColors.dotColor,
      radius: radius ?? AppConst.k2,
    );
  }
}
