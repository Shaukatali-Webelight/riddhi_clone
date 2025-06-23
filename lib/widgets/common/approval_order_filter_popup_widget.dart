// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riddhi_clone/config/assets/colors.gen.dart';
// import 'package:riddhi_clone/constants/app_dimensions.dart';
// import 'package:riddhi_clone/constants/app_enums.dart';
// import 'package:riddhi_clone/constants/app_semantic_labels.dart';
// import 'package:riddhi_clone/constants/app_strings.dart';
// import 'package:riddhi_clone/constants/app_styles.dart';
// import 'package:riddhi_clone/helpers/app_navigation.dart';
// import 'package:riddhi_clone/widgets/common/app_button.dart';
// import 'package:riddhi_clone/widgets/common/app_divider.dart';

// class ApprovalOrderFilterPopupWidget extends StatefulWidget {
//   const ApprovalOrderFilterPopupWidget({
//     this.isFromReturnOrder = false,
//     super.key,
//   });
//   final bool isFromReturnOrder;

//   void show() => showModalBottomSheet<void>(
//         backgroundColor: AppColors.white,
//         context: globalContext,
//         builder: (context) => this,
//         isScrollControlled: true,
//       );

//   static void hide() => AppNavigation.back();

//   @override
//   State<ApprovalOrderFilterPopupWidget> createState() => _ApprovalOrderFilterPopupWidgetState();
// }

// class _ApprovalOrderFilterPopupWidgetState extends State<ApprovalOrderFilterPopupWidget> {
//   final _fromDateController = TextEditingController();
//   final _toDateController = TextEditingController();
//   final orderStatusNotifier = ValueNotifier(OrderStatusFilter.all);

//   final ValueNotifier<bool> areDateFieldsFilledNotifier = ValueNotifier<bool>(false);

//   void _updateDateFieldsStatus() {
//     final areFieldsFilled = _fromDateController.text.isNotEmpty && _toDateController.text.isNotEmpty;
//     areDateFieldsFilledNotifier.value = areFieldsFilled;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fromDateController.addListener(_updateDateFieldsStatus);
//     _toDateController.addListener(_updateDateFieldsStatus);
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       final ref = ProviderScope.containerOf(context);
//       final orderApprovalState = ref.read(orderApprovalStateNotifierProvider);
//       orderStatusNotifier.value = orderApprovalState.approvalOrderFilterStatus ?? OrderStatusFilter.all;
//       final fromDate = orderApprovalState.approvalOrderFilterFromDate ?? '';
//       final toDate = orderApprovalState.approvalOrderFilterToDate ?? '';

//       _fromDateController.text = fromDate.isEmpty ? '' : fromDate;
//       _toDateController.text = toDate.isEmpty ? '' : toDate;
//       _updateDateFieldsStatus();
//     });
//   }

//   @override
//   void dispose() {
//     _fromDateController.dispose();
//     _toDateController.dispose();
//     _fromDateController.removeListener(_updateDateFieldsStatus);
//     _toDateController.removeListener(_updateDateFieldsStatus);
//     areDateFieldsFilledNotifier.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(AppConst.k8),
//       ),
//       child: Consumer(
//         builder: (context, ref, child) {
//           final orderApprovalState = ref.watch(orderApprovalStateNotifierProvider);
//           final orderApprovalStateNotifier = ref.read(orderApprovalStateNotifierProvider.notifier);

//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: AppConst.k16, vertical: AppConst.k12),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       AppStrings.filter,
//                       style: AppStyles.getBoldStyle(fontSize: AppConst.k22),
//                     ),
//                     GestureDetector(
//                       onTap: ApprovalOrderFilterPopupWidget.hide,
//                       child: const Icon(
//                         Icons.close,
//                         color: AppColors.secondaryText,
//                         semanticLabel: AppSemanticLabels.closeIcon,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const AppDivider(height: AppConst.k1),
//               Padding(
//                 padding: const EdgeInsets.all(AppConst.k16).copyWith(bottom: AppConst.bottomPadding + AppConst.k10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       AppStrings.dateRange,
//                       style: AppStyles.getBoldStyle(fontSize: AppConst.k16),
//                     ),
//                     AppConst.gap8,
//                     //! Date Range
//                     Row(
//                       children: [
//                         Expanded(
//                           child: DateFieldWidget(
//                             text: AppStrings.fromDate,
//                             controller: _fromDateController,
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime.now(),
//                           ),
//                         ),
//                         AppConst.gap16,
//                         Expanded(
//                           child: DateFieldWidget(
//                             text: AppStrings.toDate,
//                             controller: _toDateController,
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime.now(),
//                           ),
//                         ),
//                       ],
//                     ),
//                     AppConst.gap16,
//                     //! Status
//                     Text(
//                       AppStrings.status,
//                       style: AppStyles.getBoldStyle(fontSize: AppConst.k16),
//                     ),
//                     AppConst.gap8,
//                     FilterStatusWidget(
//                       orderStatusNotifier: orderStatusNotifier,
//                     ),
//                     //! Buttons
//                     AppConst.gap24,
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ValueListenableBuilder(
//                             valueListenable: areDateFieldsFilledNotifier,
//                             builder: (context, value, child) {
//                               return AppButton(
//                                 title: AppStrings.apply,
//                                 onPressed: () {
//                                   orderApprovalStateNotifier.changeApprovalOrderDateFilters(
//                                     fromDate: _fromDateController.text,
//                                     toDate: _toDateController.text,
//                                     approvalOrderFilterStatus: orderStatusNotifier.value,
//                                   );
//                                   orderApprovalStateNotifier.getAllApprovalAndReturnOrderData(
//                                     isReturnOrder: widget.isFromReturnOrder,
//                                   );
//                                   ApprovalOrderFilterPopupWidget.hide();
//                                 },
//                                 width: AppConst.k156,
//                                 isLoading: orderApprovalState.isApprovalOrderLoading,
//                                 isEnabled: areDateFieldsFilledNotifier.value,
//                               );
//                             },
//                           ),
//                         ),
//                         AppConst.gap16,
//                         Expanded(
//                           child: AppButton(
//                             title: AppStrings.clear,
//                             onPressed: () {
//                               ApprovalOrderFilterPopupWidget.hide();
//                               final ref = ProviderScope.containerOf(context);
//                               final orderApprovalState = ref.read(orderApprovalStateNotifierProvider);
//                               orderApprovalState.approvalOrderFilterStatus = OrderStatusFilter.all;
//                               orderApprovalState.approvalOrderFilterFromDate = '';
//                               orderApprovalState.approvalOrderFilterToDate = '';
//                               orderApprovalStateNotifier.getAllApprovalAndReturnOrderData(
//                                 isReturnOrder: widget.isFromReturnOrder,
//                               );
//                             },
//                             backgroundColor: AppColors.primaryLight,
//                             textColor: AppColors.primary,
//                             width: AppConst.k156,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
