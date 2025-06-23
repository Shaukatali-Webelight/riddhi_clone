import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:master_utility/master_utility.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riddhi_clone/config/env/encryption_key.dart';
import 'package:riddhi_clone/config/flavours/app.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/pref_keys.dart';
import 'package:riddhi_clone/features/auth/controllers/auth_state.dart';
import 'package:riddhi_clone/features/auth/models/create_new_password_request_model.dart';
import 'package:riddhi_clone/features/auth/models/login_response_data_model.dart';
import 'package:riddhi_clone/features/auth/models/send_otp_request_model.dart';
import 'package:riddhi_clone/features/auth/models/user_login_request_model.dart';
import 'package:riddhi_clone/features/auth/models/verify_otp_request_model.dart';
import 'package:riddhi_clone/features/auth/repository/auth_repository.dart';
import 'package:riddhi_clone/features/auth/views/create_new_password_screen.dart';
import 'package:riddhi_clone/features/auth/views/verify_otp_screen.dart';
import 'package:riddhi_clone/features/bottom_nav/bottom_nav_screen.dart';
import 'package:riddhi_clone/features/common/controllers/master_data.dart';
import 'package:riddhi_clone/features/common/repository/master_api_repo.dart';
import 'package:riddhi_clone/features/ziya/views/ziya_main_screen.dart';
import 'package:riddhi_clone/helpers/app_navigation.dart';
import 'package:riddhi_clone/main.dart';
import 'package:riddhi_clone/resources/toast_helper.dart';
import 'package:riddhi_clone/services/notification/firebase_notification_service.dart';

final authStateNotifierProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(
    authRepository: ref.read(_authRepository),
    mastersApiRepo: ref.read(_mastersApiRepo),
  ),
);

