// import 'package:flutter/material.dart';
// import 'package:riddhi_clone/config/assets/colors.gen.dart';
// import 'package:riddhi_clone/constants/app_dimensions.dart';
// import 'package:riddhi_clone/constants/app_styles.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class GraphWidget extends StatelessWidget {
//   const GraphWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final chartData = <ChartData>[
//       ChartData('RSP', 65, AppColors.primary),
//       ChartData('ABP', 35, AppColors.divider),
//     ];
//     return SfCircularChart(
//       margin: EdgeInsets.zero,
//       series: <CircularSeries<ChartData, String>>[
//         DoughnutSeries<ChartData, String>(
//           dataSource: chartData,
//           pointColorMapper: (ChartData data, _) => data.color,
//           xValueMapper: (ChartData data, _) => data.x,
//           yValueMapper: (ChartData data, _) => data.y,
//           innerRadius: '65%',
//           dataLabelSettings: DataLabelSettings(
//             isVisible: true,
//             builder: (data, point, series, pointIndex, seriesIndex) {
//               return Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.circular(4),
//                   border: Border.all(
//                     color: AppColors.divider,
//                     width: 0.5,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.primary.withValues(alpha: 0.08),
//                       blurRadius: 4,
//                     ),
//                   ],
//                 ),
//                 child: Text(
//                   '${(data as ChartData).y.toInt()}%',
//                   style: AppStyles.getBoldStyle(
//                     fontSize: AppConst.k14,
//                     color: AppColors.primary,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
