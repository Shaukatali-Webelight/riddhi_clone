import 'package:equatable/equatable.dart';

class SafarrState extends Equatable {
  const SafarrState({
    this.isLoading = false,
    this.minAge = 20.0,
    this.maxAge = 25.0,
    this.selectedStickers = const [],
    this.stickerSearchQuery = '',
    this.availableStickers = const [
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
    ],
  });

  final bool isLoading;
  final double minAge;
  final double maxAge;
  final List<String> selectedStickers;
  final String stickerSearchQuery;
  final List<String> availableStickers;

  SafarrState copyWith({
    bool? isLoading,
    double? minAge,
    double? maxAge,
    List<String>? selectedStickers,
    String? stickerSearchQuery,
    List<String>? availableStickers,
  }) {
    return SafarrState(
      isLoading: isLoading ?? this.isLoading,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      selectedStickers: selectedStickers ?? this.selectedStickers,
      stickerSearchQuery: stickerSearchQuery ?? this.stickerSearchQuery,
      availableStickers: availableStickers ?? this.availableStickers,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        minAge,
        maxAge,
        selectedStickers,
        stickerSearchQuery,
        availableStickers,
      ];
}
