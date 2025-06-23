import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/assets.gen.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({
    required this.onChanged,
    this.selectedValue,
    this.hintText,
    super.key,
    this.items,
    this.dropdownMenuItem,
    this.width,
    this.validator,
    this.maxHeight,
    this.fillColor,
    this.containerBorderRadius,
    this.height,
    this.isRecordObservations,
    this.inputDecorationBorder,
    this.enabledBorder,
    this.focusedBorder,
    this.disabledBorder,
  });

  final dynamic selectedValue;
  final List<String>? items;
  final double? maxHeight;
  final List<DropdownMenuItem<String>>? dropdownMenuItem;
  final void Function(dynamic)? onChanged;
  final String? hintText;
  final double? width;
  final String? Function(dynamic)? validator;
  final Color? fillColor;
  final BorderRadiusGeometry? containerBorderRadius;
  final double? height;
  final bool? isRecordObservations;
  final InputBorder? inputDecorationBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;

  static InputBorder dropdownFieldBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppConst.k8)),
      borderSide: BorderSide(color: AppColors.divider, width: 0.5),
    );
  }

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: AppConst.k100.toInt()),
      vsync: this,
    );
    _rotateAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width ?? AppConst.width,
      decoration: BoxDecoration(
        borderRadius: widget.containerBorderRadius ?? BorderRadius.circular(AppConst.k8),
        color: widget.fillColor ?? AppColors.white,
      ),
      child: Theme(
        data: ThemeData(),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField2(
            validator: widget.validator,
            onMenuStateChange: (isOpen) {
              FocusManager.instance.primaryFocus?.unfocus();
              if (isOpen) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
            },
            iconStyleData: IconStyleData(
              icon: AnimatedBuilder(
                animation: _rotateAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotateAnimation.value * 3.14,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primary,
                      size: AppConst.k20,
                    ),
                  );
                },
              ),
              iconSize: 20,
            ),
            decoration: InputDecoration(
              isDense: true,
              focusedBorder: widget.focusedBorder ?? AppDropdown.dropdownFieldBorder(),
              border: widget.inputDecorationBorder ?? AppDropdown.dropdownFieldBorder(),
              enabledBorder: widget.enabledBorder ?? AppDropdown.dropdownFieldBorder(),
              disabledBorder: widget.disabledBorder ?? AppDropdown.dropdownFieldBorder(),
            ),
            menuItemStyleData: MenuItemStyleData(
              padding: EdgeInsets.zero,
              height: AppConst.k35,
              selectedMenuItemBuilder: (context, child) {
                return ColoredBox(
                  color: AppColors.primaryLight,
                  child: child,
                );
              },
            ),
            dropdownStyleData: DropdownStyleData(
              padding: EdgeInsets.zero,
              maxHeight: widget.maxHeight ?? AppConst.k250,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(AppConst.k8)),
              ),
              offset: const Offset(0, -AppConst.k2),
            ),
            value: widget.selectedValue,
            selectedItemBuilder: (BuildContext context) {
              return widget.items?.map((e) {
                    return Row(
                      children: [
                        Text(
                          e,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.getLightStyle(fontSize: AppConst.k14),
                          textAlign: TextAlign.center,
                        ),
                        if ((widget.isRecordObservations ?? false) && !(e == 'NA')) ...[
                          AppConst.gap6,
                          AppAssets.icons.star.svg(),
                        ],
                      ],
                    );
                  }).toList() ??
                  [];
            },
            items: widget.dropdownMenuItem ??
                widget.items
                    ?.map(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        child: Padding(
                          padding: const EdgeInsets.only(left: AppConst.k16),
                          child: Row(
                            children: [
                              Text(
                                e,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: widget.selectedValue == e
                                    ? AppStyles.getRegularStyle(
                                        color: AppColors.primary,
                                      )
                                    : AppStyles.getLightStyle(
                                        fontSize: AppConst.k14,
                                      ),
                              ),
                              if ((widget.isRecordObservations ?? false) && !(e == 'NA')) ...[
                                AppConst.gap6,
                                AppAssets.icons.star.svg(),
                              ],
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
            onChanged: widget.onChanged,
            hint: Text(
              widget.hintText ?? '',
              style: AppStyles.getLightStyle(fontSize: AppConst.k14, color: AppColors.secondaryText),
            ),
            alignment: Alignment.centerLeft,
            isExpanded: true,
          ),
        ),
      ),
    );
  }
}
