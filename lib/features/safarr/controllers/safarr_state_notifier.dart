import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riddhi_clone/features/safarr/controllers/safarr_state.dart';

class SafarrStateNotifier extends StateNotifier<SafarrState> {
  SafarrStateNotifier() : super(const SafarrState()) {
    _initializeSelectedStickers();
  }

  void _initializeSelectedStickers() {
    // Initialize with 7 selected stickers as shown in design
    final initialStickers = [
      'Hindi',
      'Foody',
      'Digital',
      'Ambitious',
      'Artist',
      'Taurus',
      'Arise',
    ];
    state = state.copyWith(selectedStickers: initialStickers);
  }

  void updateAgeRange(double minAge, double maxAge) {
    state = state.copyWith(
      minAge: minAge,
      maxAge: maxAge,
    );
  }

  void toggleSticker(String sticker) {
    final currentStickers = List<String>.from(state.selectedStickers);
    if (currentStickers.contains(sticker)) {
      currentStickers.remove(sticker);
    } else {
      currentStickers.add(sticker);
    }
    state = state.copyWith(selectedStickers: currentStickers);
  }

  void removeSticker(String sticker) {
    final currentStickers = List<String>.from(state.selectedStickers);
    currentStickers.remove(sticker);
    state = state.copyWith(selectedStickers: currentStickers);
  }

  void clearAllStickers() {
    state = state.copyWith(selectedStickers: []);
  }

  void updateStickerSearchQuery(String query) {
    state = state.copyWith(stickerSearchQuery: query);
  }

  List<String> get filteredStickers {
    if (state.stickerSearchQuery.isEmpty) {
      return state.availableStickers;
    }
    return state.availableStickers
        .where(
          (sticker) => sticker.toLowerCase().contains(state.stickerSearchQuery.toLowerCase()),
        )
        .toList();
  }

  void applyFilters() {
    // Here you would typically save filters or navigate back
    // For now, we'll just set loading state
    state = state.copyWith(isLoading: true);
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        state = state.copyWith(isLoading: false);
      }
    });
  }

  void resetFilters() {
    state = const SafarrState();
    _initializeSelectedStickers();
  }
}

final safarrStateNotifierProvider = StateNotifierProvider<SafarrStateNotifier, SafarrState>(
  (ref) => SafarrStateNotifier(),
);
