import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/resources/smart_refresh/refresh_header.dart';

/// A generic and reusable autocomplete dropdown component.
///
/// Type parameter [T] represents the data type for the items in the dropdown.
class GenericSearchAutocompleteDropdown<T extends Object> extends StatefulWidget {
  const GenericSearchAutocompleteDropdown({
    required this.items,
    required this.displayStringForOption,
    required this.itemBuilder,
    this.onItemSelected,
    this.onChanged,
    this.height,
    this.width,
    this.containerBorderRadius,
    this.hintText,
    this.isLoading = false,
    this.isClear = false,
    this.controller,
    this.animationKey,
    super.key,
    this.emptyItemBuilder,
    this.getItemId,
    this.noResultsFoundBuilder,
    this.showDropdownAbove = true,
    this.refreshController,
    this.onRefresh,
    this.onLoadMore,
    this.dropdownHeight = AppConst.k200,
  });

  /// List of items to display in the dropdown
  final List<T> items;

  /// Function to convert an item to display string
  final String Function(T option) displayStringForOption;

  /// Builder for rendering each item in the dropdown
  final Widget Function(BuildContext context, T item, VoidCallback onTap) itemBuilder;

  /// Builder for empty state widget when no items match the search
  final Widget Function(BuildContext context)? noResultsFoundBuilder;

  /// Builder for an empty item (optional)
  final Widget Function(BuildContext context, T item)? emptyItemBuilder;

  /// Function to extract a unique ID from an item (used for selection)
  final dynamic Function(T item)? getItemId;

  /// Callback when text in the search field changes
  final void Function(String?)? onChanged;

  /// Callback when an item is selected from the dropdown
  final void Function(T item)? onItemSelected;

  /// Height of the dropdown trigger field
  final double? height;

  /// Width of the dropdown trigger field
  final double? width;

  /// Border radius for dropdown and trigger field
  final BorderRadiusGeometry? containerBorderRadius;

  /// Placeholder text for the search field
  final String? hintText;

  /// Whether the dropdown is currently loading data
  final bool isLoading;

  /// Flag to clear the search field
  final bool? isClear;

  /// External controller for the text field
  final TextEditingController? controller;

  /// Animation key for selected item animation
  final GlobalKey? animationKey;

  /// Whether to show the dropdown above the input field (true) or below it (false)
  final bool showDropdownAbove;

  /// Height of the dropdown container when expanded
  final double dropdownHeight;

  final RefreshController? refreshController;
  final Future<void> Function(RefreshController refreshController)? onRefresh;
  final Future<void> Function(RefreshController refreshController)? onLoadMore;

  @override
  GenericSearchAutocompleteDropdownState<T> createState() => GenericSearchAutocompleteDropdownState<T>();
}

