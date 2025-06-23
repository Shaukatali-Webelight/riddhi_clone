import 'package:flutter/material.dart';

class StickerGridWidget extends StatelessWidget {
  const StickerGridWidget({
    required this.availableStickers,
    required this.selectedStickers,
    required this.onStickerTap,
    super.key,
  });
  final List<String> availableStickers;
  final List<String> selectedStickers;
  final Function(String) onStickerTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
      ),
      itemCount: availableStickers.length,
      itemBuilder: (context, index) {
        final sticker = availableStickers[index];
        final isSelected = selectedStickers.contains(sticker);
        return _buildStickerItem(sticker, isSelected);
      },
    );
  }

  Widget _buildStickerItem(String sticker, bool isSelected) {
    final stickerData = _getStickerData(sticker);

    return GestureDetector(
      onTap: () => onStickerTap(sticker),
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: stickerData['backgroundColor'] as Color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF9900) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sticker icon
            Icon(
              stickerData['icon'] as IconData,
              size: 24,
              color: stickerData['iconColor'] as Color,
            ),

            const SizedBox(height: 2),

            // Sticker name
            Text(
              sticker,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
                fontSize: 8,
                height: 1,
                color: stickerData['iconColor'] as Color,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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
