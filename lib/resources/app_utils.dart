// Dart imports:

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:master_utility/master_utility.dart';
import 'package:open_file/open_file.dart' as open_file;
import 'package:path_provider/path_provider.dart' as path;
import 'package:permission_handler/permission_handler.dart' as handler;
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_enums.dart';
import 'package:riddhi_clone/constants/app_extensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/pref_keys.dart';
import 'package:riddhi_clone/constants/type_defs.dart';
import 'package:riddhi_clone/features/common/models/failure_model.dart';
import 'package:riddhi_clone/helpers/api_helper.dart';
import 'package:riddhi_clone/helpers/device_info_helper.dart';
import 'package:riddhi_clone/main.dart';
import 'package:riddhi_clone/resources/image_cropper_helper.dart';
import 'package:riddhi_clone/resources/toast_helper.dart';
import 'package:riddhi_clone/services/access_token_refresher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class AppUtils {
  AppUtils._();

  static String get roleType {
    final roleType = PreferenceHelper.getStringPrefValue(key: PreferenceKeys.userType);
    return roleType;
  }

  static int get zoneCount {
    final zoneCount = PreferenceHelper.getIntPrefValue(key: PreferenceKeys.zonesCount);
    return zoneCount ?? 0;
  }

  static int get subRegionCount {
    final subRegionCount = PreferenceHelper.getIntPrefValue(key: PreferenceKeys.subRegionsCount);
    return subRegionCount ?? 0;
  }

  static int get territoryCount {
    final territoryCount = PreferenceHelper.getIntPrefValue(key: PreferenceKeys.territoriesCount);
    return territoryCount ?? 0;
  }

  static bool _isRequestingPermission = false;
  static Future<void> mediaPermission({
    void Function()? onGrantedCallback,
    bool isCamera = false,
  }) async {
    if (_isRequestingPermission) {
      return;
    }
    handler.PermissionStatus? permissionStatus;
    _isRequestingPermission = true;
    try {
      if (isCamera) {
        permissionStatus = await handler.Permission.camera
            .onDeniedCallback(() async {
              LogHelper.logWarning('onDeniedCallback');
            })
            .onGrantedCallback(
              onGrantedCallback,
            )
            .onPermanentlyDeniedCallback(() async {
              LogHelper.logWarning('onPermanentlyDeniedCallback');
              await handler.openAppSettings();
            })
            .onProvisionalCallback(() {
              LogHelper.logWarning('onProvisionalCallback');
            })
            .onRestrictedCallback(() {
              LogHelper.logWarning('onRestrictedCallback');
            })
            .request();

        LogHelper.logSuccess('permissionStatus:- $permissionStatus');
      } else {
        if (Platform.isAndroid) {
          final version = DeviceInfoHelper.instance.androidVersion;

          if (version >= DeviceVersion.android13.value) {
            permissionStatus = await handler.Permission.photos
                .onDeniedCallback(() {
                  LogHelper.logWarning('onDeniedCallback');
                })
                .onGrantedCallback(onGrantedCallback)
                .onPermanentlyDeniedCallback(() {
                  LogHelper.logWarning('onPermanentlyDeniedCallback');
                  handler.openAppSettings();
                })
                .onProvisionalCallback(() {
                  LogHelper.logWarning('onProvisionalCallback');
                })
                .onRestrictedCallback(() {
                  LogHelper.logWarning('onRestrictedCallback');
                })
                .request();
          } else {
            permissionStatus = await handler.Permission.storage
                .onDeniedCallback(() {
                  LogHelper.logWarning('onDeniedCallback');
                })
                .onGrantedCallback(onGrantedCallback)
                .onPermanentlyDeniedCallback(() async {
                  LogHelper.logWarning('onPermanentlyDeniedCallback');
                  await handler.openAppSettings();
                })
                .onProvisionalCallback(() {
                  LogHelper.logWarning('onProvisionalCallback');
                })
                .onRestrictedCallback(() {
                  LogHelper.logWarning('onRestrictedCallback');
                })
                .request();
          }
        } else {
          permissionStatus = await handler.Permission.photos
              .onDeniedCallback(() {
                LogHelper.logWarning('onDeniedCallback');
              })
              .onLimitedCallback(() {
                onGrantedCallback?.call();
              })
              .onGrantedCallback(onGrantedCallback)
              .onPermanentlyDeniedCallback(() async {
                LogHelper.logWarning('onPermanentlyDeniedCallback');
                await handler.openAppSettings();
              })
              .onProvisionalCallback(() {
                LogHelper.logWarning('onProvisionalCallback');
              })
              .onRestrictedCallback(() {
                LogHelper.logWarning('onRestrictedCallback');
              })
              .request();
        }
      }
    } on PlatformException catch (error) {
      LogHelper.logError('MediaPermission PlatformException:- $error');
    } finally {
      _isRequestingPermission = false;
    }
    LogHelper.logSuccess('permissionStatus:- $permissionStatus');
  }

  static String get getAccessToken {
    final accessToken = PreferenceHelper.getStringPrefValue(key: PreferenceKeys.accessToken);
    return accessToken;
  }

  static Future<bool> checkJWT() async {
    if (AppUtils.getAccessToken.isNotEmpty) {
      LogHelper.logSuccess(
        'checkJWT:- getAccessToken:- ${AppUtils.getAccessToken}',
      );
      final isTokenExpired = await JWTHelper.handleJWT(
        onSuccess: () {},
        token: AppUtils.getAccessToken,
      );

      if (isTokenExpired) {
        final context = NavigationService.context;
        if (context.mounted) {
          //*when token refreshed Successfully then it will return true else return null
          await AccessTokenRefresher.instance.refresh();
        }
      }
      return isTokenExpired;
    }
    return true;
  }

  static Color getOrderStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.completed:
        return AppColors.primary;
      case OrderStatus.inProgress:
        return AppColors.inProgressChip;
      case OrderStatus.rejected:
        return AppColors.red;
      case OrderStatus.approved:
        return AppColors.green;
      case OrderStatus.approvalAwait:
        return AppColors.inProgress;
      case OrderStatus.pending:
        return AppColors.inProgressChip;
      case OrderStatus.cancel:
        return AppColors.red;
      case OrderStatus.dispatch:
        return AppColors.primary;
      case OrderStatus.ordered:
        return AppColors.inProgressChip;
      case OrderStatus.unknown:
        return AppColors.assertYellow;
    }
  }

  static InputBorder textFieldBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.divider,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(AppConst.k8),
    );
  }

  static InputBorder quantityFieldBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppConst.k8),
        bottomLeft: Radius.circular(AppConst.k8),
      ),
      borderSide: BorderSide(color: AppColors.divider),
    );
  }

  static String displayText(String? text, {String defaultValue = 'N/A'}) {
    if (text == null || text.trim().isEmpty) return defaultValue;
    return text;
  }

  static Color getTimeLineStatusColor(TimelineStatus status) {
    switch (status) {
      case TimelineStatus.done:
        return AppColors.primaryText;
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

  ///* only jpg, png, heif, jpeg file extension allowed
  static bool isValidImageFileExtension(String extension) {
    final formatExtension = extension.toLowerCase();
    final isJpg = FileExtension.JPG.value == formatExtension;
    final isPng = FileExtension.PNG.value == formatExtension;
    final isHeif = FileExtension.HEIF.value == formatExtension;
    final isJpeg = FileExtension.JPEG.value == formatExtension;
    return isJpg || isPng || isHeif || isJpeg;
  }

  ///* only jpg, png, heif, jpeg file extension allowed
  static bool isValidDocumentFileExtension(String extension) {
    return isDocument(extension);
  }

  static bool isLessThan10Mb(int size) {
    if (size == 0) return true;
    final sizeInMb = ((size / 1024.0) / 1024.0).floorToDouble();
    LogHelper.logWarning('ImageLessThan5Mb:- $sizeInMb');
    return sizeInMb <= 10.0;
  }

  static Future<File?> getCopedImage({
    required String path,
  }) async {
    if (path.isEmpty) {
      return null;
    }

    final copedImage = await ImageCropperHelper.cropImage(
      aspectRatio: const CropAspectRatio(
        ratioX: AppConst.k1,
        ratioY: AppConst.k1,
      ),
      imagePath: path,
      uiSetting: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: AppColors.white,
          statusBarColor: AppColors.primary,
          backgroundColor: AppColors.black,
          activeControlsWidgetColor: AppColors.red,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Photo',
          aspectRatioLockEnabled: true,
        ),
      ],
    );
    return copedImage;
  }

  static Future<Uint8List?> compressImage(String filePath, {int quality = 95}) async {
    try {
      final compressedData = await FlutterImageCompress.compressWithFile(
        filePath,
        quality: quality,
      );
      return compressedData;
    } catch (e) {
      LogHelper.logError('Image compression failed: $e');
      return null;
    }
  }

  static Future<bool> handleLocationPermission() async {
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AppToastHelper.showError('Location permission denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      AppToastHelper.showError(
        'Location permission permanently denied. Enable it in settings.',
      );
      return false;
    }

    return true; // Permission granted
  }

  static Color sdoOrderStatusColor(String? status) {
    if (status == null || status.isEmpty) {
      return AppColors.transparent;
    }

    if (status == AppStrings.approved.toUpperCase()) {
      return AppColors.green;
    } else if (status == AppStrings.rejected.toUpperCase()) {
      return AppColors.red;
    } else if (status == AppStrings.pending.toUpperCase()) {
      return AppColors.inProgressChip;
    } else if (status == AppStrings.pendingAtHo) {
      return AppColors.inProgressChip;
    }
    return AppColors.transparent;
  }

  static Color sdoApprovalStatusColor(String? status) {
    if ((status ?? '').isEmpty) {
      return AppColors.transparent;
    }

    final matchedStatus = SDOApprovalStatus.values
        .where(
          (e) => e.value == status,
        )
        .firstOrNull;

    switch (matchedStatus) {
      case SDOApprovalStatus.all:
        return AppColors.transparent;
      case SDOApprovalStatus.pending:
      case SDOApprovalStatus.pending_at_ho:
        return AppColors.inProgressChip;
      case SDOApprovalStatus.rejected:
      case SDOApprovalStatus.rejected_by_ho:
        return AppColors.red;
      case SDOApprovalStatus.approved:
      case SDOApprovalStatus.approved_by_ho:
        return AppColors.green;
      case null:
        return AppColors.transparent;
    }
  }

  static bool isImage(String value) =>
      value == FileExtension.JPEG.value ||
      value == FileExtension.PNG.value ||
      value == FileExtension.JPG.value ||
      value == FileExtension.HEIF.value;
  static bool isVideo(String value) => value == FileExtension.MP4.value || value == FileExtension.MOV.value;

  static bool isAudio(String value) =>
      value == FileExtension.WAV.value ||
      value == FileExtension.FLAC.value ||
      value == FileExtension.OGG.value ||
      value == FileExtension.MP3.value;

  static bool isDocument(String value) {
    final formatExtension = value.toLowerCase();
    final isPdf = FileExtension.PDF.value == formatExtension;
    final isDoc = FileExtension.DOC.value == formatExtension;
    final isDocx = FileExtension.DOCX.value == formatExtension;
    final isXls = FileExtension.XLS.value == formatExtension;
    final isXlsx = FileExtension.XLSX.value == formatExtension;
    final isPpt = FileExtension.PPT.value == formatExtension;
    final isPptx = FileExtension.PPTX.value == formatExtension;
    return isPdf || isDoc || isDocx || isXls || isXlsx || isPpt || isPptx;
  }

  static String checkFileType(String value) {
    final extension = FileExtension.values.where((e) => e.value.toLowerCase() == value.toLowerCase()).toList();
    if (extension.isEmpty) return '';
    switch (extension.first) {
      case FileExtension.JPEG:
      case FileExtension.PNG:
      case FileExtension.JPG:
      case FileExtension.HEIF:
        return '${S3Filetype.image.name}/$value';
      case FileExtension.PDF:
      case FileExtension.DOC:
      case FileExtension.DOCX:
      case FileExtension.XLS:
      case FileExtension.XLSX:
      case FileExtension.PPT:
      case FileExtension.PPTX:
        return '${S3Filetype.application.name}/$value';
      case FileExtension.MP4:
      case FileExtension.MOV:
        return '${S3Filetype.video.name}/$value';
      // ignore: no_default_cases
      default:
        return '';
    }
  }

  static String fileName({required File filePath, String? userId}) {
    final currentUserId = userId ?? PreferenceHelper.getStringPrefValue(key: PreferenceKeys.userId);
    final uuid = const Uuid().v1();
    final fileType = filePath.path.split('.').last;
    final folderName = fileType.getFileTypeFolderName();
    final fileName = '$folderName/$currentUserId/$uuid.$fileType';
    LogHelper.logSuccess('fileName:- $fileName');
    return fileName;
  }

  static Future<void> openDocumentFile({String? filePath, String? documentUrl}) async {
    final isNetworkUrl = documentUrl?.contains('http') ?? false;
    if (isNetworkUrl) {
      final result = await ApiHelper.instance.downloadPdf(documentUrl ?? '');
      final extension = documentUrl?.split('.').last;
      await open_file.OpenFile.open(result, type: getType(extension));
    } else {
      final extension = filePath?.split('.').last;
      await open_file.OpenFile.open(filePath, type: getType(extension));
    }
  }

  static Future<void> openPdfFromAssets() async {
    const assetPath = AppStrings.termsAndConditionsUrl;
    const fileName = 'terms_&_condition.pdf';
    try {
      // Load PDF from assets
      final byteData = await rootBundle.load(assetPath);

      // Get temp directory
      final tempDir = await path.getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$fileName');

      // Write the file
      await tempFile.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

      // Open the file
      await open_file.OpenFile.open(tempFile.path);
    } catch (e) {
      LogHelper.logError('openPdfFromAssets Error:- $e');
    }
  }

  static Future<void> launchUrlForDocument(Uri url) async {
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          mode: LaunchMode.inAppWebView,
          webViewConfiguration: WebViewConfiguration(headers: signedCookies.value),
          url,
        );
      }
    } catch (e) {
      LogHelper.logError(e.toString());
    }
  }

  static Future<void> launchURL(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
        );
      }
    } catch (e) {
      LogHelper.logError(e, stackTrace: StackTrace.current);
    }
  }

  static Future<void> checkKeyboardVisibility(ScrollController? controller) async {
    final hasClients = controller?.hasClients ?? false;
    if (!hasClients) {
      return;
    }
    await Future.delayed(
      Durations.long1,
      () async {
        final isKeyboardOpen = AppConst.viewInsets.bottom != 0;
        LogHelper.logSuccess('Keyboard:- $isKeyboardOpen');
        if (!isKeyboardOpen && !hasClients) {
          return;
        }
        final maxScrollExtent = controller?.position.maxScrollExtent ?? AppConst.k200;
        await controller?.animateTo(
          maxScrollExtent,
          duration: Durations.long1,
          curve: Curves.easeInOut,
        );
      },
    );
  }

  static FutureEither<T> handleApiResponse<T>(
    APIResponse<dynamic> response,
    T Function(dynamic) mapper,
  ) async {
    if (response.hasError || response.data == null) {
      LogHelper.logError(response.message);
      return left(
        Failure(
          message: response.message ?? AppStrings.somethingWentWrong,
          statusCode: response.statusCode,
        ),
      );
    }

    try {
      return right(mapper(response.data));
    } catch (e) {
      LogHelper.logError('Failed to map response data: $e');
      return left(const Failure(message: AppStrings.somethingWentWrong));
    }
  }
}

