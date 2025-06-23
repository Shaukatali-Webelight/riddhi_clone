import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/helpers/app_navigation.dart';
import 'package:riddhi_clone/widgets/common/app_button.dart';
import 'package:riddhi_clone/widgets/common/will_pop_scope_widget.dart';

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog({
    required this.title,
    required this.conformationMessage,
    super.key,
    this.onYesPressed,
    this.subTitle,
    this.titleColor,
    this.subTitleColor,
    this.buttonBgColor,
    this.yesButtonTitle,
    this.noButtonTitle,
    this.loadingNotifier,
  });

  final String title;
  final void Function(ValueNotifier<bool> loadingNotifier)? onYesPressed;
  final String conformationMessage;
  final String? subTitle;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? buttonBgColor;
  final String? yesButtonTitle;
  final String? noButtonTitle;
  final ValueNotifier<bool>? loadingNotifier;

  void show() {
    showDialog<void>(
      context: globalContext,
      builder: (context) => this,
    );
  }

  static void hide() => AppNavigation.back();

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  late final ValueNotifier<bool> _loadingNotifier;

  @override
  void initState() {
    super.initState();
    // Use provided notifier or create a local one
    _loadingNotifier = widget.loadingNotifier ?? ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    // Only dispose if we created it locally
    if (widget.loadingNotifier == null) {
      _loadingNotifier.dispose();
    }
    super.dispose();
  }

  // Handle yes button press
  void _handleYesPressed() {
    if (widget.onYesPressed == null) return;
    widget.onYesPressed!(_loadingNotifier);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _loadingNotifier,
      builder: (context, isLoading, child) {
        return WillPopScopeWidget(
          canPop: !isLoading,
          child: IgnorePointer(
            ignoring: isLoading,
            child: AlertDialog(
              backgroundColor: AppColors.white,
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.all(AppConst.k30),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConst.k8)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppConst.k10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.transparent,
                      border: BorderDirectional(
                        bottom: BorderSide(color: AppColors.primary.withValues(alpha: 0.25)),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.title,
                        style: AppStyles.getBoldStyle(
                          color: widget.titleColor ?? AppColors.primary,
                          fontSize: AppConst.k20,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(AppConst.k10),
                      child: Text(
                        widget.conformationMessage,
                        style: AppStyles.getRegularStyle(
                          fontSize: AppConst.k16,
                          color: AppColors.grayMid,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppConst.k10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: AppButton(
                            title: widget.yesButtonTitle ?? AppStrings.yes,
                            backgroundColor: AppColors.primary,
                            textColor: AppColors.white,
                            onPressed: _handleYesPressed,
                            isLoading: isLoading,
                          ),
                        ),
                        AppConst.gap8,
                        Expanded(
                          child: AppButton(
                            title: widget.noButtonTitle ?? AppStrings.no,
                            backgroundColor: AppColors.primaryLight,
                            textColor: AppColors.primary,
                            onPressed: ConfirmDialog.hide,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
