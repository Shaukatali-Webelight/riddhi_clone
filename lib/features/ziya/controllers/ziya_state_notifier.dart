// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:master_utility/master_utility.dart';
// Project imports:
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/features/ziya/controllers/ziya_state.dart';
import 'package:riddhi_clone/features/ziya/repository/ziya_repository.dart';
import 'package:riddhi_clone/resources/toast_helper.dart';

final ziyaRepositoryProvider = Provider<IZiyaRepository>((ref) {
  return ZiyaRepository();
});

final ziyaStateNotifierProvider = StateNotifierProvider<ZiyaStateNotifier, ZiyaState>((ref) {
  return ZiyaStateNotifier(ref.read(ziyaRepositoryProvider));
});

class ZiyaStateNotifier extends StateNotifier<ZiyaState> {
  ZiyaStateNotifier(this._ziyaRepository) : super(ZiyaState.initial());

  final IZiyaRepository _ziyaRepository;

  // Update bottom navigation index
  void updateBottomNavIndex(int index) {
    state = state.copyWith(currentBottomNavIndex: index);
  }

  // Set selected mood
  void setSelectedMood(String mood) {
    state = state.copyWith(selectedMood: mood);
  }

  // Fetch today's recommendations
  Future<void> getTodaysRecommendations() async {
    try {
      state = state.copyWith(isLoading: true);
      LogHelper.logInfo("Fetching today's recommendations...");

      // TODO: Implement API call when repository is ready
      // For now, using mock data
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(
        isLoading: false,
        todaysRecommendations: [
          'Morning Meditation',
          'Breathing Exercise',
          'Mindful Walking',
        ],
      );
    } catch (e) {
      LogHelper.logError("Get today's recommendations error: $e");
      state = state.copyWith(isLoading: false);
      AppToastHelper.showError(AppStrings.somethingWentWrong);
    }
  }

  // Fetch personal recommendations
  Future<void> getPersonalRecommendations() async {
    try {
      LogHelper.logInfo('Fetching personal recommendations...');

      // TODO: Implement API call when repository is ready
      // For now, using mock data
      await Future.delayed(const Duration(milliseconds: 500));

      state = state.copyWith(
        personalRecommendations: [
          'Sleep Stories',
          'Anxiety Relief',
          'Focus Music',
        ],
      );
    } catch (e) {
      LogHelper.logError('Get personal recommendations error: $e');
      AppToastHelper.showError(AppStrings.somethingWentWrong);
    }
  }

  // Fetch trending content
  Future<void> getTrendingContent() async {
    try {
      LogHelper.logInfo('Fetching trending content...');

      // TODO: Implement API call when repository is ready
      // For now, using mock data
      await Future.delayed(const Duration(milliseconds: 500));

      state = state.copyWith(
        trendingContent: [
          'Popular Meditation',
          'Stress Relief',
          'Better Sleep',
        ],
      );
    } catch (e) {
      LogHelper.logError('Get trending content error: $e');
      AppToastHelper.showError(AppStrings.somethingWentWrong);
    }
  }

  // Fetch new content
  Future<void> getNewContent() async {
    try {
      LogHelper.logInfo('Fetching new content...');

      // TODO: Implement API call when repository is ready
      // For now, using mock data
      await Future.delayed(const Duration(milliseconds: 500));

      state = state.copyWith(
        newContent: [
          'Latest Podcasts',
          'New Exercises',
          'Fresh Content',
        ],
      );
    } catch (e) {
      LogHelper.logError('Get new content error: $e');
      AppToastHelper.showError(AppStrings.somethingWentWrong);
    }
  }

  // Load all data
  Future<void> loadAllData() async {
    await Future.wait([
      getTodaysRecommendations(),
      getPersonalRecommendations(),
      getTrendingContent(),
      getNewContent(),
    ]);
  }
}