final _authRepository = Provider((ref) => AuthRepository());
final _mastersApiRepo = Provider((ref) => MasterApiRepo());

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier({
    required this.authRepository,
    required this.mastersApiRepo,
  }) : super(AuthState.initial());

  final IAuthRepository authRepository;
  final IMastersApiRepo mastersApiRepo;

  // User Login method
  // Future<void> userLogin({
  //   required SendOtpRequestModel requestModel,
  // }) async {
  //   try {
  //     LogHelper.logInfo('Starting user login...');

  //     final result = await authRepository.sendOtp(
  //       requestModel: requestModel,
  //     );

  //     result.fold(
  //       (error) {
  //         LogHelper.logError('Login failed: ${error.message}');
  //         AppToastHelper.showError(error.message);
  //       },
  //       (response) {
  //         LogHelper.logInfo('Login successful');
  //         // Handle successful login response here
  //         // You can process the response data as needed
  //       },
  //     );
  //   } catch (e) {
  //     LogHelper.logError('Login error: $e');
  //     AppToastHelper.showError(AppStrings.somethingWentWrong);
  //   }
  // }

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    final fcmToken = await FirebaseMessagingService.instance.getFcmToken();
    final appVersion = await getAppInfo();
    final deviceInfo = await getDeviceInfo();
    final response = await authRepository.login(
      loginRequestModel: LoginRequestModel(
        phone: phone,
        password: password,
        apkVersion: appVersion,
        mobileDevice: deviceInfo,
        fcmToken: fcmToken,
      ),
    );
    state = state.copyWith(isLoading: false);

    response.fold(
      AppErrorHandler.showError,
      (data) async {
        final loginData = data as LoginResponseDataModel;

        // final isSdoMdoUser = data.userType == UserType.SDO_MDO.value;

        // final hoSelfieVerified =
        //     data.hoSelfieVerified == null || data.hoSelfieVerified == SDOApprovalReason.rejected.value;
        // final isCreatedUserViaAdmin = isSdoMdoUser && data.hoSelfieVerified == null && data.isSelfieUploaded == null;

        // // final selfieNotVerified = !(data.isSelfieUploaded ?? false) && isSdoMdoUser && hoSelfieVerified;
        await _setUserPreferences(
          loginData: loginData,
          // storeLoginFlag: isCreatedUserViaAdmin || !selfieNotVerified,
        );

        // if (isCreatedUserViaAdmin) {
        //   //* Admin created user navigate on home page
        //   unawaited(getMastersData());
        //   await AppNavigation.pushRemoveUntil(
        //     page: const BottomNavScreen(),
        //   );
        // }

        // else if (selfieNotVerified) {
        //   //* selfie is not uploaded then navigate to on selfie upload screen
        //   await AppNavigation.pushRemoveUntil(
        //     page: SelfieUploadScreen(
        //       onSuccess: () async {
        //         await PreferenceHelper.setBoolPrefValue(key: PreferenceKeys.isLogin, value: true);
        //         unawaited(getMastersData());
        //         await AppNavigation.pushRemoveUntil(
        //           page: const BottomNavScreen(),
        //         );
        //       },
        //     ),
        //   );
        // }

        unawaited(getMastersData());
        await AppNavigation.pushRemoveUntil(
          page: const BottomNavScreen(),
        );

        state = state.copyWith(isLoginSubmitted: false);
      },
    );
  }

  // Send OTP method
  Future<void> sendOtp({
    required SendOtpRequestModel requestModel,
  }) async {
    try {
      LogHelper.logInfo('Sending OTP to phone: ${requestModel.phone}');

      final result = await authRepository.sendOtp(
        requestModel: requestModel,
      );

      result.fold(
        (error) {
          LogHelper.logError('Send OTP failed: ${error.message}');
          AppToastHelper.showError(error.message);
        },
        (response) {
          LogHelper.logInfo('OTP sent successfully');
          AppNavigation.push(
            page: VerifyOtpScreen(
              phoneNo: requestModel.phone,
            ),
          );
        },
      );
    } catch (e) {
      LogHelper.logError('Send OTP error: $e');
      AppToastHelper.showError(AppStrings.somethingWentWrong);
    }
  }

  // Verify OTP method
  Future<void> verifyOtp({
    required VerifyOtpRequestModel requestModel,
  }) async {
    try {
      state = state.copyWith(isVerifyOtpLoading: true);
      LogHelper.logInfo('Verifying OTP...');

      final result = await authRepository.verifyOtp(
        requestModel: requestModel,
      );

      state = state.copyWith(isVerifyOtpLoading: false);

      result.fold(
        (error) {
          LogHelper.logError('Verify OTP failed: ${error.message}');
          AppToastHelper.showError(error.message);
        },
        (response) {
          LogHelper.logInfo('OTP verified successfully');
          AppToastHelper.showSuccess('OTP verified successfully');
          AppNavigation.pushReplacement(
            page: const CreateNewPasswordScreen(
              phone: '',
              otp: '',
            ),
          );
        },
      );
    } on Exception catch (e) {
      state = state.copyWith(isVerifyOtpLoading: false);
      LogHelper.logError('Verify OTP error: $e');
      AppToastHelper.showError(AppStrings.somethingWentWrong);
    }
  }

  void setIsLoginSubmitted({required bool value}) {
    state = state.copyWith(isLoginSubmitted: value);
  }

  //* Device Info
  Future<String> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    var deviceName = 'Unknown Device';

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
      LogHelper.logInfo('Android Device: ${androidInfo.model}');
      LogHelper.logInfo('Android Version: ${androidInfo.version.release}');
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine;
      LogHelper.logInfo('iOS Device: ${iosInfo.utsname.machine}');
      LogHelper.logInfo('iOS Version: ${iosInfo.systemVersion}');
    }

    return deviceName;
  }

  //* App Info
  Future<String> getAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    LogHelper.logInfo('App Version: ${packageInfo.version}');
    LogHelper.logInfo('Build Number: ${packageInfo.buildNumber}');
    return packageInfo.version;
  }

  Future<void> getPublicKeyAndSetToLocal() async {
    final publicKey = AppConfig.instance.appEnvironment == Environment.dev
        ? EncryptionKey.devPayloadEncryption
        : AppConfig.instance.appEnvironment == Environment.uat
            ? EncryptionKey.uatPayloadEncryption
            : EncryptionKey.prodPayloadEncryption;
    await PreferenceHelper.setStringPrefValue(
      key: PreferenceKeys.publicKey,
      value: publicKey,
    );
    LogHelper.logError('Public Key: $publicKey');
    await EncryptionService.loadPublicKey();
  }

  Future<void> getMastersData() async {
    final response = await mastersApiRepo.getMastersData();
    response.fold((_) => null, MasterDataController.instance.setMastersData);
  }

  Future<void> getSignedCookies() async {
    final response = await authRepository.getSignedCookies();
    response.fold(
      AppErrorHandler.showError,
      (cookies) {
        signedCookies.value = cookies;
      },
    );
  }

  void clearOtp() {
    state.otp = '';
    state = state.copyWith();
  }

  void onPasswordFieldChange(String value) {
    if (state.isLoginSubmitted) {
      if (value.isEmpty) {
        state = state.copyWith(
          hasPasswordError: true,
          passwordErrorText: AppStrings.pleaseEnterPassword,
        );
      } else if (value.length < 4) {
        state = state.copyWith(
          hasPasswordError: true,
          passwordErrorText: AppStrings.pleaseEnter4DigitPassword,
        );
      } else {
        state = state.copyWith(
          hasPasswordError: false,
          passwordErrorText: '',
        );
      }
    }
  }

  void onConfirmPasswordFieldChange(String value) {
    if (state.isLoginSubmitted) {
      if (value.isEmpty) {
        state = state.copyWith(
          hasConfirmPasswordError: true,
          hasConfirmPasswordErrorText: AppStrings.pleaseEnterConfirmPassword,
        );
      } else if (value.length < 4) {
        state = state.copyWith(
          hasConfirmPasswordError: true,
          hasConfirmPasswordErrorText: AppStrings.pleaseEnter4DigitPassword,
        );
      } else {
        state = state.copyWith(hasConfirmPasswordError: false, hasConfirmPasswordErrorText: '');
      }
    }
  }

  void onOTPFieldChange(String value) {
    if (state.isLoginSubmitted) {
      if (value.isEmpty) {
        state = state.copyWith(hasOTPError: true, otpErrorText: AppStrings.pleaseEnterOTP);
      } else if (value.length < 6) {
        state = state.copyWith(hasOTPError: true, otpErrorText: AppStrings.pleaseEnter6DigitOTP);
      } else {
        state = state.copyWith(hasOTPError: false, otpErrorText: '');
      }
    }
  }

  void resetPasswordError() {
    state = state.copyWith(
      hasPasswordError: false,
      passwordErrorText: '',
      hasOTPError: false,
      otpErrorText: '',
      hasConfirmPasswordError: false,
      hasConfirmPasswordErrorText: '',
      isLoginSubmitted: false,
    );
  }

  void setPasswordFieldFocus({required bool isFocused}) {
    state = state.copyWith(isPasswordFieldFocused: isFocused);
  }

  bool get isUserLoggedIn {
    final isLoggedIn = PreferenceHelper.getBoolPrefValue(key: PreferenceKeys.isLogin);
    return isLoggedIn ?? false;
  }

  // MARK: - Set User pref
  //*======================================== Set User pref ========================================

  Future<void> _setUserPreferences({required LoginResponseDataModel? loginData, bool storeLoginFlag = true}) async {
    await Future.wait([
      if (storeLoginFlag) PreferenceHelper.setBoolPrefValue(key: PreferenceKeys.isLogin, value: true),
      PreferenceHelper.setStringPrefValue(key: PreferenceKeys.accessToken, value: loginData?.data?.accessToken ?? ''),
      PreferenceHelper.setStringPrefValue(key: PreferenceKeys.refreshToken, value: loginData?.data?.refreshToken ?? ''),
      PreferenceHelper.setStringPrefValue(key: PreferenceKeys.currentUserName, value: loginData?.data?.userName ?? ''),
      PreferenceHelper.setStringPrefValue(key: PreferenceKeys.userId, value: loginData?.data?.userId ?? ''),
      PreferenceHelper.setIntPrefValue(key: PreferenceKeys.zonesCount, value: loginData?.zonesCount ?? 0),
      PreferenceHelper.setIntPrefValue(key: PreferenceKeys.subRegionsCount, value: loginData?.subRegionsCount ?? 0),
      PreferenceHelper.setIntPrefValue(key: PreferenceKeys.territoriesCount, value: loginData?.territoriesCount ?? 0),
    ]);
  }

  // Create New Password method
  Future<void> createNewPassword({
    required CreateNewPasswordRequestModel requestModel,
  }) async {
    try {
      state = state.copyWith(isGeneratePasswordLoading: true);
      LogHelper.logInfo('Creating new password...');

      final result = await authRepository.createNewPassword(
        requestModel: requestModel,
      );

      state = state.copyWith(isGeneratePasswordLoading: false);

      result.fold(
        (error) {
          LogHelper.logError('Create new password failed: ${error.message}');
          AppToastHelper.showError(error.message);
        },
        (response) {
          LogHelper.logInfo('New password created successfully');
          AppToastHelper.showSuccess('Password updated successfully');
          // Navigate back to login or handle success as needed
          AppNavigation.back();
        },
      );
    } on Exception catch (e) {
      state = state.copyWith(isGeneratePasswordLoading: false);
      LogHelper.logError('Create new password error: $e');
      AppToastHelper.showError(AppStrings.somethingWentWrong);
    }
  }
}
