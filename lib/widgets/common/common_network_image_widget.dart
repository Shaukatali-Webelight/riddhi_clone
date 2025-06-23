import 'package:flutter/material.dart';
import 'package:master_utility/master_utility.dart';

class CommonNetworkImageWidget extends StatelessWidget {
  const CommonNetworkImageWidget({
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
    return AppNetworkImage(
      url: imageUrl,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      placeholder: placeholder,
      errorWidget: errorWidget,
      memCacheHeight: memCacheHeight,
      memCacheWidth: memCacheWidth,
    );
  }
}
