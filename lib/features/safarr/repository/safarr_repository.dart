import 'package:flutter_riverpod/flutter_riverpod.dart';

class SafarrRepository {
  // Simulate API calls for filter operations

  Future<Map<String, dynamic>> applyFilters({
    required double minAge,
    required double maxAge,
    required List<String> selectedStickers,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Simulate successful response
      return {
        'success': true,
        'message': 'Filters applied successfully',
        'data': {
          'minAge': minAge,
          'maxAge': maxAge,
          'selectedStickers': selectedStickers,
        },
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to apply filters: $e',
        'data': null,
      };
    }
  }

  Future<Map<String, dynamic>> getAvailableStickers() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Return static list of stickers
      final stickers = [
        'Hindi',
        'Foody',
        'Digital',
        'Ambitious',
        'Artist',
        'Taurus',
        'Arise',
        'Pisces',
        'Aquarius',
        'Capricon',
        'Charity',
        'Brown',
        'Leo',
        'Cancer',
        'Gemini',
        'Aries',
        'Scorpio',
        'Virgo',
        'Libra',
        'Sagittarius',
      ];

      return {
        'success': true,
        'message': 'Stickers fetched successfully',
        'data': {'stickers': stickers},
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to fetch stickers: $e',
        'data': null,
      };
    }
  }

  Future<Map<String, dynamic>> saveUserPreferences({
    required Map<String, dynamic> preferences,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 600));

      return {
        'success': true,
        'message': 'User preferences saved successfully',
        'data': preferences,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to save preferences: $e',
        'data': null,
      };
    }
  }
}

final safarrRepositoryProvider = Provider<SafarrRepository>(
  (ref) => SafarrRepository(),
);