String? getType(String? extension) {
  if ((extension ?? '').isEmpty) {
    return null;
  }
  final type = extension?.toLowerCase();

  final androidTypeSupported = {
    FileExtension.PDF.value: 'application/pdf',
    FileExtension.DOC.value: 'application/msword',
    FileExtension.DOCX.value: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    FileExtension.XLS.value: 'application/vnd.ms-excel',
    FileExtension.XLSX.value: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    FileExtension.PPT.value: 'application/vnd.ms-powerpoint',
    FileExtension.PPTX.value: 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
  };

  final iosTypeSupported = {
    FileExtension.PDF.value: 'com.adobe.pdf',
    FileExtension.DOC.value: 'com.microsoft.word.doc',
    FileExtension.DOCX.value: 'com.microsoft.word.doc',
    FileExtension.XLS.value: 'com.microsoft.excel.xls',
    FileExtension.XLSX.value: 'com.microsoft.excel.xls',
    FileExtension.PPT.value: 'com.microsoft.powerpoint.​ppt',
    FileExtension.PPTX.value: 'com.microsoft.powerpoint.​ppt',
  };
  final typeSupported = Platform.isIOS ? iosTypeSupported : androidTypeSupported;
  final value = typeSupported.containsKey(type) ? typeSupported[type] : null;
  return value;
}
