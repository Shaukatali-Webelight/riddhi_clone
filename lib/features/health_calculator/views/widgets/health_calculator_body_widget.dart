import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/features/health_calculator/models/health_data_model.dart';
import 'package:riddhi_clone/features/health_calculator/views/health_results_screen.dart';
import 'package:riddhi_clone/features/health_calculator/views/widgets/activity_level_widget.dart';
import 'package:riddhi_clone/features/health_calculator/views/widgets/calculate_button_widget.dart';
import 'package:riddhi_clone/features/health_calculator/views/widgets/gender_selection_widget.dart';
import 'package:riddhi_clone/features/health_calculator/views/widgets/height_slider_widget.dart';
import 'package:riddhi_clone/features/health_calculator/views/widgets/number_input_widget.dart';

class HealthCalculatorBodyWidget extends StatefulWidget {
  const HealthCalculatorBodyWidget({
    required this.model,
    super.key,
  });

  final HealthDataModel model;

  @override
  State<HealthCalculatorBodyWidget> createState() => _HealthCalculatorBodyWidgetState();
}

class _HealthCalculatorBodyWidgetState extends State<HealthCalculatorBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primary,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              // Gender Selection
              GenderSelectionWidget(
                selectedGender: widget.model.gender,
                onGenderChanged: (gender) => setState(() {
                  widget.model.gender = gender;
                }),
              ),

              const SizedBox(height: 20),

              // Height Slider
              HeightSliderWidget(
                height: widget.model.height,
                onHeightChanged: (height) => setState(() {
                  widget.model.height = height.toInt();
                }),
              ),

              const SizedBox(height: 20),

              // Weight and Age Row
              Row(
                children: [
                  Expanded(
                    child: NumberInputWidget(
                      title: 'Weight (kg)',
                      value: widget.model.weight,
                      onIncrement: () => setState(() {
                        widget.model.weight++;
                      }),
                      onDecrement: () => setState(() {
                        if (widget.model.weight > 1) widget.model.weight--;
                      }),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: NumberInputWidget(
                      title: 'Age',
                      value: widget.model.age,
                      onIncrement: () => setState(() {
                        widget.model.age++;
                      }),
                      onDecrement: () => setState(() {
                        if (widget.model.age > 1) widget.model.age--;
                      }),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Activity Level
              ActivityLevelWidget(
                selectedActivity: widget.model.activityLevel,
                onActivityChanged: (activity) => setState(() {
                  widget.model.activityLevel = activity;
                }),
              ),

              const SizedBox(height: 30),

              // Calculate Button
              CalculateButtonWidget(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => HealthResultsScreen(model: widget.model),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
