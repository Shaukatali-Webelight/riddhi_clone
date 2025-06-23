import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riddhi_clone/features/safarr/controllers/safarr_state_notifier.dart';
import 'package:riddhi_clone/features/safarr/views/widgets/age_range_widget.dart';
import 'package:riddhi_clone/features/safarr/views/widgets/selected_stickers_widget.dart';
import 'package:riddhi_clone/features/safarr/views/widgets/sticker_grid_widget.dart';
import 'package:riddhi_clone/features/safarr/views/widgets/sticker_search_widget.dart';

class SafarrFilterScreen extends ConsumerWidget {
  const SafarrFilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(safarrStateNotifierProvider);
    final notifier = ref.read(safarrStateNotifierProvider.notifier);

    return Container(
      width: 360,
      height: 800,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            Color(0xFF303030),
            Color(0xFF292929),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border.all(
          color: const Color(0x66F0ECE9), // 40% opacity
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                // Header with exact spacing
                _buildHeader(context),

                // Content with exact padding
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),

                          // Age Range Section
                          AgeRangeWidget(
                            minAge: state.minAge,
                            maxAge: state.maxAge,
                            onAgeChanged: notifier.updateAgeRange,
                          ),

                          const SizedBox(height: 16),

                          // Selected Stickers Section
                          SelectedStickersWidget(
                            selectedStickers: state.selectedStickers,
                            onRemoveSticker: notifier.removeSticker,
                            onClearAll: notifier.clearAllStickers,
                          ),

                          const SizedBox(height: 12),

                          // Search Field
                          StickerSearchWidget(
                            searchQuery: state.stickerSearchQuery,
                            onSearchChanged: notifier.updateStickerSearchQuery,
                          ),

                          const SizedBox(height: 16),

                          // Available Stickers Grid
                          StickerGridWidget(
                            availableStickers: notifier.filteredStickers,
                            selectedStickers: state.selectedStickers,
                            onStickerTap: notifier.toggleSticker,
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom Actions with exact spacing
                _buildBottomActions(context, notifier, state.isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Filters',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w500,
              fontSize: 20,
              height: 1.6,
              letterSpacing: 0.8,
              color: Color(0xFFF0ECE9),
            ),
          ),
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.info_outline,
                color: Color(0xFFF0ECE9),
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, SafarrStateNotifier notifier, bool isLoading) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Apply Button with exact styling
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      notifier.applyFilters();
                      Navigator.of(context).pop();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFAEB50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF292929)),
                      ),
                    )
                  : const Text(
                      'Apply',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 1.43,
                        letterSpacing: 0.714,
                        color: Color(0xFF292929),
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 8),

          // Cancel Button with exact styling
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.43,
                  letterSpacing: 0.714,
                  color: Color(0xFFF0ECE9),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
