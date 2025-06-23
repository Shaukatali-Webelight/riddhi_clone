// import 'package:flutter/material.dart';
// import 'package:riddhi_clone/config/assets/colors.gen.dart';
// import 'package:riddhi_clone/constants/app_date_formats.dart';
// import 'package:riddhi_clone/constants/app_dimensions.dart';
// import 'package:riddhi_clone/constants/app_styles.dart';
// import 'package:riddhi_clone/features/home/models/get_all_notification_data_response_model.dart';
// import 'package:riddhi_clone/features/home/views/widgets/demo_chip_widget.dart';
// import 'package:riddhi_clone/widgets/common/common_container_widget.dart';

// class NotificationCard extends StatelessWidget {
//   const NotificationCard({
//     required this.notification,
//     required this.onTap,
//     super.key,
//   });
//   final NotificationItems notification;
//   final void Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: CommonContainerWidget(
//         color: (notification.isRead ?? false) ? AppColors.grayLight : AppColors.white,
//         margin: const EdgeInsets.only(bottom: AppConst.k8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     notification.title ?? '',
//                     style: AppStyles.getBoldStyle(
//                       fontSize: AppConst.k16,
//                     ),
//                     maxLines: AppConst.k1.toInt(),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 DemoChipWidget(
//                   title: notification.notificationType ?? '',
//                   bgColor: AppColors.inProgressChip,
//                   textColor: AppColors.white,
//                   borderColor: AppColors.inProgressChip,
//                 ),
//               ],
//             ),
//             AppConst.gap4,
//             Text(
//               notification.body ?? '',
//               style: AppStyles.getLightStyle(
//                 fontSize: AppConst.k12,
//                 color: AppColors.secondaryText,
//               ),
//             ),
//             if ((notification.meta?.reason ?? '').isNotEmpty) ...[
//               AppConst.gap8,
//               Text.rich(
//                 TextSpan(
//                   text: 'Reason: ',
//                   style: AppStyles.getRegularStyle(
//                     fontSize: AppConst.k12,
//                     color: AppColors.primaryText,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: notification.meta?.reason ?? '',
//                       style: AppStyles.getLightStyle(
//                         fontSize: AppConst.k12,
//                         color: AppColors.secondaryText,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//             const Divider(
//               color: AppColors.divider,
//               height: AppConst.k16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   AppDateFormats.formatDate(DateTime.parse(notification.date ?? ''), AppDateFormats.ddMMyyyy),
//                   style: AppStyles.getRegularStyle(
//                     fontSize: AppConst.k11,
//                     color: AppColors.secondaryText,
//                   ),
//                 ),
//                 Text(
//                   AppDateFormats.formatDate(DateTime.parse(notification.date ?? ''), AppDateFormats.hmma),
//                   style: AppStyles.getRegularStyle(
//                     fontSize: AppConst.k11,
//                     color: AppColors.secondaryText,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
