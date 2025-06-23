import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/assets.gen.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_enums.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/resources/app_utils.dart';
import 'package:riddhi_clone/widgets/common/tooltip_widget.dart';

class TimelineContentsWidget extends StatelessWidget {
  const TimelineContentsWidget({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    super.key,
    this.rejected,
    this.onTap,
  });

  final String title;
  final String description;
  final String? date;
  final TimelineStatus status;
  final bool? rejected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: TooltipWidget(
                      message: title,
                      child: Text(
                        title,
                        style: AppStyles.getRegularStyle(
                          color: AppUtils.getTimeLineStatusColor(status),
                        ),
                        maxLines: AppConst.k1.toInt(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  AppConst.gap5,
                  Text(
                    date ?? '',
                    style: AppStyles.getLightStyle(color: AppColors.secondaryText, fontSize: AppConst.k11),
                    maxLines: AppConst.k1.toInt(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (rejected ?? false) ...[
              AppConst.gap5,
              GestureDetector(
                onTap: onTap,
                child: AppAssets.icons.rejectReason.svg(),
              ),
            ],
          ],
        ),
        Text(
          description,
          style: AppStyles.getLightStyle(
            color: AppColors.secondaryText,
            fontSize: AppConst.k12,
          ),
          maxLines: AppConst.k2.toInt(),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
