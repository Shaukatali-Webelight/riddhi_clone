import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';

class DetailExpansionTile extends StatelessWidget {
  const DetailExpansionTile({
    required this.children,
    required this.title,
    this.showTrailingIcon = true,
    this.expansionTileKey,
    super.key,
    this.controller,
    this.onExpansionChanged,
    this.trailing,
    this.initiallyExpanded = true,
    this.iconColor,
  });

  final List<Widget> children;
  final Widget title;
  final Key? expansionTileKey;
  final ExpansionTileController? controller;
  final void Function(bool)? onExpansionChanged;
  final bool? showTrailingIcon;
  final Widget? trailing;
  final bool? initiallyExpanded;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: AppColors.transparent,
        listTileTheme: ListTileTheme.of(context).copyWith(
          dense: true,
          minVerticalPadding: 0,
          visualDensity: VisualDensity.compact,
        ),
      ),
      child: ExpansionTile(
        minTileHeight: AppConst.k0,
        trailing: trailing,
        controller: controller,
        key: expansionTileKey,
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.zero,
        collapsedTextColor: AppColors.primaryText,
        collapsedIconColor: iconColor ?? AppColors.primaryText,
        iconColor: iconColor ?? AppColors.primaryText,
        initiallyExpanded: initiallyExpanded ?? false,
        title: title,
        showTrailingIcon: showTrailingIcon ?? true,
        onExpansionChanged: onExpansionChanged,
        children: children,
      ),
    );
  }
}
