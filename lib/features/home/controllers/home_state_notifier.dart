import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/features/home/controllers/home_state.dart';
import 'package:riddhi_clone/features/home/repository/home_repository.dart';
import 'package:riddhi_clone/resources/toast_helper.dart';

final homeRepositoryProvider = Provider<IHomeRepository>((ref) {
  return HomeRepository();
});

final homeStateNotifierProvider = StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier(ref.read(homeRepositoryProvider));
});

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier(this._homeRepository) : super(HomeState.initial());

  final IHomeRepository _homeRepository;

  // Get Home Data method
  Future<void> getHomeData() async {
    try {
      state = state.copyWith(isLoading: true);
      LogHelper.logInfo('Fetching home data...');

      final response = await _homeRepository.getHomeData();

      response.fold(
        (failure) {
          LogHelper.logError('Get home data failed: ${failure.message}');
          state = state.copyWith(isLoading: false);
          AppToastHelper.showError(failure.message);
        },
        (homeData) {
          LogHelper.logInfo('Home data fetched successfully');
          state = state.copyWith(
            isLoading: false,
            homeData: homeData,
          );
        },
      );
    } catch (e) {
      LogHelper.logError('Get home data error: $e');
      state = state.copyWith(isLoading: false);
      AppToastHelper.showError(AppStrings.somethingWentWrong);
    }
  }

  Future<void> getApprovalCount() async {
    LogHelper.logInfo('Getting approval count...');
    state = state.copyWith(isLoading: true);

    final response = await _homeRepository.getApprovalCount();

    response.fold(
      (failure) {
        LogHelper.logError('Get approval count failed: ${failure.message}');
        state = state.copyWith(isLoading: false);
      },
      (data) {
        LogHelper.logSuccess('Get approval count success');
        state = state.copyWith(
          isLoading: false,
        );
      },
    );
  }
}
