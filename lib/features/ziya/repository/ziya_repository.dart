// Package imports:
import 'package:dartz/dartz.dart';
import 'package:master_utility/master_utility.dart';
// Project imports:
import 'package:riddhi_clone/constants/type_defs.dart';
import 'package:riddhi_clone/features/common/models/failure_model.dart';

abstract interface class IZiyaRepository {
  FutureEither<List<String>> getTodaysRecommendations();
  FutureEither<List<String>> getPersonalRecommendations();
  FutureEither<List<String>> getTrendingContent();
  FutureEither<List<String>> getNewContent();
}

class ZiyaRepository implements IZiyaRepository {
  @override
  FutureEither<List<String>> getTodaysRecommendations() async {
    try {
      LogHelper.logInfo("Fetching today's recommendations...");

      // TODO: Implement actual API call
      await Future.delayed(const Duration(seconds: 1));

      final mockData = [
        'Morning Meditation',
        'Breathing Exercise',
        'Mindful Walking',
      ];

      return right(mockData);
    } catch (e) {
      LogHelper.logError("Get today's recommendations error: $e");
      return left(Failure(message: _getTodaysRecommendationsError()));
    }
  }

  @override
  FutureEither<List<String>> getPersonalRecommendations() async {
    try {
      LogHelper.logInfo('Fetching personal recommendations...');

      // TODO: Implement actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final mockData = [
        'Sleep Stories',
        'Anxiety Relief',
        'Focus Music',
      ];

      return right(mockData);
    } catch (e) {
      LogHelper.logError('Get personal recommendations error: $e');
      return left(Failure(message: _getPersonalRecommendationsError()));
    }
  }

  @override
  FutureEither<List<String>> getTrendingContent() async {
    try {
      LogHelper.logInfo('Fetching trending content...');

      // TODO: Implement actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final mockData = [
        'Popular Meditation',
        'Stress Relief',
        'Better Sleep',
      ];

      return right(mockData);
    } catch (e) {
      LogHelper.logError('Get trending content error: $e');
      return left(Failure(message: _getTrendingContentError()));
    }
  }

  @override
  FutureEither<List<String>> getNewContent() async {
    try {
      LogHelper.logInfo('Fetching new content...');

      // TODO: Implement actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final mockData = [
        'Latest Podcasts',
        'New Exercises',
        'Fresh Content',
      ];

      return right(mockData);
    } catch (e) {
      LogHelper.logError('Get new content error: $e');
      return left(Failure(message: _getNewContentError()));
    }
  }

  String _getTodaysRecommendationsError() {
    return "Unable to load today's recommendations. Please check your connection and try again.";
  }

  String _getPersonalRecommendationsError() {
    return 'Unable to load personal recommendations. Please check your connection and try again.';
  }

  String _getTrendingContentError() {
    return 'Unable to load trending content. Please check your connection and try again.';
  }

  String _getNewContentError() {
    return 'Unable to load new content. Please check your connection and try again.';
  }
}
