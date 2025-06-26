import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/api_endpoints.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/features/checklist/controllers/checklist_state_notifier.dart';
import 'package:riddhi_clone/features/checklist/models/get_check_list_response_model.dart';
import 'package:riddhi_clone/helpers/api_helper.dart';
import 'package:riddhi_clone/widgets/common/app_button.dart';
import 'package:riddhi_clone/widgets/loaders/app_loader.dart';

class CheckListScreen extends ConsumerStatefulWidget {
  const CheckListScreen({super.key});

  @override
  ConsumerState<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends ConsumerState<CheckListScreen> {
  Set<String> completedTasks = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LogHelper.logInfo('CheckListScreen: Starting API call...');
      _testDirectApiCall();
      ref.read(checklistStateNotifierProvider.notifier).getCheckList();
    });
  }

  // Temporary test method to debug API issues
  Future<void> _testDirectApiCall() async {
    try {
      LogHelper.logInfo('Testing direct API call...');

      // Use the same pattern as home repository which works
      final response = await ApiHelper.instance.get(
        url: APIEndpoints.homeData,
        fromJson: (data) {
          LogHelper.logSuccess('Direct API call successful: $data');
          return data;
        },
      );

      LogHelper.logInfo('Direct API Response - hasError: ${response.hasError}, statusCode: ${response.statusCode}');
      if (response.hasError) {
        LogHelper.logError('Direct API Error: ${response.message}');
      }
    } catch (e, stackTrace) {
      LogHelper.logError('Direct API Exception: $e');
      LogHelper.logError('Direct API Stack trace: $stackTrace');
    }
  }

  void _loadDemoData() {
    // Create dummy data for testing UI
    const demoData = GetCheckListData(
      id: 123,
      username: 'Demo User',
      email: 'demo@example.com',
      phone: '1234567890',
      isActive: true,
      zones: [Zone(id: 1, name: 'Demo Zone')],
      regions: [Region(id: '1', name: 'Demo Region')],
      territories: [Territory(id: '1', name: 'Demo Territory')],
      subRegions: [SubRegion(id: '1', name: 'Demo Sub Region')],
      role: Role(
        id: 1,
        name: 'Demo Role',
        modules: [
          Module(
            id: 1,
            name: 'Demo Module',
            childModules: [
              ChildModule(id: 1, name: 'Demo Child Module', permissions: []),
            ],
          ),
        ],
      ),
      customers: [Customer(id: '1', customerName: 'Demo Customer')],
      apkVersion: '1.0.0',
    );

    // Update the state directly with demo data
    ref.read(checklistStateNotifierProvider.notifier).state = ref.read(checklistStateNotifierProvider).copyWith(
          isLoading: false,
          checkListData: demoData,
        );
  }

  void _toggleTask(String taskId) {
    setState(() {
      if (completedTasks.contains(taskId)) {
        completedTasks.remove(taskId);
      } else {
        completedTasks.add(taskId);
      }
    });
  }

  List<ChecklistItem> _generateChecklistItems(GetCheckListData data) {
    return [
      ChecklistItem(
        id: 'profile_complete',
        title: 'Complete Profile Information',
        subtitle: 'Username: ${data.username ?? 'Not provided'}',
        isCompleted: data.username?.isNotEmpty == true && data.email?.isNotEmpty == true,
      ),
      ChecklistItem(
        id: 'contact_verify',
        title: 'Verify Contact Details',
        subtitle: 'Phone: ${data.phone ?? 'Not provided'}',
        isCompleted: data.phone?.isNotEmpty == true,
      ),
      ChecklistItem(
        id: 'location_setup',
        title: 'Setup Location Details',
        subtitle: 'Territory: ${data.territories?.isNotEmpty == true ? data.territories!.first.name : 'Not assigned'}',
        isCompleted: data.territories?.isNotEmpty == true,
      ),
      ChecklistItem(
        id: 'role_assign',
        title: 'Role Assignment',
        subtitle: 'Role: ${data.role?.name ?? 'Not assigned'}',
        isCompleted: data.role != null,
      ),
      ChecklistItem(
        id: 'permissions_verify',
        title: 'Verify Permissions',
        subtitle: 'Modules: ${data.role?.modules?.length ?? 0} assigned',
        isCompleted: (data.role?.modules?.length ?? 0) > 0,
      ),
      ChecklistItem(
        id: 'customer_mapping',
        title: 'Customer Mapping',
        subtitle: 'Customers: ${data.customers?.length ?? 0} mapped',
        isCompleted: (data.customers?.length ?? 0) > 0,
      ),
      ChecklistItem(
        id: 'app_setup',
        title: 'App Setup Complete',
        subtitle: 'Version: ${data.apkVersion ?? 'Unknown'}',
        isCompleted: data.apkVersion?.isNotEmpty == true,
      ),
      ChecklistItem(
        id: 'account_active',
        title: 'Account Activation',
        subtitle: 'Status: ${data.isActive == true ? 'Active' : 'Inactive'}',
        isCompleted: data.isActive == true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final checklistState = ref.watch(checklistStateNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        title: Text(
          'Setup Checklist',
          style: AppStyles.getBoldStyle(
            color: AppColors.white,
            fontSize: AppConst.k18,
          ),
        ),
        elevation: 0,
      ),
      body: checklistState.isLoading
          ? const Center(child: AppLoader())
          : checklistState.errorMessage != null
              ? _buildErrorState(checklistState.errorMessage!)
              : checklistState.checkListData != null
                  ? _buildChecklistContent(checklistState.checkListData!)
                  : _buildEmptyState(),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConst.k20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppConst.k60,
              color: AppColors.red,
            ),
            const Gap(AppConst.k16),
            Text(
              'Error',
              style: AppStyles.getBoldStyle(
                fontSize: AppConst.k20,
                color: AppColors.primaryText,
              ),
            ),
            const Gap(AppConst.k8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: AppStyles.getRegularStyle(
                fontSize: AppConst.k14,
                color: AppColors.grayMid,
              ),
            ),
            const Gap(AppConst.k12),
            // Show detailed error for debugging
            Container(
              padding: const EdgeInsets.all(AppConst.k12),
              decoration: BoxDecoration(
                color: AppColors.lightRed,
                borderRadius: BorderRadius.circular(AppConst.k8),
              ),
              child: Text(
                'Debug Info: $errorMessage',
                textAlign: TextAlign.center,
                style: AppStyles.getRegularStyle(
                  fontSize: AppConst.k12,
                  color: AppColors.red,
                ),
              ),
            ),
            const Gap(AppConst.k24),
            AppButton(
              title: AppStrings.retry,
              onPressed: () {
                LogHelper.logInfo('Retry button pressed');
                ref.read(checklistStateNotifierProvider.notifier).getCheckList();
              },
              width: AppConst.k120,
            ),
            const Gap(AppConst.k16),
            AppButton(
              title: 'Test with Demo Data',
              backgroundColor: AppColors.secondary,
              onPressed: () {
                LogHelper.logInfo('Testing with demo data');
                _loadDemoData();
              },
              width: AppConst.k160,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConst.k20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.checklist_outlined,
              size: AppConst.k60,
              color: AppColors.grayMid,
            ),
            const Gap(AppConst.k16),
            Text(
              'No Data Available',
              style: AppStyles.getBoldStyle(
                fontSize: AppConst.k20,
                color: AppColors.primaryText,
              ),
            ),
            const Gap(AppConst.k8),
            Text(
              'Please check your connection and try again.',
              textAlign: TextAlign.center,
              style: AppStyles.getRegularStyle(
                fontSize: AppConst.k14,
                color: AppColors.grayMid,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistContent(GetCheckListData data) {
    final checklistItems = _generateChecklistItems(data);
    final completedCount = checklistItems.where((item) => item.isCompleted || completedTasks.contains(item.id)).length;
    final totalCount = checklistItems.length;
    final progress = completedCount / totalCount;

    return Column(
      children: [
        _buildProgressHeader(completedCount, totalCount, progress),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(AppConst.k16),
            itemCount: checklistItems.length,
            separatorBuilder: (context, index) => const Gap(AppConst.k12),
            itemBuilder: (context, index) {
              final item = checklistItems[index];
              final isCompleted = item.isCompleted || completedTasks.contains(item.id);

              return _buildChecklistItem(
                item: item,
                isCompleted: isCompleted,
                onTap: () => _toggleTask(item.id),
              );
            },
          ),
        ),
        if (progress == 1.0) _buildCompletionBanner(),
      ],
    );
  }

  Widget _buildProgressHeader(int completed, int total, double progress) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConst.k20),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppConst.k20),
          bottomRight: Radius.circular(AppConst.k20),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Setup Progress',
            style: AppStyles.getBoldStyle(
              color: AppColors.white,
              fontSize: AppConst.k16,
            ),
          ),
          const Gap(AppConst.k12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.white.withValues(alpha: 0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.white),
            minHeight: AppConst.k8,
          ),
          const Gap(AppConst.k8),
          Text(
            '$completed of $total tasks completed',
            style: AppStyles.getRegularStyle(
              color: AppColors.white,
              fontSize: AppConst.k14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem({
    required ChecklistItem item,
    required bool isCompleted,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: item.isCompleted ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConst.k16),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: isCompleted ? AppColors.green : AppColors.grayLight,
          ),
          borderRadius: BorderRadius.circular(AppConst.k12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: AppConst.k8,
              offset: const Offset(0, AppConst.k2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: AppConst.k24,
              height: AppConst.k24,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.green : AppColors.white,
                border: Border.all(
                  color: isCompleted ? AppColors.green : AppColors.grayLight,
                  width: AppConst.k2,
                ),
                borderRadius: BorderRadius.circular(AppConst.k4),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: AppConst.k16,
                    )
                  : null,
            ),
            const Gap(AppConst.k16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppStyles.getBoldStyle(
                      fontSize: AppConst.k16,
                      color: isCompleted ? AppColors.green : AppColors.primaryText,
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (item.subtitle.isNotEmpty) ...[
                    const Gap(AppConst.k4),
                    Text(
                      item.subtitle,
                      style: AppStyles.getRegularStyle(
                        fontSize: AppConst.k12,
                        color: AppColors.grayMid,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (item.isCompleted)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConst.k8,
                  vertical: AppConst.k4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppConst.k12),
                ),
                child: Text(
                  'Auto',
                  style: AppStyles.getMediumStyle(
                    fontSize: AppConst.k10,
                    color: AppColors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppConst.k16),
      padding: const EdgeInsets.all(AppConst.k20),
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(AppConst.k12),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.celebration,
            color: AppColors.white,
            size: AppConst.k32,
          ),
          const Gap(AppConst.k8),
          Text(
            'Congratulations!',
            style: AppStyles.getBoldStyle(
              color: AppColors.white,
              fontSize: AppConst.k18,
            ),
          ),
          const Gap(AppConst.k4),
          Text(
            'All setup tasks completed successfully',
            textAlign: TextAlign.center,
            style: AppStyles.getRegularStyle(
              color: AppColors.white,
              fontSize: AppConst.k14,
            ),
          ),
        ],
      ),
    );
  }
}

class ChecklistItem {
  const ChecklistItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
  });
  final String id;
  final String title;
  final String subtitle;
  final bool isCompleted;
}
