// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
// import 'package:riddhi_clone/config/assets/colors.gen.dart';
// import 'package:riddhi_clone/constants/app_dimensions.dart';
// import 'package:riddhi_clone/constants/app_strings.dart';
// import 'package:riddhi_clone/constants/app_styles.dart';
// import 'package:riddhi_clone/features/common/models/media_model.dart';
// import 'package:riddhi_clone/widgets/common/app_button.dart';
// import 'package:riddhi_clone/widgets/common/will_pop_scope_widget.dart';

// bool isUserOnSelfieUploadScreen = false;

// class SelfieUploadScreen extends StatefulWidget {
//   const SelfieUploadScreen({super.key, this.onSuccess});

//   final VoidCallback? onSuccess;

//   @override
//   State<SelfieUploadScreen> createState() => _SelfieUploadScreenState();
// }

// class _SelfieUploadScreenState extends State<SelfieUploadScreen> {
//   final _selfiePhotoMedia = ValueNotifier<Media?>(null);
//   @override
//   void initState() {
//     super.initState();
//     isUserOnSelfieUploadScreen = true;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _selfiePhotoMedia.value = null;
//     });
//   }

//   @override
//   void dispose() {
//     isUserOnSelfieUploadScreen = false;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _selfiePhotoMedia.value = null;
//     });
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScopeWidget(
//       canPop: false,
//       child: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: const SystemUiOverlayStyle(
//           statusBarColor: AppColors.primary,
//           statusBarIconBrightness: Brightness.dark,
//           systemNavigationBarColor: AppColors.scaffoldBg,
//           systemNavigationBarDividerColor: AppColors.scaffoldBg,
//           systemNavigationBarIconBrightness: Brightness.light,
//           statusBarBrightness: Brightness.light, // light == black status bar for IOS.
//         ),
//         child: Scaffold(
//           backgroundColor: AppColors.primary,
//           body: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(AppConst.k20),
//               child: ValueListenableBuilder(
//                 valueListenable: _selfiePhotoMedia,
//                 builder: (context, value, child) {
//                   final pickedFile = _selfiePhotoMedia.value?.localUrl ?? '';
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       InkWell(
//                         customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConst.k20)),
//                         onTap: () async {
//                           if ((_selfiePhotoMedia.value?.localUrl ?? '').isNotEmpty) {
//                             return;
//                           }
//                           // final ref = ProviderScope.containerOf(context);
//                           // final sdoStateNotifier = ref.read(sdoStateNotifierProvider.notifier);
//                           // await sdoStateNotifier.onSdoSelfiePhotoPick(
//                           //   onSuccess: (media) {
//                           //     _selfiePhotoMedia.value = media;
//                           //   },
//                           // );
//                         },
//                         child: AspectRatio(
//                           aspectRatio: 9 / 16,
//                           child: Container(
//                             clipBehavior: Clip.antiAliasWithSaveLayer,
//                             decoration: BoxDecoration(
//                               color: AppColors.black.withValues(alpha: 0.1),
//                               borderRadius: BorderRadius.circular(AppConst.k20),
//                               border: pickedFile.isNotEmpty
//                                   ? null
//                                   : DashedBorder.all(
//                                       dashLength: AppConst.k4,
//                                       color: AppColors.white,
//                                     ),
//                             ),
//                             child: pickedFile.isNotEmpty
//                                 ? Stack(
//                                     fit: StackFit.expand,
//                                     children: [
//                                       Image.file(
//                                         File(_selfiePhotoMedia.value?.localUrl ?? ''),
//                                         fit: BoxFit.cover,
//                                       ),
//                                       Positioned(
//                                         right: AppConst.k5,
//                                         top: AppConst.k5,
//                                         child: IconButton.filled(
//                                           onPressed: () {
//                                             _selfiePhotoMedia.value = null;
//                                           },
//                                           style: IconButton.styleFrom(
//                                             backgroundColor: AppColors.black.withValues(alpha: 0.5),
//                                           ),
//                                           icon: const Icon(Icons.clear, color: AppColors.white),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 : Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       const Icon(
//                                         Icons.add_a_photo_outlined,
//                                         color: AppColors.white,
//                                         size: AppConst.k100,
//                                       ),
//                                       AppConst.gap10,
//                                       Text(
//                                         AppStrings.captureSelfie,
//                                         textAlign: TextAlign.center,
//                                         style: AppStyles.getBoldStyle(color: AppColors.white),
//                                       ),
//                                     ],
//                                   ),
//                           ),
//                         ),
//                       ),
//                       Text(
//                         AppStrings.uploadSelfie,
//                         textAlign: TextAlign.center,
//                         style: AppStyles.getBoldStyle(color: AppColors.white),
//                       ),
//                       Consumer(
//                         builder: (context, ref, child) {
//                           final isLoading = ref.read(sdoStateNotifierProvider).isLoading;
//                           return AppButton(
//                             title: AppStrings.verify,
//                             isEnabled: pickedFile.isNotEmpty,
//                             disabledBackgroundColor: AppColors.white.withValues(alpha: 0.5),
//                             onPressed: () async {
//                               if (_selfiePhotoMedia.value == null) {
//                                 return;
//                               }
//                               final sdoStateNotifier = ref.read(sdoStateNotifierProvider.notifier);
//                               final isSuccess = await sdoStateNotifier.onSelfieVerifySubmit(_selfiePhotoMedia.value);
//                               if (isSuccess) {
//                                 isUserOnSelfieUploadScreen = false;
//                                 widget.onSuccess?.call();
//                               }
//                             },
//                             textColor: AppColors.primary,
//                             backgroundColor: AppColors.white,
//                             isLoading: isLoading,
//                           );
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
