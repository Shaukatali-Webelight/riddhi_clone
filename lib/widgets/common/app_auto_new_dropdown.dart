import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/resources/smart_refresh/refresh_header.dart';

class AppNewDropDown<T extends Object> extends StatefulWidget {
  const AppNewDropDown({
    required this.items,
    required this.itemToString,
    this.isSelectable = false,
    this.isLoading,
    super.key,
    this.onChanged,
    this.height,
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
    this.refreshController,
    this.onRefresh,
    this.onLoadMore,
  });

  final List<T> items;
  final String Function(T) itemToString;
  final void Function(String?)? onChanged;
  final double? height;
  final double? width;
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
  final void Function(T)? onSelected;
  final bool? isLoading;
  final bool? isSelectable;
  final RefreshController? refreshController;
  final Future<void> Function(RefreshController refreshController)? onRefresh;
  final Future<void> Function(RefreshController refreshController)? onLoadMore;

  @override
  AppNewDropDownState<T> createState() => AppNewDropDownState<T>();
}

class AppNewDropDownState<T extends Object> extends State<AppNewDropDown<T>> {
  late TextEditingController _controller;
  late RefreshController _refreshController;
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _isDropdownOpen = ValueNotifier(false);
  final ValueNotifier<List<T>> _filteredItems = ValueNotifier<List<T>>([]);
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _refreshController = widget.refreshController ?? RefreshController();
    _updateFilteredItems();
  }

  void _updateFilteredItems() {
    if (_disposed) return;

    //* If there's an external onChanged handler, don't filter locally
    if (widget.onChanged != null) {
      _filteredItems.value = widget.items;
      return;
    }
  }

  void _onLoading() {
    if (_disposed || widget.onLoadMore == null) return;

    widget.onLoadMore!(_refreshController);
  }

  @override
  void didUpdateWidget(AppNewDropDown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    //* Check if items have changed (reference comparison)
    if (widget.items != oldWidget.items) {
      _updateFilteredItems();
    }
  }

  Future<void> _onRefresh() async {
    if (_disposed || widget.onRefresh == null) return;
    try {
      await widget.onRefresh!(_refreshController);
      if (!_disposed) {
        _refreshController.refreshCompleted();
        _refreshController.resetNoData();
      }
    } catch (e) {
      if (!_disposed) {
        _refreshController.refreshFailed();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _controller.dispose();
    _focusNode.dispose();
    _isDropdownOpen.dispose();
    _filteredItems.dispose();
    if (widget.refreshController == null) {
      _refreshController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                  controller: _controller,
                  focusNode: _focusNode,
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
                  style: widget.textStyle ?? AppStyles.getLightStyle(fontSize: AppConst.k14),
                  inputFormatters: widget.inputFormatters,
                  onChanged: (value) {
                    if (_disposed) return;
                    _isDropdownOpen.value = true;
                    widget.onChanged?.call(value);
                    _updateFilteredItems();
                  },
                  onTap: () {
                    if (_disposed) return;
                    _isDropdownOpen.value = true;
                  },
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _isDropdownOpen,
                builder: (context, isOpen, _) => GestureDetector(
                  child: Icon(
                    isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                    size: widget.iconSize ?? AppConst.k20,
                  ),
                  onTap: () {
                    if (_disposed) return;
                    _isDropdownOpen.value = !isOpen;
                  },
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isDropdownOpen,
          builder: (context, isOpen, _) {
            if (!isOpen) return const SizedBox.shrink();

            return Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider, width: 0.5),
                borderRadius: BorderRadius.circular(AppConst.k8),
                color: AppColors.white,
              ),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.3,
              ),
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                footer: ClassicFooter(
                  textStyle: AppStyles.getRegularStyle(
                    color: AppColors.primary,
                  ),
                ),
                header: const AppWaterDropHeader(),
                physics: const BouncingScrollPhysics(),
                enablePullUp: widget.items.length > 19,
                child: ValueListenableBuilder<List<T>>(
                  valueListenable: _filteredItems,
                  builder: (context, filteredItems, _) {
                    if (widget.isLoading ?? false) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(AppConst.k16),
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    } else if (filteredItems.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppConst.k16),
                          child: Text(
                            AppStrings.noDataFound,
                            style: AppStyles.getLightStyle(
                              fontSize: AppConst.k14,
                              color: AppColors.secondaryText,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          final option = filteredItems[index];
                          return InkWell(
                            onTap: () {
                              if (_disposed) return;
                              _controller.text = widget.itemToString(option);
                              _isDropdownOpen.value = false;
                              widget.onSelected?.call(option);
                              _focusNode.unfocus();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConst.k12,
                                vertical: AppConst.k8,
                              ),
                              child: Text(
                                widget.itemToString(option),
                                style: AppStyles.getLightStyle(fontSize: AppConst.k14),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
