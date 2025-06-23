import 'dart:io';

import 'package:image_cropper/image_cropper.dart';

class ImageCropperHelper {
  static Future<File?> cropImage({
    required String imagePath,
    ImageCompressFormat? compressFormat,
    List<PlatformUiSettings>? uiSetting,
    CropAspectRatio? aspectRatio,
    int? compressQuality,
    int? maxHeight,
    int? maxWidth,
  }) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      uiSettings: uiSetting,
      compressFormat: compressFormat ?? ImageCompressFormat.jpg,
      compressQuality: compressQuality ?? 90,
      aspectRatio: aspectRatio,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }
}
