// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:riddhi_clone/config/assets/colors.gen.dart';
// import 'package:riddhi_clone/constants/app_date_formats.dart';
// import 'package:riddhi_clone/constants/app_dimensions.dart';
// import 'package:riddhi_clone/constants/app_strings.dart';
// import 'package:riddhi_clone/constants/app_styles.dart';
// import 'package:riddhi_clone/features/home/controllers/home_state_notifier.dart';
// import 'package:riddhi_clone/features/home/views/widgets/notification_card_widget.dart';
// import 'package:riddhi_clone/resources/smart_refresh/refresh_header.dart';
// import 'package:riddhi_clone/widgets/common/back_arrow_app_bar.dart';
// import 'package:riddhi_clone/widgets/common/no_data_found_widget.dart';
// import 'package:riddhi_clone/widgets/loaders/app_loading_place_holder.dart';

// class NotificationScreen extends ConsumerStatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends ConsumerState<NotificationScreen> {
//   final refreshController = RefreshController();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       // await ref.read(homeStateNotifierProvider.notifier).getAllNotificationData();
//       // await ref.read(homeStateNotifierProvider.notifier).getApprovalCountData();
//     });
//   }

//   @override
//   void dispose() {
//     refreshController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final homeState = ref.watch(homeStateNotifierProvider);
//     final homeStateNotifier = ref.read(homeStateNotifierProvider.notifier);
//     final groupedNotifications = <String, List<NotificationItems>>{};

//     for (final notification in homeState.notificationData) {
//       if (notification.date != null) {
//         final dateTime = DateTime.parse(notification.date!);
//         final dateKey = _getDateKey(dateTime);
//         if (!groupedNotifications.containsKey(dateKey)) {
//           groupedNotifications[dateKey] = [];
//         }
//         groupedNotifications[dateKey]!.add(notification);
//       }
//     }

//     // Sort each group's notifications by date (newest first)
//     for (final key in groupedNotifications.keys) {
//       groupedNotifications[key]!.sort((a, b) {
//         if (a.date == null || b.date == null) return 0;
//         // Parse the dates and sort in descending order (newest first)
//         return DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!));
//       });
//     }

//     // Create an ordered list of keys to ensure proper display order
//     final orderedKeys = _getOrderedKeys(groupedNotifications.keys.toList());

//     return Scaffold(
//       appBar: BackArrowAppBar(
//         title: AppStrings.notifications,
//         actions: [
//           GestureDetector(
//             onTap: homeStateNotifier.markAllNotificationAsRead,
//             child: Padding(
//               padding: const EdgeInsets.only(right: AppConst.k16),
//               child: homeState.isReadAllLoading
//                   ? const SizedBox(
//                       height: AppConst.k18,
//                       width: AppConst.k18,
//                       child: CircularProgressIndicator(
//                         color: AppColors.primaryText,
//                         strokeWidth: AppConst.k2,
//                       ),
//                     )
//                   : Text(
//                       AppStrings.readAll,
//                       style: AppStyles.getRegularStyle(
//                         color: AppColors.primaryText,
//                         fontSize: AppConst.k14,
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//       body: SmartRefresher(
//         controller: refreshController,
//         onRefresh: () async {
//           await homeStateNotifier
//               .onRefreshNotifications(
//             refreshController: refreshController,
//           )
//               .whenComplete(() {
//             refreshController
//               ..refreshCompleted()
//               ..resetNoData();
//           });
//         },
//         footer: ClassicFooter(
//           textStyle: AppStyles.getRegularStyle(
//             color: AppColors.primary,
//           ),
//         ),
//         header: const AppWaterDropHeader(),
//         physics: const BouncingScrollPhysics(),
//         enablePullUp: homeState.notificationData.length > 19,
//         onLoading: () => homeStateNotifier.onLoadMoreNotifications(
//           refreshController: refreshController,
//         ),
//         child: homeState.isLoading
//             ? const AppLoadingPlaceHolder()
//             : (homeState.notificationData.isEmpty)
//                 ? const NoDataFoundWidget()
//                 : ListView.builder(
//                     padding: const EdgeInsets.all(AppConst.k12),
//                     itemCount: orderedKeys.length,
//                     itemBuilder: (context, index) {
//                       final dateKey = orderedKeys[index];
//                       final notificationsForDate = groupedNotifications[dateKey] ?? [];

//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(vertical: 8),
//                             child: Text(
//                               dateKey,
//                               style: AppStyles.getRegularStyle(
//                                 fontSize: AppConst.k14,
//                                 color: AppColors.secondaryText,
//                               ),
//                             ),
//                           ),
//                           ...notificationsForDate.map(
//                             (notification) => NotificationCard(
//                               notification: notification,
//                               onTap: () {
//                                 homeStateNotifier.onNotificationCardTap(
//                                   notificationId: notification.id ?? 0,
//                                   notificationType: notification.notificationType ?? '',
//                                   meta: notification.meta ?? Meta(),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//       ),
//     );
//   }

//   String _getDateKey(DateTime dateTime) {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yesterday = today.subtract(const Duration(days: 1));
//     final notificationDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

//     if (notificationDate == today) {
//       return AppStrings.today;
//     } else if (notificationDate == yesterday) {
//       return AppStrings.yesterday;
//     } else {
//       return DateFormat(AppDateFormats.ddMMMyyyy).format(dateTime);
//     }
//   }

//   // Helper method to sort the date keys in proper order (Today, Yesterday, then dates in descending order)
//   List<String> _getOrderedKeys(List<String> keys) {
//     // Create the result list that will hold keys in the correct order
//     final result = <String>[];
//     final dateStrings = <String>[];

//     // First check if Today and Yesterday exist in the keys
//     final hasToday = keys.contains(AppStrings.today);
//     final hasYesterday = keys.contains(AppStrings.yesterday);

//     // Always add Today first if it exists
//     if (hasToday) {
//       result.add(AppStrings.today);
//     }

//     // Add Yesterday second if it exists
//     if (hasYesterday) {
//       result.add(AppStrings.yesterday);
//     }

//     // Collect and sort all other date strings
//     for (final key in keys) {
//       if (key != AppStrings.today && key != AppStrings.yesterday) {
//         dateStrings.add(key);
//       }
//     }

//     // Sort date strings in descending order (newest first)
//     if (dateStrings.isNotEmpty) {
//       dateStrings.sort((a, b) {
//         try {
//           final dateA = DateFormat(AppDateFormats.ddMMMyyyy).parse(a);
//           final dateB = DateFormat(AppDateFormats.ddMMMyyyy).parse(b);
//           // Sort in descending order (newest dates first)
//           return dateB.compareTo(dateA);
//         } catch (e) {
//           return 0; // Keep original order if parsing fails
//         }
//       });

//       // Add sorted date strings after Today and Yesterday
//       result.addAll(dateStrings);
//     }

//     return result;
//   }
// }
