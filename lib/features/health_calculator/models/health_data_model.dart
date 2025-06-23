enum Gender { male, female }

class HealthDataModel {
  HealthDataModel({
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
    this.activityLevel = 'moderate',
  });
  Gender gender;
  int height; // in cm
  int weight; // in kg
  int age;
  String activityLevel;

  double calculateBMI() {
    final heightInMeters = height / 100.0;
    return weight / (heightInMeters * heightInMeters);
  }

  String getBMICategory() {
    final bmi = calculateBMI();
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  double calculateBMR() {
    // Mifflin-St Jeor Equation
    if (gender == Gender.male) {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  double calculateCalories() {
    final bmr = calculateBMR();
    final activityMultipliers = <String, double>{
      'sedentary': 1.2,
      'light': 1.375,
      'moderate': 1.55,
      'active': 1.725,
      'very_active': 1.9,
    };
    return bmr * (activityMultipliers[activityLevel] ?? 1.55);
  }
}
