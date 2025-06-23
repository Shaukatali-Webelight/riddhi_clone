import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/features/health_calculator/models/health_data_model.dart';
import 'package:riddhi_clone/features/health_calculator/views/widgets/health_calculator_body_widget.dart';

class HealthCalculatorScreen extends StatelessWidget {
  const HealthCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final healthModel = HealthDataModel(
      gender: Gender.male,
      height: 175,
      weight: 70,
      age: 25,
    );

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text(
          'Health Calculator',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: HealthCalculatorBodyWidget(model: healthModel),
    );
  }
}
