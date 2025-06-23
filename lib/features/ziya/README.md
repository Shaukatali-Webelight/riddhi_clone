# Ziya Feature

A wellness and mental health application feature built with Flutter following the project's established architecture patterns.

## Overview

Ziya is a comprehensive wellness app feature that provides users with personalized mental health content, meditation exercises, sleep care, and life stage guidance. The UI is pixel-perfectly designed based on the provided Figma specifications.

## Architecture

The feature follows the established project architecture:

```
lib/features/ziya/
├── controllers/              # State management
│   ├── ziya_state.dart      # State model
│   └── ziya_state_notifier.dart  # Riverpod state notifier
├── models/                  # Data models (future expansion)
├── repository/              # Data access layer
│   └── ziya_repository.dart # API and data repository
├── views/                   # UI components
│   ├── ziya_home_screen.dart    # Main home screen
│   ├── ziya_main_screen.dart    # Main screen with navigation
│   └── widgets/             # Reusable UI widgets
│       ├── ziya_bottom_nav_widget.dart
│       ├── ziya_content_section_widget.dart
│       ├── ziya_header_widget.dart
│       └── ziya_selected_mood_widget.dart
└── ziya_demo.dart          # Standalone demo runner
```

## Features

### 1. Bottom Navigation (ZiyaBottomNavWidget)
- 5 navigation items: Home, MindCare, Ask to Zora (Chat), SleepCare, LifeStage
- Glassmorphism design with backdrop filter
- Active state management
- Center chat button with special styling
- Responsive design matching Figma specifications

### 2. Home Screen (ZiyaHomeScreen)
- Background image with gradient overlays
- Header with greeting and quick navigation
- Selected mood display with glassmorphism effect
- Content sections:
  - Today's on Zora
  - Recommended for you
  - Trending On Zora
  - New on Zora

### 3. Header Widget (ZiyaHeaderWidget)
- Full-width background image
- Multiple gradient overlays for visual depth
- App bar with menu and notifications
- Personalized greeting
- Quick navigation pills
- Smooth gradient transition to content

### 4. Selected Mood Widget (ZiyaSelectedMoodWidget)
- Glassmorphism card design
- Mood icon and text
- Change button for mood selection
- Backdrop filter effects

### 5. Content Sections (ZiyaContentSectionWidget)
- Horizontal scrolling content cards
- Loading states with shimmer effects
- Empty state handling
- Network images with fallback
- Duration indicators

## Design System

### Colors
Based on Figma specifications:
- Primary Blue: `#51ADE8` to `#2076B0` (gradient)
- Glass effect: `#1C6A9E` with opacity variations
- White overlays with various opacity levels

### Typography
- Uses project's `AppStyles` system
- Font weights: 400 (regular), 500 (medium), 600 (regular), 700 (bold)
- Font sizes: 10px to 20px following design specs

### Layout
- Container width: 360px (mobile-first design)
- Header height: 400px
- Bottom nav height: 72px
- Consistent 16px horizontal padding
- 24px vertical spacing between sections

## State Management

Uses Riverpod with the following providers:

### ZiyaStateNotifierProvider
```dart
final ziyaStateNotifierProvider = StateNotifierProvider<ZiyaStateNotifier, ZiyaState>
```

#### State Properties:
- `currentBottomNavIndex`: Active navigation index
- `isLoading`: Loading state for API calls
- `selectedMood`: User's current mood selection
- `todaysRecommendations`: Today's content list
- `personalRecommendations`: Personalized content
- `trendingContent`: Trending items
- `newContent`: Latest content

#### Available Actions:
- `updateBottomNavIndex(int index)`: Change navigation
- `setSelectedMood(String mood)`: Update mood
- `loadAllData()`: Load all content sections
- Individual content loading methods

## Demo Usage

To run the Ziya feature independently:

```dart
// Run the demo
flutter run lib/features/ziya/ziya_demo.dart
```

Or integrate into the main app by navigating to `ZiyaMainScreen`.

## Integration

To integrate into the main app:

1. Import the main screen:
```dart
import 'package:riddhi_clone/features/ziya/views/ziya_main_screen.dart';
```

2. Navigate to the screen:
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ZiyaMainScreen()),
);
```

## API Integration

The repository currently uses mock data. To integrate with real APIs:

1. Update the repository methods in `ziya_repository.dart`
2. Replace mock data with actual API calls
3. Add proper error handling
4. Create data models for API responses

## Future Enhancements

1. **Screen Implementation**: Complete MindCare, Chat, SleepCare, and LifeStage screens
2. **Mood Selection**: Interactive mood selection interface
3. **Content Detail**: Detail screens for content items
4. **Offline Support**: Cache content for offline viewing
5. **Animations**: Smooth transitions and micro-interactions
6. **Personalization**: AI-driven content recommendations
7. **Audio Integration**: Background music and sound effects

## Dependencies

The feature uses the following project dependencies:
- `flutter_riverpod`: State management
- `master_utility`: Utility functions
- `shimmer`: Loading animations (via ShimmerContainerWidget)

## Testing

To test the feature:

1. Run `flutter analyze lib/features/ziya/` for static analysis
2. Use the demo file for visual testing
3. Test state management with different navigation scenarios
4. Verify responsive design on different screen sizes

## Performance Considerations

- Uses `IndexedStack` for navigation to maintain state
- Efficient list building with `ListView.builder`
- Network image caching
- Proper widget disposal in state notifier
- Minimal rebuilds with targeted state watching 