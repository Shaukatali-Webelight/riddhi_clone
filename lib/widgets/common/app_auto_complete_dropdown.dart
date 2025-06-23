import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class AppAutocompleteDropdown extends StatefulWidget {
  const AppAutocompleteDropdown({
    required this.items,
    this.isSelectable = false,
    this.isLoading,
    super.key,
    this.onChanged,
    this.height,
    this.maxDropdownHeight,
    this.width,
    this.containerBorderRadius,
    this.isDense = false,
    this.hintText,
    this.iconSize,
    this.textStyle,
    this.contentPadding,
    this.keyboardType,
    this.inputFormatters,
    this.initialValue,
    this.maxLength,
    this.onSelected,
  });

  final List<String> items;
  final void Function(String?)? onChanged;
  final double? height;
  final double? width;
  final double? maxDropdownHeight;
  final BorderRadiusGeometry? containerBorderRadius;
  final bool isDense;
  final String? hintText;
  final double? iconSize;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final int? maxLength;
  final void Function(String?)? onSelected;
  final bool? isLoading;
  final bool? isSelectable;

  @override
  AppAutocompleteDropdownState createState() => AppAutocompleteDropdownState();
}

class AppAutocompleteDropdownState extends State<AppAutocompleteDropdown> {
  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final ValueNotifier<bool> _isDropdownOpen = ValueNotifier<bool>(false);
  final GlobalKey _textFieldKey = GlobalKey();
  bool isClear = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    _isDropdownOpen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: controller.value,
      optionsViewBuilder: (context, onSelected, options) {
        final renderBox = _textFieldKey.currentContext?.findRenderObject() as RenderBox?;
        final size = renderBox?.size ?? Size.zero;

        return Align(
          alignment: Alignment.topLeft,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.divider, width: 0.5),
              borderRadius: BorderRadius.circular(AppConst.k8),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            constraints: BoxConstraints(
              maxHeight: widget.maxDropdownHeight ?? MediaQuery.of(context).size.height * 0.3,
              maxWidth: size.width,
              minWidth: size.width,
            ),
            child: widget.isLoading ?? false
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppConst.k16),
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final option = options.elementAt(index);
                      return InkWell(
                        onTap: () {
                          onSelected(option);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConst.k12,
                          ).copyWith(
                            top: index == 0 ? AppConst.k16 : AppConst.k8,
                            bottom: index == options.length - 1 ? AppConst.k16 : AppConst.k8,
                          ),
                          child: Text(
                            option,
                            style: AppStyles.getLightStyle(
                              fontSize: AppConst.k14,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        _isDropdownOpen.value = true;
        if (textEditingValue.text.isEmpty || textEditingValue.text == widget.initialValue) {
          return widget.items;
        }
        final filterItems = widget.items.where((item) {
          return item.toLowerCase().contains(textEditingValue.text.toLowerCase());
        });
        return filterItems.isNotEmpty ? filterItems : [AppStrings.noDataFound];
      },
      onSelected: (String selection) {
        controller.text = selection;
        _isDropdownOpen.value = false;
        widget.onSelected?.call(selection);
        if (widget.isSelectable ?? false) {
          isClear = true;
        }

        focusNode.unfocus();
      },
      fieldViewBuilder: (
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
      ) {
        if (isClear && (widget.isSelectable ?? false)) {
          widget.onChanged?.call('');
          controller.text = '';
          //!TODO : will check with this with better approach
          WidgetsBinding.instance.addPostFrameCallback((_) {
            textEditingController.clear();
          });
          _isDropdownOpen.value = false;
          isClear = false;
        }
        return Container(
          key: _textFieldKey,
          height: widget.height,
          width: widget.width,
          padding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: AppConst.k12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.divider, width: 0.5),
            borderRadius: widget.containerBorderRadius ?? BorderRadius.circular(AppConst.k8),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText ?? '',
                    hintStyle: AppStyles.getLightStyle(
                      fontSize: AppConst.k14,
                      color: AppColors.secondaryText,
                    ),
                    counterText: AppStrings.emptySpace,
                    isDense: widget.isDense,
                  ),
                  maxLength: widget.maxLength,
                  keyboardType: widget.keyboardType,
                  style: widget.textStyle ??
                      AppStyles.getLightStyle(
                        fontSize: AppConst.k14,
                      ),
                  onTap: () {
                    _isDropdownOpen.value = true;
                  },
                  inputFormatters: widget.inputFormatters,
                  onFieldSubmitted: (value) => onFieldSubmitted,
                  onChanged: (value) {
                    widget.onChanged?.call(value);
                    controller.text = value;
                  },
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.primary,
                size: widget.iconSize ?? AppConst.k20,
              ),
            ],
          ),
        );
      },
    );
  }
}
