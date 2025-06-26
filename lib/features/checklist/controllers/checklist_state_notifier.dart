import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/features/checklist/controllers/checklist_state.dart';
import 'package:riddhi_clone/features/checklist/models/get_check_list_request_model.dart';
import 'package:riddhi_clone/features/checklist/repository/checklist_repository.dart';

final checklistStateNotifierProvider = StateNotifierProvider<ChecklistStateNotifier, ChecklistState>((ref) {
  return ChecklistStateNotifier();
});

final checklistRepositoryProvider = Provider<ChecklistRepository>((ref) {
  return ChecklistRepository();
});

class ChecklistStateNotifier extends StateNotifier<ChecklistState> {
  ChecklistStateNotifier() : super(const ChecklistState());

  Future<void> getCheckList() async {
    try {
      state = state.copyWith(isLoading: true);

      final repository = ChecklistRepository();
      const requestModel = GetCheckListRequestModel();

      final result = await repository.getCheckList(requestModel: requestModel);

      result.fold(
        (failure) {
          LogHelper.logError('Get check list failed: ${failure.message}');
          state = state.copyWith(
            isLoading: false,
            errorMessage: failure.message,
          );
        },
        (checkListData) {
          LogHelper.logSuccess('Get check list success');
          state = state.copyWith(
            isLoading: false,
            checkListData: checkListData,
          );
        },
      );
    } catch (e) {
      LogHelper.logError('Get check list error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load check list data',
      );
    }
  }
}
