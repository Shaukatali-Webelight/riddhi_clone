import 'package:flutter/material.dart';

class SelectedStickersWidget extends StatelessWidget {
  const SelectedStickersWidget({
    required this.selectedStickers,
    required this.onRemoveSticker,
    required this.onClearAll,
    super.key,
  });
  final List<String> selectedStickers;
  final Function(String) onRemoveSticker;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with selected count and clear button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Selected Stickers (${selectedStickers.length}/7)',
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.9375,
                color: Color(0xFFF0ECE9),
              ),
            ),
            GestureDetector(
              onTap: onClearAll,
              child: Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFFFF9900),
                  ),
                ),
                child: const Text(
                  'Clear Stickers',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    height: 1.33,
                    letterSpacing: 0.704,
                    color: Color(0xFFFF9900),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Selected stickers row
        if (selectedStickers.isNotEmpty)
          SizedBox(
            height: 54,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: selectedStickers.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final sticker = selectedStickers[index];
                return _buildSelectedStickerChip(sticker);
              },
            ),
          )
        else
          Container(
            height: 54,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF3D3D3D).withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF4F4F4F),
              ),
            ),
            child: const Center(
              child: Text(
                'No stickers selected',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.43,
                  letterSpacing: 0.714,
                  color: Color(0xFF8B8B8B),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSelectedStickerChip(String sticker) {
    final stickerData = _getStickerData(sticker);

    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: stickerData['backgroundColor'] as Color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFFF9900),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Sticker icon
          Center(
            child: Icon(
              stickerData['icon'] as IconData,
              size: 24,
              color: stickerData['iconColor'] as Color,
            ),
          ),

          // Remove button (top-right corner)
          Positioned(
            top: 2,
            right: 2,
            child: GestureDetector(
              onTap: () => onRemoveSticker(sticker),
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF4444),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 10,
                  color: Color(0xFFF0ECE9),
                ),
              ),
            ),
          ),

          // Sticker name at bottom
          Positioned(
            bottom: 2,
            left: 2,
            right: 2,
            child: Text(
              sticker,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
                fontSize: 8,
                height: 1.0,
                color: Color(0xFFF0ECE9),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getStickerData(String sticker) {
    final stickerMap = {
      'Hindi': {
        'icon': Icons.translate,
        'backgroundColor': const Color(0xFF29ABE2),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Foody': {
        'icon': Icons.restaurant,
        'backgroundColor': const Color(0xFF006837),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Digital': {
        'icon': Icons.computer,
        'backgroundColor': const Color(0xFF76CEA2),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Ambitious': {
        'icon': Icons.trending_up,
        'backgroundColor': const Color(0xFFC0272D),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Artist': {
        'icon': Icons.palette,
        'backgroundColor': const Color(0xFF808080),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Taurus': {
        'icon': Icons.pets,
        'backgroundColor': const Color(0xFF006837),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Arise': {
        'icon': Icons.wb_sunny,
        'backgroundColor': const Color(0xFFC0272D),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Pisces': {
        'icon': Icons.waves,
        'backgroundColor': const Color(0xFF76CEA2),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Aquarius': {
        'icon': Icons.water_drop,
        'backgroundColor': const Color(0xFF29ABE2),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Capricon': {
        'icon': Icons.terrain,
        'backgroundColor': const Color(0xFF808080),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Charity': {
        'icon': Icons.favorite,
        'backgroundColor': const Color(0xFF662D91),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Brown': {
        'icon': Icons.circle,
        'backgroundColor': const Color(0xFF8C6239),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Leo': {
        'icon': Icons.brightness_7,
        'backgroundColor': const Color(0xFFFF931E),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Cancer': {
        'icon': Icons.circle_outlined,
        'backgroundColor': const Color(0xFF2E3192),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Gemini': {
        'icon': Icons.people,
        'backgroundColor': const Color(0xFFF9C138),
        'iconColor': const Color(0xFF000000),
      },
      'Aries': {
        'icon': Icons.flash_on,
        'backgroundColor': const Color(0xFFC0272D),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Scorpio': {
        'icon': Icons.bug_report,
        'backgroundColor': const Color(0xFF000000),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Virgo': {
        'icon': Icons.eco,
        'backgroundColor': const Color(0xFF8C6239),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Libra': {
        'icon': Icons.balance,
        'backgroundColor': const Color(0xFFFF7BAC),
        'iconColor': const Color(0xFFFFFFFF),
      },
      'Sagittarius': {
        'icon': Icons.arrow_upward,
        'backgroundColor': const Color(0xFF662D91),
        'iconColor': const Color(0xFFFFFFFF),
      },
    };

    return stickerMap[sticker] ??
        {
          'icon': Icons.circle,
          'backgroundColor': const Color(0xFF29ABE2),
          'iconColor': const Color(0xFFFFFFFF),
        };
  }
}
