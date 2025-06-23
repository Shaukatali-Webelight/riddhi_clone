import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/resources/smart_refresh/refresh_header.dart';
import 'package:riddhi_clone/widgets/common/app_text_field.dart';
import 'package:riddhi_clone/widgets/loaders/app_loading_place_holder.dart'; // Make sure this import exists

class CheckboxDropdown<T> extends StatefulWidget {
  const CheckboxDropdown({
    required this.items,
    required this.getLabel,
    required this.getId,
    this.refreshController,
    super.key,
    this.selectedIds,
    this.onChanged,
    this.height,
    this.width,
    this.containerBorderRadius,
    this.dropdownHeight,
    this.searchController,
    this.onSearch,
    this.isLoading = false,
    this.onRefresh,
    this.onLoadMore,
  });

  final List<T> items;
  final String Function(T item) getLabel;
  final dynamic Function(T item) getId;
  final List<dynamic>? selectedIds;
  final void Function(List<dynamic>)? onChanged;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? containerBorderRadius;
  final double? dropdownHeight;
  final TextEditingController? searchController;
  final void Function(String)? onSearch;
  final bool isLoading;
  final RefreshController? refreshController;
  final Future<void> Function(RefreshController refreshController)? onRefresh;
  final Future<void> Function(RefreshController refreshController)? onLoadMore;

  @override
  CheckboxDropdownState<T> createState() => CheckboxDropdownState<T>();
}

class CheckboxDropdownState<T> extends State<CheckboxDropdown<T>> {
  late ValueNotifier<List<dynamic>> _selectedIdsNotifier;
  late ValueNotifier<bool> _isDropdownOpenNotifier;
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _selectedIdsNotifier = ValueNotifier(widget.selectedIds ?? []);
    _isDropdownOpenNotifier = ValueNotifier(false);
    _refreshController = widget.refreshController ?? RefreshController();
  }

  @override
  void dispose() {
    _selectedIdsNotifier.dispose();
    _isDropdownOpenNotifier.dispose();
    if (widget.refreshController == null) {
      _refreshController.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(CheckboxDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIds != oldWidget.selectedIds) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _selectedIdsNotifier.value = widget.selectedIds ?? [];
      });
    }
  }

  void _toggleDropdown() {
    _isDropdownOpenNotifier.value = !_isDropdownOpenNotifier.value;
  }

  Future<void> _onRefresh() async {
    if (widget.onRefresh != null) {
      await widget.onRefresh!(_refreshController).whenComplete(() {
        _refreshController.refreshCompleted();
        _refreshController.resetNoData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            height: widget.height,
            width: widget.width ?? double.infinity,
            padding: const EdgeInsets.all(AppConst.k12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.divider, width: 0.5),
              borderRadius: widget.containerBorderRadius ?? BorderRadius.circular(AppConst.k8),
              color: AppColors.white,
            ),
            child: ValueListenableBuilder<List<dynamic>>(
              valueListenable: _selectedIdsNotifier,
              builder: (context, selectedIds, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedIds.isEmpty ? AppStrings.select : '${selectedIds.length} Selected',
                      style: AppStyles.getLightStyle(
                        fontSize: AppConst.k14,
                        color: selectedIds.isEmpty ? AppColors.secondaryText : AppColors.primaryText,
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isDropdownOpenNotifier,
                      builder: (context, isOpen, _) {
                        return Icon(
                          isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: AppColors.primary,
                          size: AppConst.k20,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        AppConst.gap5,
        ValueListenableBuilder<bool>(
          valueListenable: _isDropdownOpenNotifier,
          builder: (context, isOpen, child) {
            return isOpen
                ? Container(
                    height: widget.dropdownHeight ?? MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grayLight),
                      borderRadius: widget.containerBorderRadius ?? BorderRadius.circular(AppConst.k8),
                      color: AppColors.white,
                    ),
                    child: Column(
                      children: [
                        AppTextField(
                          controller: widget.searchController,
                          hintText: AppStrings.search,
                          onChanged: (value) => widget.onSearch?.call(value),
                        ),
                        Expanded(
                          child: widget.isLoading
                              ? const Center(child: AppLoadingPlaceHolder())
                              : SmartRefresher(
                                  controller: widget.refreshController ?? RefreshController(),
                                  onRefresh: _onRefresh,
                                  footer: ClassicFooter(
                                    textStyle: AppStyles.getRegularStyle(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  header: const AppWaterDropHeader(),
                                  physics: const BouncingScrollPhysics(),
                                  enablePullUp: widget.items.length > 19,
                                  onLoading: () => widget.onLoadMore?.call(_refreshController),
                                  child: widget.items.isEmpty
                                      ? Center(
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
                                        )
                                      : SingleChildScrollView(
                                          child: Column(
                                            children: widget.items.map((item) {
                                              final id = widget.getId(item);
                                              final label = widget.getLabel(item);
                                              return ValueListenableBuilder<List<dynamic>>(
                                                valueListenable: _selectedIdsNotifier,
                                                builder: (context, selectedIds, child) {
                                                  final isSelected = selectedIds.contains(id);
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: AppConst.k8),
                                                          child: Text(
                                                            label,
                                                            style: AppStyles.getLightStyle(
                                                              fontSize: AppConst.k14,
                                                              color: isSelected
                                                                  ? AppColors.primary
                                                                  : AppColors.primaryText,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.8,
                                                        child: Checkbox(
                                                          activeColor: AppColors.primary,
                                                          value: isSelected,
                                                          onChanged: (_) {
                                                            final newList = List<dynamic>.from(selectedIds);
                                                            if (isSelected) {
                                                              newList.remove(id);
                                                            } else {
                                                              newList.add(id);
                                                            }
                                                            _selectedIdsNotifier.value = newList;
                                                            widget.onChanged?.call(newList);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
