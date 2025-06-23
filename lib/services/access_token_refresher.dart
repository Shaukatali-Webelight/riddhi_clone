// Dart imports:
// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/constants/api_endpoints.dart';
import 'package:riddhi_clone/constants/pref_keys.dart';
import 'package:riddhi_clone/features/auth/views/auth_screen.dart';
// Project imports:

class AccessTokenRefresher {
  AccessTokenRefresher._();

  static final instance = AccessTokenRefresher._();

  Future<bool> refresh() async {
    LogHelper.logSuccess('Called AccessTokenRefresher API');
    try {
      final refreshToken = PreferenceHelper.getStringPrefValue(key: PreferenceKeys.refreshToken);

      final request = APIRequest(
        url: APIEndpoints.refreshToken,
        methodType: MethodType.POST,
        isAuthorization: false,
        header: {
          HttpHeaders.authorizationHeader: 'Bearer $refreshToken',
        },
      );

      final response = await APIService().getApiResponse(
        request,
        apiResponse: (data) {
          return RefreshTokenModel.fromJson(
            data as Map<String, dynamic>? ?? {},
          );
        },
      );

      final refreshTokenData = response.data as RefreshTokenModel?;
      if (!response.hasError && response.data != null && refreshTokenData != null) {
        await PreferenceHelper.setStringPrefValue(
          key: PreferenceKeys.accessToken,
          value: refreshTokenData.data?.accessToken ?? '',
        );
        await PreferenceHelper.setStringPrefValue(
          key: PreferenceKeys.refreshToken,
          value: refreshTokenData.data?.refreshToken ?? '',
        );
        return true;
      } else {
        LogHelper.logError('Failed to refresh token $refreshTokenData');
        await _clearAndLogout();
        return false;
      }
    } catch (e) {
      await _clearAndLogout();
      LogHelper.logError('Failed to refresh token $e');
      return false;
    }
  }

  Future<void> _clearAndLogout() async {
    final env = PreferenceHelper.getStringPrefValue(key: PreferenceKeys.environment);
    await PreferenceHelper.clearAll();
    await PreferenceHelper.setStringPrefValue(key: PreferenceKeys.environment, value: env);

    unawaited(
      NavigationHelper.navigatePushRemoveUntil(route: const AuthScreen()),
    );
  }
}

class RefreshTokenModel {
  RefreshTokenModel({this.success, this.code, this.data});
  RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    code = json['code'] as int?;
    data = json['data'] != null ? Data.fromJson(json['data'] as Map<String, dynamic>? ?? {}) : null;
  }
  bool? success;
  int? code;
  Data? data;
}

class Data {
  Data({this.accessToken, this.refreshToken, this.userId, this.userName});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'] as String?;
    refreshToken = json['refresh_token'] as String?;
    userId = json['user_id'] as String?;
    userName = json['user_name'] as String?;
  }
  String? accessToken;
  String? refreshToken;
  String? userId;
  String? userName;
}
