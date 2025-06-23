// ignore_for_file: avoid_dynamic_calls, document_ignores

import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/features/home/views/widgets/chart_label_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesCardWidget extends StatelessWidget {
  const SalesCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final chartData = <ChartData>[
      ChartData('RSP', 65, AppColors.primary),
      ChartData('ABP', 35, AppColors.divider),
    ];
    return Container(
      height: AppConst.k160,
      width: AppConst.width,
      padding: const EdgeInsets.symmetric(horizontal: AppConst.k12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: AppConst.k4,
          ),
        ],
        borderRadius: BorderRadius.circular(AppConst.k8),
        border: Border.all(
          color: AppColors.divider,
          width: 0.5,
        ),
        color: AppColors.white,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.sales,
                  style: AppStyles.getBoldStyle(
                    fontSize: AppConst.k18,
                  ),
                ),
                AppConst.gap4,
                SizedBox(
                  width: AppConst.k200,
                  child: Text(
                    // keeping static for now
                    'Lorem ipsum is placeholder text commonly It is used in the graphic, print, placeholder text commonly used in the graphic, print',
                    style: AppStyles.getLightStyle(
                      fontSize: AppConst.k14,
                      color: AppColors.secondaryText,
                    ),
                    maxLines: AppConst.k5.toInt(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          AppConst.gap10,
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SfCircularChart(
                    margin: EdgeInsets.zero,
                    series: <CircularSeries<ChartData, String>>[
                      DoughnutSeries<ChartData, String>(
                        dataSource: chartData,
                        pointColorMapper: (ChartData data, _) => data.color,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        innerRadius: '65%',
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          builder: (data, point, series, pointIndex, seriesIndex) {
                            return Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppColors.divider,
                                  width: 0.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withValues(alpha: 0.08),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Text(
                                '${data.y.toInt()}%',
                                style: AppStyles.getBoldStyle(
                                  fontSize: AppConst.k14,
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChartLabelWidget(
                      color: AppColors.primary,
                      text: 'RSP',
                    ),
                    AppConst.gap16,
                    ChartLabelWidget(
                      color: AppColors.divider,
                      text: 'ABP',
                    ),
                  ],
                ),
                AppConst.gap8,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
