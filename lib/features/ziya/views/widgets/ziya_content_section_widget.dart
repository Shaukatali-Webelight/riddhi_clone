// Flutter imports:
import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
// Project imports:
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/widgets/loaders/shimmer_container_widget.dart';

class ZiyaContentSectionWidget extends StatelessWidget {
  const ZiyaContentSectionWidget({
    required this.title,
    required this.items,
    super.key,
    this.isLoading = false,
  });
  final String title;
  final List<String> items;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.only(bottom: AppConst.k16),
          child: Text(
            title,
            style: AppStyles.getBoldStyle(
              fontSize: AppConst.k18,
              color: AppColors.white,
            ).copyWith(
              fontFamily: 'Overlock',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // Content
        if (isLoading) _buildShimmerContent() else if (items.isEmpty) _buildEmptyState() else _buildContentList(),
      ],
    );
  }

  Widget _buildShimmerContent() {
    return SizedBox(
      height: AppConst.k180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: AppConst.k160,
            margin: EdgeInsets.only(
              right: index < 2 ? AppConst.k12 : 0,
            ),
            child: const ShimmerContainerWidget(
              height: AppConst.k180,
              width: AppConst.k160,
              borderRadius: AppConst.k12,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: AppConst.k120,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConst.k12),
        border: Border.all(
          color: AppColors.white.withOpacity(0.2),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.hourglass_empty,
              color: AppColors.white.withOpacity(0.6),
              size: AppConst.k32,
            ),
            const SizedBox(height: AppConst.k8),
            Text(
              'No content available',
              style: AppStyles.getMediumStyle(
                fontSize: AppConst.k14,
                color: AppColors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentList() {
    return SizedBox(
      height: AppConst.k180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildContentCard(items[index], index);
        },
      ),
    );
  }

  Widget _buildContentCard(String item, int index) {
    return Container(
      width: AppConst.k160,
      margin: EdgeInsets.only(
        right: index < items.length - 1 ? AppConst.k12 : 0,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppConst.k12),
        border: Border.all(
          color: AppColors.white.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            height: AppConst.k100,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConst.k12),
                topRight: Radius.circular(AppConst.k12),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  _getPlaceholderImage(index),
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(AppConst.k12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item,
                  style: AppStyles.getBoldStyle(
                    fontSize: AppConst.k14,
                    color: AppColors.white,
                  ).copyWith(
                    fontFamily: 'Overlock',
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppConst.k4),
                Text(
                  '${_getDuration(index)} min',
                  style: AppStyles.getMediumStyle(
                    fontSize: AppConst.k12,
                    color: AppColors.white.withOpacity(0.8),
                  ).copyWith(
                    fontFamily: 'Overlock',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getPlaceholderImage(int index) {
    final images = [
      'https://images.unsplash.com/photo-1545205597-3d9d02c29597?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
      'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
      'https://images.unsplash.com/photo-1474224017046-182ece80b263?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
    ];
    return images[index % images.length];
  }

  int _getDuration(int index) {
    final durations = [5, 10, 15, 8, 12, 20];
    return durations[index % durations.length];
  }
}
