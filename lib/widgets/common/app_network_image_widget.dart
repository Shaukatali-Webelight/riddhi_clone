import 'package:flutter/material.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/main.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppNetworkImageWidget extends StatelessWidget {
  const AppNetworkImageWidget({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
    this.memCacheHeight,
    this.memCacheWidth,
    this.whenImageUrlEmpty,
    this.svgPlaceholder,
    this.blurHash,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final int? memCacheHeight;
  final int? memCacheWidth;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final Widget? whenImageUrlEmpty;
  final Widget? svgPlaceholder;
  final String? blurHash;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: signedCookies,
      builder: (context, value, child) {
        if (imageUrl.isEmpty) {
          return SizedBox(
            height: height,
            width: width,
            child: const Icon(
              Icons.photo,
              size: AppConst.k50,
            ),
          );
        }

        return AppNetworkImage(
          httpHeaders: signedCookies.value,
          url: imageUrl,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          placeholder: (p0, p1) => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          errorWidget: errorWidget ??
              (context, url, error) {
                Sentry.captureException(
                  url,
                );
                return Container(
                  height: height,
                  width: width,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.photo,
                    size: AppConst.k50,
                  ),
                );
              },
          memCacheHeight: memCacheHeight,
          memCacheWidth: memCacheWidth,
        );
      },
    );
  }
}
