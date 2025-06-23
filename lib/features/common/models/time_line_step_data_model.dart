import 'package:riddhi_clone/constants/app_enums.dart';

class TimelineStepDataModel {
  TimelineStepDataModel({
    required this.title,
    required this.description,
    required this.status,
    this.date,
    this.showIcon = false,
  });
  final String title;
  final String description;
  final TimelineStatus status;
  final String? date;
  final bool showIcon;
}
