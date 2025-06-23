import 'package:flutter/material.dart';

class StickerSearchWidget extends StatelessWidget {
  const StickerSearchWidget({
    required this.searchQuery,
    required this.onSearchChanged,
    super.key,
  });
  final String searchQuery;
  final Function(String) onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF242424),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFF4F4F4F),
        ),
      ),
      child: TextFormField(
        initialValue: searchQuery,
        onChanged: onSearchChanged,
        style: const TextStyle(
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.43,
          letterSpacing: 0.714,
          color: Color(0xFFF0ECE9),
        ),
        decoration: InputDecoration(
          hintText: 'Search stickers...',
          hintStyle: const TextStyle(
            fontFamily: 'Outfit',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.43,
            letterSpacing: 0.714,
            color: Color(0xFF8B8B8B),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          suffixIcon: searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: () => onSearchChanged(''),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Color(0xFF8B8B8B),
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.search,
                    size: 16,
                    color: Color(0xFF8B8B8B),
                  ),
                ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 32,
            minHeight: 32,
          ),
        ),
        cursorColor: const Color(0xFFFF9900),
        cursorHeight: 18,
      ),
    );
  }
}
