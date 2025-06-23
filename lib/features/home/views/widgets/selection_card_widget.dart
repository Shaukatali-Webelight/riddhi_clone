import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/widgets/common/common_container_widget.dart';
import 'package:riddhi_clone/widgets/common/tooltip_widget.dart';

class SelectionCardWidget extends StatelessWidget {
  const SelectionCardWidget({
    required this.title,
    required this.image,
    required this.onTap,
    this.count,
    super.key,
  });

  final void Function() onTap;
  final String title;
  final Widget image;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return TooltipWidget(
      message: title,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                CommonContainerWidget(
                  margin: const EdgeInsets.symmetric(horizontal: AppConst.k12),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        image,
                      ],
                    ),
                  ),
                ),
                AppConst.gap6,
                Text(
                  title,
                  style: AppStyles.getRegularStyle(
                    fontSize: AppConst.k12,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: AppConst.k2.toInt(),
                ),
              ],
            ),
            if ((count ?? 0) != 0)
              Positioned(
                top: -4,
                right: AppConst.k5,
                child: Badge.count(
                  count: count ?? 0,
                  backgroundColor: AppColors.primary,
                  textStyle: AppStyles.getBoldStyle(
                    color: AppColors.white,
                    fontSize: AppConst.k12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
