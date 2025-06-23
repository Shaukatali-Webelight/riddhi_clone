import 'dart:convert';
import 'dart:io';

import 'package:master_utility/master_utility.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:riddhi_clone/config/env/app_env.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/features/common/models/media_model.dart';
import 'package:riddhi_clone/features/common/models/media_upload_input_model.dart';
import 'package:riddhi_clone/features/common/models/pre_sign_data_model.dart';
import 'package:riddhi_clone/main.dart';
import 'package:riddhi_clone/resources/app_utils.dart';
import 'package:riddhi_clone/resources/toast_helper.dart';
import 'package:riddhi_clone/widgets/loaders/app_loader.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ApiHelper {
  ApiHelper._() {
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
  static final instance = ApiHelper._();
  final _dio = Dio();

  final _apiService = APIService();

  Future<APIResponse<dynamic>> _getResponse(
    APIRequest request,
    bool isAuthorization, {
    dynamic Function(dynamic data)? apiResponse,
  }) async {
    if (isAuthorization) await AppUtils.checkJWT();
    final response = await _apiService.getApiResponse(
      request,
      apiResponse: apiResponse,
    );
    // if (response.statusCode == StatusCode.FORBIDDEN.value) {
    //   if (!isUserOnSelfieUploadScreen) {
    //     await AppNavigation.pushRemoveUntil(
    //       page: SelfieUploadScreen(
    //         onSuccess: () => AppNavigation.pushRemoveUntil(
    //           page: const BottomNavScreen(),
    //         ),
    //       ),
    //     );
    //   }
    // }
    return response;
  }

  Future<APIResponse<dynamic>> get({
    required String url,
    required dynamic Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool isAuthorization = true,
    CancelToken? cancelToken,
  }) async {
    final request = APIRequest(
      url: url,
      methodType: MethodType.GET,
      header: header,
      params: params,
      queryParams: queryParams,
      isAuthorization: isAuthorization,
      cancelToken: cancelToken,
    );

    final result = await _getResponse(
      request,
      isAuthorization,
      apiResponse: (data) {
        return fromJson(data as Map<String, dynamic>? ?? {});
      },
    );

    if ((result.statusCode ?? 0) >= StatusCode.INTERNAL_SERVER_ERROR.value) {
      await Sentry.captureException(
        'GET api error:- Path:- $url StatusCode:- ${result.statusCode} Message:- ${result.message} Data:- ${result.data}',
        stackTrace: StackTrace.current,
      );
    }

    return result;
  }

  Future<APIResponse<dynamic>> post({
    required String url,
    required dynamic Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool isAuthorization = true,
    CancelToken? cancelToken,
    bool needToNavigate = true,
  }) async {
    final request = APIRequest(
      url: url,
      methodType: MethodType.POST,
      header: header,
      params: params,
      queryParams: queryParams,
      isAuthorization: isAuthorization,
      cancelToken: cancelToken,
    );

    final result = await _getResponse(
      request,
      isAuthorization,
      apiResponse: (data) {
        return fromJson(data as Map<String, dynamic>? ?? {});
      },
    );
    if ((result.statusCode ?? 0) >= StatusCode.INTERNAL_SERVER_ERROR.value) {
      await Sentry.captureException(
        'POST api error:- Path:- $url StatusCode:- ${result.statusCode} Message:- ${result.message} Data:- ${result.data}',
        stackTrace: StackTrace.current,
      );
    }

    return result;
  }

  Future<APIResponse<dynamic>> patch({
    required String url,
    required dynamic Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool isAuthorization = true,
    CancelToken? cancelToken,
  }) async {
    final request = APIRequest(
      url: url,
      methodType: MethodType.PATCH,
      header: header,
      params: params,
      queryParams: queryParams,
      isAuthorization: isAuthorization,
      cancelToken: cancelToken,
    );

    final result = await _getResponse(
      request,
      isAuthorization,
      apiResponse: (data) {
        return fromJson(data as Map<String, dynamic>? ?? {});
      },
    );

    if ((result.statusCode ?? 0) >= StatusCode.INTERNAL_SERVER_ERROR.value) {
      await Sentry.captureException(
        'PATCH api error:- Path:- $url StatusCode:- ${result.statusCode} Message:- ${result.message} Data:- ${result.data}',
        stackTrace: StackTrace.current,
      );
    }

    return result;
  }

  Future<APIResponse<dynamic>> put({
    required String url,
    required dynamic Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool isAuthorization = true,
    CancelToken? cancelToken,
  }) async {
    final request = APIRequest(
      url: url,
      methodType: MethodType.PUT,
      header: header,
      params: params,
      queryParams: queryParams,
      isAuthorization: isAuthorization,
      cancelToken: cancelToken,
    );

    final result = await _getResponse(
      request,
      isAuthorization,
      apiResponse: (data) {
        return fromJson(data as Map<String, dynamic>? ?? {});
      },
    );

    if ((result.statusCode ?? 0) >= StatusCode.INTERNAL_SERVER_ERROR.value) {
      await Sentry.captureException(
        'PUT api error:- Path:- $url StatusCode:- ${result.statusCode} Message:- ${result.message} Data:- ${result.data}',
        stackTrace: StackTrace.current,
      );
    }

    return result;
  }

  Future<APIResponse<dynamic>> delete({
    required String url,
    required dynamic Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    bool isAuthorization = true,
    CancelToken? cancelToken,
  }) async {
    final request = APIRequest(
      url: url,
      methodType: MethodType.DELETE,
      header: header,
      params: params,
      queryParams: queryParams,
      isAuthorization: isAuthorization,
      cancelToken: cancelToken,
    );

    final result = await _getResponse(
      request,
      isAuthorization,
      apiResponse: (data) {
        return fromJson(data as Map<String, dynamic>? ?? {});
      },
    );

    if ((result.statusCode ?? 0) >= StatusCode.INTERNAL_SERVER_ERROR.value) {
      await Sentry.captureException(
        'DELETE api error:- Path:- $url StatusCode:- ${result.statusCode} Message:- ${result.message} Data:- ${result.data}',
        stackTrace: StackTrace.current,
      );
    }

    return result;
  }

  Future<Media?> fileUpload({
    required String fileName,
    required File? filePath,
    String? mediaType,
    String? mediaId,
    CancelToken? uploadGetReqCancelToken,
    CancelToken? uploadPostReqCancelToken,
  }) async {
    await AppUtils.checkJWT();
    if ((filePath?.path ?? '').isEmpty) {
      return null;
    }

    final preSignedUrl = AppEnv.presignedUrl;
    LogHelper.logWarning('Files Path:- ${filePath?.path}');

    final accessToken = AppUtils.getAccessToken;
    final fileType = filePath?.path.split('.').last ?? '';
    LogHelper.logWarning('FileName:- $fileName');

    final mediaUploadInputModel = MediaUploadInputModel(
      filename: fileName,
      //!TODO: need to check for document upload file type with BE
      fileType: AppUtils.checkFileType(fileType),
      // token: accessToken,
      accessControl: 'private',
    );
    LogHelper.logWarning(
      'mediaUploadObject:- ${mediaUploadInputModel.toJson()}',
    );

    try {
      //* GET API Call on Presigned URL
      final queryParameters = mediaUploadInputModel.toJson();
      final response = await _dio.get<dynamic>(
        preSignedUrl,
        queryParameters: mediaUploadInputModel.toJson(),
        cancelToken: uploadGetReqCancelToken,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            'x-amz-acl': 'private',
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final curl =
          "curl -X GET '$preSignedUrl${queryParameters.isNotEmpty ? '?${queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&')}' : ''}' -H 'Authorization: Bearer $accessToken'";
      LogHelper.logInfo('cURL Command: $curl');
      LogHelper.logInfo('StatusCode:- ${response.statusCode} ${response.statusMessage}');

      if (response.statusCode == StatusCode.OK.value) {
        LogHelper.logSuccess('Response:- ${jsonEncode(response.data)}');
        final preSignData = PreSignDataModel.fromJson(response.data as Map<String, dynamic>);

        //* POST API Call on url
        final url = preSignData.data?.signedRequest?.url ?? '';
        LogHelper.logSuccess('URL:- $url');
        final fields = preSignData.data?.signedRequest?.fields;
        final formData = FormData.fromMap(fields?.toJson() ?? {});
        formData.files.add(MapEntry('file', MultipartFile.fromFileSync(filePath?.path ?? '')));
        final postResponse = await _dio.post<dynamic>(
          url,
          data: formData,
          cancelToken: uploadPostReqCancelToken,
        );
        if (postResponse.statusCode == StatusCode.NO_CONTENT.value) {
          LogHelper.logSuccess('File Uploaded Successfully');
          return Media(
            key: fileName,
            type: mediaType,
            localUrl: filePath?.path,
            id: mediaId,
          );
        } else {
          AppToastHelper.showError(postResponse.statusMessage ?? AppStrings.somethingWentWrong);
          await Sentry.captureException(
            'S3 POST API File upload Error:- StatusCode:- ${postResponse.statusCode} Message:- ${postResponse.statusMessage}',
            stackTrace: StackTrace.current,
          );
        }
      } else if ((response.statusCode ?? 0) >= StatusCode.INTERNAL_SERVER_ERROR.value) {
        AppToastHelper.showError(response.statusMessage ?? AppStrings.somethingWentWrong);
        await Sentry.captureException(
          'S3 GET API File upload Error:- StatusCode:- ${response.statusCode} Message:- ${response.statusMessage}',
          stackTrace: StackTrace.current,
        );
      } else {
        AppToastHelper.showError(response.statusMessage ?? AppStrings.somethingWentWrong);
      }
    } on DioException catch (error) {
      AppToastHelper.showError(error.message ?? AppStrings.somethingWentWrong);
      await Sentry.captureException(
        'S3 GET API File upload Exception:- $error',
        stackTrace: StackTrace.current,
      );
      LogHelper.logError('signedRequestException:- $error');

      return null;
    }
    return null;
  }

  Future<String?> downloadPdf(String url) async {
    const AppLoader(
      title: AppStrings.loading,
    ).show();
    final tempDir = await path.getTemporaryDirectory();
    final fileName = url.split('/').last;
    final tempFile = File('${tempDir.path}/$fileName');
    final result = await _dio.downloadUri(
      Uri.parse(url),
      tempFile.path,
      options: Options(headers: signedCookies.value),
    );
    if (result.statusCode == StatusCode.OK.value) {
      AppLoader.hide();
      return tempFile.path;
    }
    AppLoader.hide();
    return null;
  }
}
