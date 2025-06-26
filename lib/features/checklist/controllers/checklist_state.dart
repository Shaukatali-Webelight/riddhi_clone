import 'package:riddhi_clone/features/checklist/models/get_check_list_response_model.dart';

class ChecklistState {
  const ChecklistState({
    this.isLoading = false,
    this.checkListData,
    this.errorMessage,
  });
  final bool isLoading;
  final GetCheckListData? checkListData;
  final String? errorMessage;

  ChecklistState copyWith({
    bool? isLoading,
    GetCheckListData? checkListData,
    String? errorMessage,
  }) {
    return ChecklistState(
      isLoading: isLoading ?? this.isLoading,
      checkListData: checkListData ?? this.checkListData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