class GenericSearchAutocompleteDropdownState<T extends Object> extends State<GenericSearchAutocompleteDropdown<T>> {
  TextEditingController? _controller;
  FocusNode? focusNode;
  late final ValueNotifier<bool> _isDropdownOpen;
  late final ValueNotifier<T?> _selectedItem;
  late final ValueNotifier<List<T>> _filteredItems;
  final _textFieldKey = GlobalKey();
  late RefreshController _refreshController;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _refreshController = widget.refreshController ?? RefreshController();
    _isDropdownOpen = ValueNotifier<bool>(false);
    _selectedItem = ValueNotifier<T?>(null);
    _filteredItems = ValueNotifier<List<T>>(widget.items);
  }

  @override
  void didUpdateWidget(GenericSearchAutocompleteDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.isClear ?? false) && oldWidget.isClear != widget.isClear) {
      _clearSelection();
    }

    if (widget.items != oldWidget.items) {
      _filteredItems.value = widget.items;
    }
  }

  @override
  void dispose() {
    _disposed = true;
    if (widget.controller == null) {
      _controller?.dispose();
    }
    if (widget.refreshController == null) {
      _refreshController.dispose();
    }
    _isDropdownOpen.dispose();
    _selectedItem.dispose();
    _filteredItems.dispose();
    super.dispose();
  }

  void _clearSelection() {
    if (_disposed) return;
    _controller?.clear();
    _selectedItem.value = null;
    _isDropdownOpen.value = false;
    widget.onChanged?.call('');
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

  void _onLoading() {
    if (_disposed || widget.onLoadMore == null) return;
    widget.onLoadMore!(_refreshController);
  }

  /// Creates a default empty widget for when no results are found
  Widget _defaultNoResultsFoundBuilder(BuildContext context) {
    return SizedBox(
      height: AppConst.k50,
      child: Center(
        child: Text(
          AppStrings.noDataFound,
          style: AppStyles.getLightStyle(
            fontSize: AppConst.k14,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownContent() {
    if (widget.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(AppConst.k16),
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: AppConst.k3,
          ),
        ),
      );
    }

    return ValueListenableBuilder<List<T>>(
      valueListenable: _filteredItems,
      builder: (context, filteredItems, _) {
        if (filteredItems.isEmpty) {
          return widget.noResultsFoundBuilder?.call(context) ?? _defaultNoResultsFoundBuilder(context);
        }

        return SmartRefresher(
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
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: filteredItems.length,
            itemBuilder: (BuildContext context, int index) {
              final option = filteredItems[index];

              if (widget.getItemId != null && widget.emptyItemBuilder != null && widget.getItemId!(option) == -1) {
                return widget.emptyItemBuilder!(context, option);
              }

              return widget.itemBuilder(
                context,
                option,
                () {
                  widget.onItemSelected?.call(option);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _toggleDropdown() {
    if (_disposed) return;
    _isDropdownOpen.value = !_isDropdownOpen.value;

    if (_isDropdownOpen.value) {
      focusNode?.requestFocus();
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build the search field
    final Widget searchField = Container(
      key: _textFieldKey,
      height: widget.height,
      width: widget.width,
      padding: const EdgeInsets.symmetric(horizontal: AppConst.k12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider, width: 0.5),
        borderRadius: widget.containerBorderRadius ?? BorderRadius.circular(AppConst.k8),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Selected Item Avatar/Image
          ValueListenableBuilder<T?>(
            valueListenable: _selectedItem,
            builder: (context, selectedItem, _) {
              if (selectedItem != null && widget.getItemId != null && widget.getItemId!(selectedItem) != -1) {
                return Container(
                  key: widget.animationKey,
                  width: AppConst.k32,
                  height: AppConst.k32,
                  margin: const EdgeInsets.only(right: AppConst.k8),
                  decoration: const BoxDecoration(
                    color: AppColors.scaffoldBg,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: AppColors.scaffoldBg,
                    child: Text(
                      'IMG',
                      style: AppStyles.getRegularStyle(
                        fontSize: AppConst.k10,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          // Text Field
          Expanded(
            child: TextFormField(
              controller: _controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: AppStyles.getLightStyle(
                  fontSize: AppConst.k14,
                  color: AppColors.secondaryText,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: AppConst.k12),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller!,
                  builder: (context, textValue, _) {
                    return textValue.text.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: AppConst.k20),
                            child: GestureDetector(
                              onTap: _clearSelection,
                              child: const Icon(
                                Icons.close,
                                color: AppColors.primary,
                                size: AppConst.k16,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ),
              onTap: () {
                _isDropdownOpen.value = true;
              },
              onFieldSubmitted: (_) {
                _isDropdownOpen.value = false;
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                widget.onChanged?.call(value);
                _isDropdownOpen.value = true;
              },
            ),
          ),
          // Dropdown Toggle Icon
          ValueListenableBuilder<bool>(
            valueListenable: _isDropdownOpen,
            builder: (context, isOpen, _) {
              return GestureDetector(
                onTap: _toggleDropdown,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: AppConst.k4,
                  ),
                  width: AppConst.k30,
                  color: AppColors.transparent,
                  child: Icon(
                    isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                    size: AppConst.k20,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );

    return ValueListenableBuilder<bool>(
      valueListenable: _isDropdownOpen,
      builder: (context, isOpen, _) {
        final columnChildren = <Widget>[];

        // Build the dropdown container
        final Widget dropdownContainer = AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: isOpen ? widget.dropdownHeight : 0,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: widget.containerBorderRadius ?? BorderRadius.circular(AppConst.k8),
            color: AppColors.white,
            border: Border.all(color: AppColors.divider, width: 0.5),
          ),
          margin: EdgeInsets.only(
            top: widget.showDropdownAbove ? 0 : 4,
            bottom: widget.showDropdownAbove ? 4 : 0,
          ),
          child: ClipRRect(
            borderRadius: widget.containerBorderRadius ?? BorderRadius.circular(AppConst.k8),
            child: isOpen ? _buildDropdownContent() : null,
          ),
        );

        // Order widgets based on the showDropdownAbove parameter
        if (widget.showDropdownAbove) {
          columnChildren.add(dropdownContainer);
          columnChildren.add(searchField);
        } else {
          columnChildren.add(searchField);
          columnChildren.add(dropdownContainer);
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnChildren,
        );
      },
    );
  }
}
