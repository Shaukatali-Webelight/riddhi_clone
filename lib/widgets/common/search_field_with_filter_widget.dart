import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/assets.gen.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_semantic_labels.dart';
import 'package:riddhi_clone/widgets/common/app_text_field.dart';
import 'package:timelines_plus/timelines_plus.dart';

class SearchFieldWithFilterWidget extends StatelessWidget {
  const SearchFieldWithFilterWidget({
    required this.hintText,
    required this.searchController,
    super.key,
    this.onFilterTap,
    this.focusNode,
    this.onChanged,
    this.onClearTap,
    this.showFilter = true,
    this.showFilterIndicator = false,
    this.showAddButton,
    this.onAddButtonTap,
  });

  final String hintText;
  final void Function()? onFilterTap;
  final TextEditingController searchController;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onClearTap;
  final bool showFilter;
  final bool showFilterIndicator;
  final bool? showAddButton;
  final void Function()? onAddButtonTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            textFieldHeight: AppConst.k46,
            contentPadding: EdgeInsets.zero,
            minLines: AppConst.k1.toInt(),
            maxLines: AppConst.k1.toInt(),
            controller: searchController,
            focusNode: focusNode,
            hintText: hintText,
            prefixIcon: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppAssets.icons.searchIcon.svg(
                    semanticsLabel: AppSemanticLabels.searchIcon,
                    height: AppConst.k18,
                  ),
                ],
              ),
            ),
            onChanged: onChanged,
            suffixIcon: ValueListenableBuilder(
              valueListenable: searchController,
              builder: (context, value, child) => searchController.text.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: onClearTap,
                      icon: const Icon(
                        Icons.clear,
                        color: AppColors.grayMid,
                        semanticLabel: AppSemanticLabels.clearIcon,
                      ),
                    ),
            ),
          ),
        ),
        if (showFilter) ...[
          AppConst.gap12,
          Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: onFilterTap,
                child: Container(
                  width: AppConst.k45,
                  height: AppConst.k45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConst.k8),
                    border: Border.all(
                      color: AppColors.divider,
                      width: 0.5,
                    ),
                  ),
                  child: AppAssets.icons.filter.svg(
                    colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    semanticsLabel: AppSemanticLabels.filterIcon,
                  ),
                ),
              ),
              if (showFilterIndicator) ...[
                const Positioned(
                  right: -4,
                  top: -4,
                  child: DotIndicator(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ],
          ),
        ],
        if (showAddButton ?? false) ...[
          AppConst.gap12,
          GestureDetector(
            onTap: onAddButtonTap,
            child: Container(
              width: AppConst.k45,
              height: AppConst.k45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppConst.k8),
                border: Border.all(
                  color: AppColors.divider,
                  width: 0.5,
                ),
              ),
              child: const Icon(
                Icons.add,
                color: AppColors.primary,
                semanticLabel: AppSemanticLabels.addIcon,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
