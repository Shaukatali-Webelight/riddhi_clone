import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:riddhi_clone/config/assets/assets.gen.dart';
// Project imports:
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_enums.dart' as app_enums;
import 'package:riddhi_clone/constants/app_enums.dart';
import 'package:riddhi_clone/constants/app_semantic_labels.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/features/health_calculator/views/health_calculator_screen.dart';
import 'package:riddhi_clone/features/home/controllers/home_state.dart';
import 'package:riddhi_clone/features/home/controllers/home_state_notifier.dart';
import 'package:riddhi_clone/features/home/models/get_home_data_response_model.dart';
import 'package:riddhi_clone/features/home/models/home_component_model.dart';
import 'package:riddhi_clone/features/home/views/widgets/meeting_goals_widget.dart';
import 'package:riddhi_clone/features/home/views/widgets/sales_card_widget.dart';
import 'package:riddhi_clone/features/home/views/widgets/score_widget.dart';
import 'package:riddhi_clone/features/home/views/widgets/selection_card_widget.dart';
import 'package:riddhi_clone/helpers/app_navigation.dart';
import 'package:riddhi_clone/resources/smart_refresh/refresh_header.dart';
import 'package:riddhi_clone/widgets/loaders/app_loading_place_holder.dart';
import 'package:riddhi_clone/widgets/loaders/shimmer_container_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final refreshController = RefreshController();
  ProviderContainer? ref;
  final List<HomeComponent> homeComponents = [
    HomeComponent(
      image: AppAssets.icons.homeBell.svg(
        semanticsLabel: AppSemanticLabels.homeBell,
      ),
      title: AppStrings.orderApproval,
      moduleId: ModuleIDs.orderApproval.value,
    ),
    HomeComponent(
      image: AppAssets.icons.homeBell.svg(
        semanticsLabel: AppSemanticLabels.homeBell,
      ),
      title: AppStrings.sdoAppointments,
      moduleId: ModuleIDs.sdoAppointment.value,
    ),
    HomeComponent(
      image: AppAssets.icons.homeBell.svg(
        semanticsLabel: AppSemanticLabels.homeBell,
      ),
      title: AppStrings.sdoTermination,
      moduleId: ModuleIDs.sdoTermination.value,
    ),
    HomeComponent(
      image: AppAssets.icons.homeBell.svg(
        semanticsLabel: AppSemanticLabels.homeBell,
      ),
      title: AppStrings.demoMaterial,
      moduleId: ModuleIDs.demoMaterial.value,
    ),
    HomeComponent(
      image: AppAssets.icons.homeBell.svg(
        semanticsLabel: AppSemanticLabels.homeBell,
      ),
      title: AppStrings.rsp,
      moduleId: ModuleIDs.rsp.value,
    ),
    // Health Calculator Component
    HomeComponent(
      image: AppAssets.icons.person.svg(
        semanticsLabel: 'Health Calculator',
        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
      ),
      title: 'Health Calculator',
      moduleId: 999, // Using a unique module ID for health calculator
    ),
  ];

  List<HomeComponent> _getFilteredComponents(List<ChildModule> mobileChildModules) {
    // Always include the health calculator component
    final filteredComponents = homeComponents.where((component) {
      // Include health calculator regardless of permissions
      if (component.moduleId == 999) return true;

      return mobileChildModules.any(
        (module) => module.id == component.moduleId,
      );
    }).toList();

    return filteredComponents;
  }

  Future<void> _onTap(HomeComponent component, WidgetRef ref) async {
    // Handle health calculator specifically
    if (component.moduleId == 999) {
      await AppNavigation.push(page: const HealthCalculatorScreen());
      return;
    }

    // Handle other modules (commented out existing logic can be restored here)
    // final module = HomeModule.values.where((e) => e.value == component.moduleId).firstOrNull ?? HomeModule.NONE;
    // switch (module) {
    //   case HomeModule.ORDER_APPROVAL:
    //     await AppNavigation.push(page: const OrderApprovalNavBarScreen());
    //   case HomeModule.SDO_APPOINTMENT:
    //     await AppNavigation.push(page: const SDOAppointmentBottomNavBar());
    //   case HomeModule.SDO_TERMINATION:
    //     await AppNavigation.push(page: const SDOTerminationBottomNavBar());
    //   case HomeModule.DEMO_MATERIAL:
    //     await AppNavigation.push(page: const DemoMaterialScreen());
    //   case HomeModule.RSP:
    //     await AppNavigation.push(page: _getRSPScreen(ref));
    //   case HomeModule.NONE:
    //     AppToastHelper.showInfo('Coming soon');
    // }
  }

  String getGreetingBasedOnTime() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref = ProviderScope.containerOf(context);
      final homeStateNotifier = ref?.read(homeStateNotifierProvider.notifier);
      homeStateNotifier?.getApprovalCount();
      homeStateNotifier?.getHomeData();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref?.read(homeStateNotifierProvider.notifier).resetLoader();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryLight,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.scaffoldBg,
        systemNavigationBarDividerColor: AppColors.scaffoldBg,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light, // light == black status bar for IOS.
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              final homeState = ref.watch(homeStateNotifierProvider);
              final homeStateNotifier = ref.read(homeStateNotifierProvider.notifier);
              final mobileChildModules = homeState.homeData?.role?.modules
                      ?.where((module) => module.name?.toLowerCase() == ModuleType.mobile.value)
                      .toList()
                      .firstOrNull
                      ?.childModules
                      ?.where(
                        (childModule) =>
                            childModule.permissions?.any(
                              (permission) => permission.name == app_enums.Permission.read.value,
                            ) ??
                            false,
                      )
                      .toList() ??
                  [];
              final filteredComponents = _getFilteredComponents(mobileChildModules);
              return Column(
                children: [
                  Container(
                    color: AppColors.primaryLight,
                    padding: const EdgeInsets.symmetric(horizontal: AppConst.k12).copyWith(top: AppConst.k16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: AppConst.k46,
                              width: AppConst.k46,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(AppConst.k8),
                                ),
                                border: Border.all(
                                  color: AppColors.divider,
                                  width: 0.5,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: homeState.isLoading
                                  ? ShimmerContainerWidget(
                                      child: Text(
                                        //!TODO: using for now will remove later
                                        'U',
                                        style: AppStyles.getBoldStyle(
                                          fontSize: AppConst.k28,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      homeState.homeData?.username?.substring(0, 1).toUpperCase() ?? '',
                                      style: AppStyles.getBoldStyle(
                                        fontSize: AppConst.k28,
                                        color: AppColors.primary,
                                      ),
                                    ),
                            ),
                            AppConst.gap12,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppStrings.hi,
                                        style: AppStyles.getLightStyle(
                                          fontSize: AppConst.k14,
                                        ),
                                      ),
                                      AppConst.gap4,
                                      Expanded(
                                        child: homeState.isLoading
                                            ? ShimmerContainerWidget(
                                                child: Text(
                                                  //!TODO: using for now will remove later
                                                  'User',
                                                  style: AppStyles.getLightStyle(
                                                    fontSize: AppConst.k14,
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                homeState.homeData?.username ?? '',
                                                style: AppStyles.getLightStyle(
                                                  fontSize: AppConst.k14,
                                                ),
                                                maxLines: AppConst.k1.toInt(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    getGreetingBasedOnTime(),
                                    style: AppStyles.getBoldStyle(
                                      fontSize: AppConst.k16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppConst.gap12,
                            const ScoreWidget(score: '500'),
                            AppConst.gap8,
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: AppConst.k32,
                                  width: AppConst.k32,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(AppConst.k8),
                                    ),
                                    border: Border.all(
                                      color: AppColors.divider,
                                      width: 0.5,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    // onTap: () => AppNavigation.push(
                                    //   page: const NotificationScreen(),
                                    // ),
                                    child: AppAssets.icons.notificationBell.svg(
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.primaryText,
                                        BlendMode.srcIn,
                                      ),
                                      semanticsLabel: AppSemanticLabels.notificationBell,
                                    ),
                                  ),
                                ),
                                if (homeState.approvalCountData?.unreadNotificationCount != null &&
                                    (homeState.approvalCountData?.unreadNotificationCount ?? 0) > 0) ...[
                                  Positioned(
                                    top: -6,
                                    right: -4,
                                    child: Badge.count(
                                      count: homeState.approvalCountData?.unreadNotificationCount ?? 0,
                                      backgroundColor: AppColors.primary,
                                      textStyle: AppStyles.getBoldStyle(
                                        color: AppColors.primary,
                                        fontSize: AppConst.k10,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            AppConst.gap4,
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (homeState.isLoading) ...[
                    const Expanded(
                      child: AppLoadingPlaceHolder(),
                    ),
                  ] else ...[
                    Expanded(
                      child: SmartRefresher(
                        header: const AppWaterDropHeader(),
                        controller: refreshController,
                        onRefresh: () {
                          homeStateNotifier.getApprovalCount();
                          homeStateNotifier.getHomeData().then(
                                (value) => refreshController.refreshCompleted(),
                              );
                        },
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.primaryLight,
                                      AppColors.scaffoldBg,
                                    ],
                                    stops: [0.4, 1.0],
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: AppConst.k12),
                                child: const Column(
                                  children: [
                                    AppConst.gap16,
                                    SalesCardWidget(),
                                    AppConst.gap16,
                                    MeetingGoalsWidget(
                                      progress: 0.4,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppConst.k12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppConst.gap16,
                                    if (filteredComponents.isEmpty)
                                      const Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.error_outline,
                                              size: 48,
                                              color: AppColors.primary,
                                            ),
                                            AppConst.gap16,
                                            Text(
                                              'No Data Found',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            AppConst.gap8,
                                            Text(
                                              "You don't have access to any modules",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    else ...[
                                      Text(
                                        AppStrings.moreShortCuts,
                                        style: AppStyles.getBoldStyle(
                                          fontSize: AppConst.k16,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      AppConst.gap16,
                                      GridView.builder(
                                        padding: const EdgeInsets.only(bottom: AppConst.k70),
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: filteredComponents.length,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisExtent: 120,
                                          crossAxisCount: 4,
                                        ),
                                        itemBuilder: (context, index) {
                                          final component = filteredComponents[index];
                                          return SelectionCardWidget(
                                            title: component.title,
                                            image: component.image,
                                            onTap: () async {
                                              await _onTap(component, ref);
                                            },
                                            count: getCount(
                                              homeState: homeState,
                                              component: component,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  int getCount({
    required HomeState homeState,
    required HomeComponent component,
  }) {
    // Handle health calculator specifically
    if (component.moduleId == 999) {
      return 0; // No count for health calculator
    }

    final module = HomeModule.values.where((e) => e.value == component.moduleId).firstOrNull ?? HomeModule.NONE;
    switch (module) {
      case HomeModule.ORDER_APPROVAL:
        return 0;
      case HomeModule.SDO_APPOINTMENT:
        return homeState.approvalCountData?.sdoPendingAppointmentCount ?? 0;
      case HomeModule.SDO_TERMINATION:
        return homeState.approvalCountData?.sdoPendingTerminationCount ?? 0;
      case HomeModule.DEMO_MATERIAL:
        return 0;
      case HomeModule.RSP:
        return 0;
      case HomeModule.NONE:
        return 0;
    }
  }
}
