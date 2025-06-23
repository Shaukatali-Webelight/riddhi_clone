import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/assets.gen.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    required this.score,
    super.key,
  });

  final String score;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.k32,
      padding: const EdgeInsets.symmetric(horizontal: AppConst.k8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConst.k8),
        color: AppColors.white,
        border: Border.all(
          color: AppColors.coinColor,
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppAssets.icons.coin.svg(),
          AppConst.gap4,
          Flexible(
            child: Text(
              score,
              maxLines: AppConst.k1.toInt(),
              overflow: TextOverflow.ellipsis,
              style: AppStyles.getRegularStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
