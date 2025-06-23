// ignore_for_file: avoid_catches_without_on_clauses, document_ignores

import 'package:dartz/dartz.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/constants/api_endpoints.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/type_defs.dart';
import 'package:riddhi_clone/features/auth/models/create_new_password_request_model.dart';
import 'package:riddhi_clone/features/auth/models/login_response_data_model.dart';
import 'package:riddhi_clone/features/auth/models/send_otp_request_model.dart';
import 'package:riddhi_clone/features/auth/models/signed_cookies_response_model.dart';
import 'package:riddhi_clone/features/auth/models/user_login_request_model.dart';
import 'package:riddhi_clone/features/auth/models/verify_otp_request_model.dart';
import 'package:riddhi_clone/features/common/models/failure_model.dart';
import 'package:riddhi_clone/helpers/api_helper.dart';

abstract interface class IAuthRepository {
  FutureEither<void> logout();

  FutureEither<Map<String, String>> getSignedCookies();

  FutureEither<dynamic> login({required LoginRequestModel loginRequestModel});

  FutureEither<dynamic> sendOtp({required SendOtpRequestModel requestModel});

  FutureEither<dynamic> verifyOtp({required VerifyOtpRequestModel requestModel});

  FutureEither<dynamic> createNewPassword({required CreateNewPasswordRequestModel requestModel});
}

class AuthRepository implements IAuthRepository {
  @override
  FutureEither<void> logout() {
    throw UnimplementedError();
  }

  // @override
  // FutureEither<dynamic> userLogin({
  //   required UserLoginRequestModel requestModel,
  // }) async {
  //   try {
  //     final response = await ApiHelper.instance.post(
  //       url: APIEndpoints.login,
  //       params: requestModel.toJson(),
  //       isAuthorization: false,
  //       fromJson: (data) => data,
  //     );

  //     if (response.hasError) {
  //       LogHelper.logError(response.message);
  //       return left(
  //         Failure(message: response.message ?? AppStrings.somethingWentWrong),
  //       );
  //     } else {
  //       return right(response.data);
  //     }
  //   } catch (e) {
  //     LogHelper.logError('userLogin error: $e');
  //     return left(const Failure(message: AppStrings.somethingWentWrong));
  //   }
  // }
  @override
  FutureEither<dynamic> login({
    required LoginRequestModel loginRequestModel,
  }) async {
    try {
      final encrypted = loginRequestModel.toJson().encrypted();
      LogHelper.logSuccess('encrypted:- $encrypted');
      final response = await ApiHelper.instance.post(
        url: APIEndpoints.login,
        isAuthorization: false,
        params: encrypted,
        fromJson: (data) => LoginResponseDataModel.fromJson(
          data as Map<String, dynamic>? ?? {},
        ),
      );

      if (response.hasError || response.data == null) {
        LogHelper.logError(response.message);
        return left(
          Failure(message: response.message ?? AppStrings.signInFail),
        );
      } else {
        final data = response.data as LoginResponseDataModel?;
        if (data != null && data.data != null) {
          return right(data);
        } else {
          return left(
            Failure(message: response.message ?? AppStrings.signInFail),
          );
        }
      }
    } catch (e) {
      return left(const Failure(message: AppStrings.signInFail));
    }
  }

  @override
  FutureEither<dynamic> sendOtp({
    required SendOtpRequestModel requestModel,
  }) async {
    try {
      final response = await ApiHelper.instance.post(
        url: APIEndpoints.sendOtp,
        params: requestModel.toJson(),
        isAuthorization: false,
        fromJson: (data) => data,
      );

      if (response.hasError) {
        LogHelper.logError(response.message);
        return left(
          Failure(message: response.message ?? AppStrings.somethingWentWrong),
        );
      } else {
        return right(response.data);
      }
    } catch (e) {
      LogHelper.logError('sendOtp error: $e');
      return left(const Failure(message: AppStrings.somethingWentWrong));
    }
  }

  @override
  FutureEither<Map<String, String>> getSignedCookies() async {
    try {
      final response = await ApiHelper.instance.get(
        url: APIEndpoints.signedCookies,
        isAuthorization: false,
        fromJson: (data) => SignedCookiesResponseModel.fromJson(
          data as Map<String, dynamic>? ?? {},
        ),
      );

      if (response.hasError || response.data == null) {
        LogHelper.logError(response.message);
        return left(
          Failure(message: response.message ?? AppStrings.somethingWentWrong),
        );
      } else {
        final cookiesData = response.data as SignedCookiesResponseModel?;
        if (cookiesData != null && cookiesData.data != null) {
          final cookies = {
            'Cookie':
                'CloudFront-Key-Pair-Id=${cookiesData.data?.cloudFrontKeyPairId};CloudFront-Policy=${cookiesData.data?.cloudFrontPolicy};CloudFront-Signature=${cookiesData.data?.cloudFrontSignature}',
          };
          return right(cookies);
        } else {
          return left(
            Failure(message: response.message ?? AppStrings.somethingWentWrong),
          );
        }
      }
    } catch (e) {
      return left(const Failure(message: AppStrings.somethingWentWrong));
    }
  }

  @override
  FutureEither<dynamic> verifyOtp({
    required VerifyOtpRequestModel requestModel,
  }) async {
    try {
      LogHelper.logInfo('Verifying OTP...');

      final response = await ApiHelper.instance.post(
        url: APIEndpoints.verifyOtp,
        params: requestModel.toJson(),
        isAuthorization: false,
        fromJson: (data) => data,
      );

      if (response.hasError) {
        LogHelper.logError('Verify OTP failed: ${response.message}');
        return left(
          Failure(message: response.message ?? _getVerifyOtpError()),
        );
      } else {
        LogHelper.logInfo('OTP verified successfully');
        return right(response.data);
      }
    } catch (e) {
      LogHelper.logError('Verify OTP error: $e');
      return left(Failure(message: _getVerifyOtpError()));
    }
  }

  @override
  FutureEither<dynamic> createNewPassword({
    required CreateNewPasswordRequestModel requestModel,
  }) async {
    try {
      LogHelper.logInfo('Creating new password...');

      final response = await ApiHelper.instance.post(
        url: APIEndpoints.createNewPassword,
        params: requestModel.toJson(),
        isAuthorization: false,
        fromJson: (data) => data,
      );

      if (response.hasError) {
        LogHelper.logError('Create new password failed: ${response.message}');
        return left(
          Failure(message: response.message ?? _getCreateNewPasswordError()),
        );
      } else {
        LogHelper.logInfo('New password created successfully');
        return right(response.data);
      }
    } catch (e) {
      LogHelper.logError('Create new password error: $e');
      return left(Failure(message: _getCreateNewPasswordError()));
    }
  }

  String _getVerifyOtpError() {
    return 'Unable to verify OTP. Please check your OTP and try again.';
  }

  String _getCreateNewPasswordError() {
    return 'Unable to create new password. Please try again.';
  }
}
