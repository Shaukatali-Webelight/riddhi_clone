class ZiyaState {
  ZiyaState({
    required this.currentBottomNavIndex,
    required this.isLoading,
    required this.selectedMood,
    required this.todaysRecommendations,
    required this.personalRecommendations,
    required this.trendingContent,
    required this.newContent,
  });

  ZiyaState.initial()
      : currentBottomNavIndex = 0,
        isLoading = false,
        selectedMood = '',
        todaysRecommendations = [],
        personalRecommendations = [],
        trendingContent = [],
        newContent = [];

  int currentBottomNavIndex;
  bool isLoading;
  String selectedMood;
  List<String> todaysRecommendations;
  List<String> personalRecommendations;
  List<String> trendingContent;
  List<String> newContent;

  ZiyaState copyWith({
    int? currentBottomNavIndex,
    bool? isLoading,
    String? selectedMood,
    List<String>? todaysRecommendations,
    List<String>? personalRecommendations,
    List<String>? trendingContent,
    List<String>? newContent,
  }) {
    return ZiyaState(
      currentBottomNavIndex: currentBottomNavIndex ?? this.currentBottomNavIndex,
      isLoading: isLoading ?? this.isLoading,
      selectedMood: selectedMood ?? this.selectedMood,
      todaysRecommendations: todaysRecommendations ?? this.todaysRecommendations,
      personalRecommendations: personalRecommendations ?? this.personalRecommendations,
      trendingContent: trendingContent ?? this.trendingContent,
      newContent: newContent ?? this.newContent,
    );
  }
}
