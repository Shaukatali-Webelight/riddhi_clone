import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';

class ActivityLevelWidget extends StatelessWidget {
  const ActivityLevelWidget({
    required this.selectedActivity,
    required this.onActivityChanged,
    super.key,
  });

  final String selectedActivity;
  final void Function(String) onActivityChanged;

  static const List<Map<String, String>> _activities = [
    {'key': 'sedentary', 'label': 'Sedentary'},
    {'key': 'light', 'label': 'Light'},
    {'key': 'moderate', 'label': 'Moderate'},
    {'key': 'active', 'label': 'Active'},
    {'key': 'very_active', 'label': 'Very Active'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white),
      ),
      child: Column(
        children: [
          const Text(
            'ACTIVITY LEVEL',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _activities
                .map(
                  (activity) => GestureDetector(
                    onTap: () => onActivityChanged(activity['key']!),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selectedActivity == activity['key'] ? AppColors.primary : AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selectedActivity == activity['key'] ? AppColors.primary : AppColors.gray400,
                        ),
                      ),
                      child: Text(
                        activity['label']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: selectedActivity == activity['key'] ? AppColors.white : AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
