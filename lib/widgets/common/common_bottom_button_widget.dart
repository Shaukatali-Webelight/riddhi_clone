import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/widgets/common/app_button.dart';

class CommonBottomButtonWidget extends StatefulWidget {
  const CommonBottomButtonWidget({
    required this.buttonText,
    required this.onPressed,
    this.isLoading,
    this.isEnabled,
    super.key,
    this.padding,
  });

  final String buttonText;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final bool? isLoading;
  final bool? isEnabled;

  @override
  State<CommonBottomButtonWidget> createState() => _CommonBottomButtonWidgetState();
}

class _CommonBottomButtonWidgetState extends State<CommonBottomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          widget.padding ?? const EdgeInsets.all(AppConst.k12).copyWith(bottom: AppConst.bottomPadding + AppConst.k10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.divider,
            width: 0.5,
          ),
        ),
        color: AppColors.white,
      ),
      child: AppButton(
        title: widget.buttonText,
        onPressed: widget.onPressed,
        isLoading: widget.isLoading ?? false,
        isEnabled: widget.isEnabled ?? true,
      ),
    );
  }
}
