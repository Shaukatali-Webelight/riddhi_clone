import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/helpers/app_navigation.dart';
import 'package:riddhi_clone/widgets/common/app_network_image_widget.dart';

class InteractiveDialog extends StatelessWidget {
  const InteractiveDialog({
    this.filePath,
    this.networkUrl,
    super.key,
  });
  final String? filePath;
  final String? networkUrl;

  void show() {
    showAdaptiveDialog<void>(
      context: globalContext,
      builder: (context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(AppConst.k10),
      backgroundColor: AppColors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GestureDetector(
        onTap: AppNavigation.back,
        child: InteractiveViewer(
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: (networkUrl ?? '').isNotEmpty
                ? AppNetworkImageWidget(
                    imageUrl: networkUrl ?? '',
                    fit: BoxFit.contain,
                  )
                : (filePath ?? '').isNotEmpty
                    ? Image.file(File(filePath ?? ''))
                    : const Icon(Icons.image),
          ),
        ),
      ),
    );
  }
}
