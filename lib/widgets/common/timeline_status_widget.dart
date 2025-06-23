import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_enums.dart';
import 'package:riddhi_clone/constants/app_semantic_labels.dart';
import 'package:riddhi_clone/widgets/common/timeline_contents_widget.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TimelineStatusWidget extends StatefulWidget {
  const TimelineStatusWidget({
    super.key,
    this.steps,
    this.isScrollable = true,
    this.physics,
    this.padding,
  });

  final bool? isScrollable;
  final List<TimelineStep>? steps;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  @override
  State<TimelineStatusWidget> createState() => _TimelineStatusWidgetState();
}

class _TimelineStatusWidgetState extends State<TimelineStatusWidget> {
  Color getStatusColor(TimelineStatus status) {
    switch (status) {
      case TimelineStatus.done:
        return AppColors.primary;
      case TimelineStatus.inProgress:
        return AppColors.inProgressChip;
      case TimelineStatus.failed:
        return AppColors.red;
      case TimelineStatus.todo:
        return AppColors.divider;
      case TimelineStatus.await:
        return AppColors.inProgress;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      padding: EdgeInsets.zero,
      physics: widget.physics ?? const ClampingScrollPhysics(),
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: const ConnectorThemeData(
          thickness: 2,
        ),
      ),
      shrinkWrap: !(widget.isScrollable ?? true),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: widget.steps?.length ?? 0,
        indicatorBuilder: (context, index) {
          final step = widget.steps![index];
          return DotIndicator(
            color: getStatusColor(step.status),
            position: 0.02,
            child: const Icon(
              Icons.radio_button_unchecked,
              color: AppColors.transparent,
              size: AppConst.k12,
              semanticLabel: AppSemanticLabels.radioButtonUnchecked,
            ),
          );
        },
        connectorBuilder: (_, index, __) {
          final currentStep = widget.steps![index];
          final previousStep = index > 0 ? widget.steps![index - 1] : null;
          Color color;

          if (currentStep.status == TimelineStatus.failed) {
            color = AppColors.red;
          } else if (currentStep.status == TimelineStatus.inProgress) {
            color = AppColors.gray400;
          } else if (currentStep.status == TimelineStatus.done) {
            color = (index + 1 < widget.steps!.length && widget.steps![index + 1].status == TimelineStatus.failed)
                ? AppColors.red
                : AppColors.green;
          } else if (currentStep.status == TimelineStatus.todo && previousStep?.status == TimelineStatus.done) {
            color = AppColors.green;
          } else {
            color = AppColors.gray400;
          }

          return SolidLineConnector(color: color);
        },
        contentsBuilder: (context, index) {
          final step = widget.steps![index];
          return Padding(
            padding: widget.padding ?? AppConst.horizontalPadding.copyWith(bottom: AppConst.k16),
            child: TimelineContentsWidget(
              title: step.title,
              description: step.description ?? '',
              date: step.date,
              status: step.status,
              rejected: step.rejected,
              onTap: step.onTap,
            ),
          );
        },
      ),
    );
  }
}

//!TODO will remove later
class TimelineStep {
  TimelineStep({
    required this.title,
    required this.status,
    this.description,
    this.date,
    this.rejected,
    this.onTap,
  });
  final String title;
  final String? description;
  final TimelineStatus status;
  final String? date;
  final bool? rejected;
  final void Function()? onTap;
}
