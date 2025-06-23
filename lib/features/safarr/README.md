# Safarr Feature

This feature implements the Safarr filter functionality, allowing users to filter content based on age range and selected stickers.

## Structure

The safarr feature follows the standard feature structure:

```
lib/features/safarr/
├── controllers/
│   ├── safarr_state.dart          # State class with filtering data
│   └── safarr_state_notifier.dart # Riverpod state notifier for managing filter state
├── models/
│   └── sticker_model.dart         # Model for sticker data
├── repository/
│   └── safarr_repository.dart     # Data layer for API calls
├── views/
│   ├── widgets/
│   │   ├── age_range_widget.dart      # Age range slider component
│   │   ├── selected_stickers_widget.dart # Shows selected stickers with remove option
│   │   ├── sticker_search_widget.dart    # Search field for filtering stickers
│   │   └── sticker_grid_widget.dart      # Grid display of available stickers
│   └── safarr_filter_screen.dart      # Main filter popup screen
└── README.md                      # This documentation file
```

## Features

### SafarrFilterScreen
- **Purpose**: Main filter popup screen based on Figma design
- **Components**:
  - Header with "Filters" title and info icon
  - Age range selector (20-25 by default)
  - Selected stickers display with clear functionality
  - Search field for sticker filtering
  - Grid of available stickers with selection
  - Apply/Cancel buttons

### State Management
- Uses Riverpod for state management
- `SafarrState` holds:
  - Age range (min/max)
  - Selected stickers list
  - Search query
  - Available stickers
  - Loading state

### Widgets

#### AgeRangeWidget
- Custom range slider for age selection
- Shows current range (e.g., "20 - 25")
- Interactive slider with orange accent color

#### SelectedStickersWidget
- Horizontal scrolling list of selected stickers
- Each sticker shows with remove (X) button
- "Clear Stickers" button to remove all
- Shows count (e.g., "Selected Stickers (7/7)")

#### StickerSearchWidget
- Search field with search icon
- Real-time filtering of available stickers
- Dark theme styling to match design

#### StickerGridWidget
- 5-column grid layout of available stickers
- Each sticker shows icon and name
- Visual feedback for selected state
- Color-coded by category/type

## Design Implementation

The implementation closely follows the provided Figma design:
- Dark gradient background (#303030 to #292929)
- Rounded top corners (16px radius)
- Yellow (#FAEB50) apply button
- Various sticker colors based on categories
- Proper spacing and typography

## Usage

```dart
// Show filter screen as modal bottom sheet
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => const SafarrFilterScreen(),
);
```

## State Management

```dart
// Access the state and notifier
final state = ref.watch(safarrStateNotifierProvider);
final notifier = ref.read(safarrStateNotifierProvider.notifier);

// Update age range
notifier.updateAgeRange(18.0, 30.0);

// Toggle sticker selection
notifier.toggleSticker('Digital');

// Clear all stickers
notifier.clearAllStickers();

// Apply filters
notifier.applyFilters();
```

## Dependencies

- `flutter_riverpod` - State management
- `equatable` - Value equality for state classes
- Standard Flutter widgets and Material Design components 