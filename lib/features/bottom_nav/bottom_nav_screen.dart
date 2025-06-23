import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/config/assets/assets.gen.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_enums.dart' as AppEnums;
import 'package:riddhi_clone/constants/app_enums.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/features/customer/views/customer_screen.dart';
import 'package:riddhi_clone/features/home/controllers/home_state.dart';
import 'package:riddhi_clone/features/home/controllers/home_state_notifier.dart';
import 'package:riddhi_clone/features/home/models/get_home_data_response_model.dart';
import 'package:riddhi_clone/features/home/views/home_page.dart';
import 'package:riddhi_clone/resources/toast_helper.dart';
import 'package:riddhi_clone/services/notification/firebase_notification_service.dart';
import 'package:riddhi_clone/widgets/common/confirmation_dialog.dart';
import 'package:riddhi_clone/widgets/common/will_pop_scope_widget.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final selectedIndex = ValueNotifier(0);

  final List<Widget> screens = [
    const HomePage(),
    const CustomerScreen(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
    // const CustomerScreen(),
    // const CustomerScreen(),
    // const DemoScreen(),
    // const MoreScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await FirebaseMessagingService.instance.getInitialMessage();
    });
  }

  @override
  void dispose() {
    selectedIndex.dispose();
    FirebaseMessagingService.instance.dispose();
    super.dispose();
  }

  bool _hasModuleAccess(List<ChildModule> modules, int moduleId) {
    return modules.any(
      (module) =>
          module.id == moduleId &&
          (module.permissions?.any((permission) => permission.name == AppEnums.Permission.read.value) ?? false),
    );
  }

  void _handleNavigation(int index, HomeState homeState) {
    final mobileChildModules = homeState.homeData?.role?.modules
            ?.where((module) => module.name?.toLowerCase() == ModuleType.mobile.value)
            .toList()
            .firstOrNull
            ?.childModules
            ?.where(
              (childModule) =>
                  childModule.permissions?.any(
                    (permission) => permission.name == AppEnums.Permission.read.value,
                  ) ??
                  false,
            )
            .toList() ??
        [];

    switch (BottomNavBarIndex.values[index]) {
      case BottomNavBarIndex.home:
        selectedIndex.value = index;
      case BottomNavBarIndex.customer:
        if (_hasModuleAccess(mobileChildModules, ModuleIDs.customer.value)) {
          selectedIndex.value = index;
        } else {
          AppToastHelper.showInfo(AppStrings.youDontHaveAccessToThisModule);
        }
      case BottomNavBarIndex.startDay:
        AppToastHelper.showInfo('Under development');
      case BottomNavBarIndex.meetings:
        if (_hasModuleAccess(mobileChildModules, ModuleIDs.meetings.value)) {
          selectedIndex.value = index;
        } else {
          AppToastHelper.showInfo(AppStrings.youDontHaveAccessToThisModule);
        }
      case BottomNavBarIndex.more:
        selectedIndex.value = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScopeWidget(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        ConfirmDialog(
          title: AppStrings.exit,
          onYesPressed: (_) {
            NavigationHelper.navigatePop();
            SystemNavigator.pop();
          },
          conformationMessage: AppStrings.exitMessage,
        ).show();
      },
      child: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, value, _) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: screens[value],
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConst.k16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildNavItem(
                      BottomNavBarIndex.home.value,
                      AppAssets.icons.homeIcon.svg(
                        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                      ),
                      AppStrings.home,
                      value,
                    ),
                    AppConst.gap5,
                    buildNavItem(
                      BottomNavBarIndex.customer.value,
                      AppAssets.icons.customerIcon.svg(
                        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                      ),
                      AppStrings.customers,
                      value,
                    ),
                    AppConst.gap5,
                    buildNavItem(
                      BottomNavBarIndex.startDay.value,
                      AppAssets.icons.calenderToday.svg(
                        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                      ),
                      AppStrings.startDay,
                      value,
                    ),
                    AppConst.gap5,
                    buildNavItem(
                      BottomNavBarIndex.meetings.value,
                      AppAssets.icons.meetingsIcon.svg(
                        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                      ),
                      AppStrings.meetings,
                      value,
                    ),
                    AppConst.gap5,
                    buildNavItem(
                      BottomNavBarIndex.more.value,
                      const Icon(
                        Icons.more_horiz,
                        color: AppColors.white,
                        size: AppConst.k18,
                      ),
                      AppStrings.more,
                      value,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildNavItem(int index, Widget icon, String label, int selectedIndex) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => _handleNavigation(index, ProviderScope.containerOf(context).read(homeStateNotifierProvider)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: AppConst.k500.toInt()),
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: AppConst.k16, vertical: AppConst.k12)
            : const EdgeInsets.all(AppConst.k12),
        decoration: ShapeDecoration(
          color: isSelected ? AppColors.primary : AppColors.primaryText.withValues(alpha: 0.6),
          shape: isSelected
              ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConst.k100))
              : const CircleBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            if (isSelected) ...[
              AppConst.gap8,
              Text(
                label,
                style: AppStyles.getRegularStyle(
                  fontSize: AppConst.k12,
                  color: AppColors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
