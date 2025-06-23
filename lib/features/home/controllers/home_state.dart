import 'package:riddhi_clone/features/home/models/get_approval_count_response_model.dart';
import 'package:riddhi_clone/features/home/models/get_home_data_response_model.dart';

class HomeState {
  HomeState({
    required this.isLoading,
    required this.homeData,
    required this.approvalCountData,
  });

  HomeState.initial();

  bool isLoading = false;
  GetHomeDataData? homeData;
  GetApprovalCountData? approvalCountData;

  HomeState copyWith({
    bool? isLoading,
    GetHomeDataData? homeData,
    GetApprovalCountData? approvalCountData,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      homeData: homeData ?? this.homeData,
      approvalCountData: approvalCountData ?? this.approvalCountData,
    );
  }
}
