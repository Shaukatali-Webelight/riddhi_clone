import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/features/health_calculator/models/health_data_model.dart';

class GenderSelectionWidget extends StatelessWidget {
  const GenderSelectionWidget({
    required this.selectedGender,
    required this.onGenderChanged,
    super.key,
  });

  final Gender selectedGender;
  final void Function(Gender) onGenderChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onGenderChanged(Gender.male),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: selectedGender == Gender.male ? AppColors.primaryLight : AppColors.grayLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedGender == Gender.male ? AppColors.white : AppColors.gray400,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.male,
                    size: 48,
                    color: selectedGender == Gender.male ? AppColors.primary : AppColors.gray400,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'MALE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: selectedGender == Gender.male ? AppColors.primary : AppColors.gray400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => onGenderChanged(Gender.female),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: selectedGender == Gender.female ? AppColors.primaryLight : AppColors.grayLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedGender == Gender.female ? AppColors.white : AppColors.gray400,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.female,
                    size: 48,
                    color: selectedGender == Gender.female ? AppColors.primary : AppColors.gray400,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'FEMALE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: selectedGender == Gender.female ? AppColors.primary : AppColors.gray400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
