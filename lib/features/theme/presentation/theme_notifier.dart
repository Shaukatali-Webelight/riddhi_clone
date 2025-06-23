// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:master_utility/master_utility.dart';
// Project imports:
import 'package:riddhi_clone/constants/pref_keys.dart';

final themeStateNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    getPreferences();
  }

  void toggleTheme() {
    state = !state;
    PreferenceHelper.setBoolPrefValue(
      key: PreferenceKeys.themeKey,
      value: state,
    );
  }

  Future<void> getPreferences() async {
    state = PreferenceHelper.getBoolPrefValue(key: PreferenceKeys.themeKey) ?? false;
  }
}
