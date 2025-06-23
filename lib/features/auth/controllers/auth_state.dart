// class AuthState {
//   const AuthState({
//     this.isLoading = false,
//     this.isAuthenticated = false,
//     this.errorMessage = '',
//     this.userId,
//     this.accessToken,
//     this.refreshToken,
//   });
//   AuthState.initial();
//   final bool isLoading;
//   final bool isAuthenticated;
//   final String errorMessage;
//   final String? userId;
//   final String? accessToken;
//   final String? refreshToken;

//   AuthState copyWith({
//     bool? isLoading,
//     bool? isAuthenticated,
//     String? errorMessage,
//     String? userId,
//     String? accessToken,
//     String? refreshToken,
//   }) {
//     return AuthState(
//       isLoading: isLoading ?? this.isLoading,
//       isAuthenticated: isAuthenticated ?? this.isAuthenticated,
//       errorMessage: errorMessage ?? this.errorMessage,
//       userId: userId ?? this.userId,
//       accessToken: accessToken ?? this.accessToken,
//       refreshToken: refreshToken ?? this.refreshToken,
//     );
//   }

// }
class AuthState {
  AuthState({
    required this.isLoading,
    required this.isGeneratePasswordLoading,
    required this.isVerifyOtpLoading,
    required this.isLoginEnable,
    required this.isPasswordFieldFocused,
    required this.isLoginSubmitted,
    required this.hasPasswordError,
    required this.passwordErrorText,
    required this.hasOTPError,
    required this.otpErrorText,
    required this.hasConfirmPasswordError,
    required this.hasConfirmPasswordErrorText,
    this.otp,
  });

  AuthState.initial();

  bool isLoading = false;
  bool isGeneratePasswordLoading = false;
  bool isVerifyOtpLoading = false;
  String? otp;
  bool isLoginEnable = false;
  bool isPasswordFieldFocused = false;
  bool isLoginSubmitted = false;
  bool hasOTPError = false;
  String otpErrorText = '';
  bool hasPasswordError = false;
  String passwordErrorText = '';
  bool hasConfirmPasswordError = false;
  String hasConfirmPasswordErrorText = '';

  AuthState copyWith({
    bool? isLoading,
    bool? isLoginEnable,
    bool? isGeneratePasswordLoading,
    bool? isVerifyOtpLoading,
    bool? isPasswordFieldFocused,
    bool? isLoginSubmitted,
    bool? hasPasswordError,
    String? passwordErrorText,
    bool? hasOTPError,
    String? otpErrorText,
    bool? hasConfirmPasswordError,
    String? hasConfirmPasswordErrorText,
    String? otp,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoginEnable: isLoginEnable ?? this.isLoginEnable,
      isGeneratePasswordLoading: isGeneratePasswordLoading ?? this.isGeneratePasswordLoading,
      isVerifyOtpLoading: isVerifyOtpLoading ?? this.isVerifyOtpLoading,
      isPasswordFieldFocused: isPasswordFieldFocused ?? this.isPasswordFieldFocused,
      isLoginSubmitted: isLoginSubmitted ?? this.isLoginSubmitted,
      hasOTPError: hasOTPError ?? this.hasOTPError,
      otpErrorText: otpErrorText ?? this.otpErrorText,
      hasPasswordError: hasPasswordError ?? this.hasPasswordError,
      passwordErrorText: passwordErrorText ?? this.passwordErrorText,
      hasConfirmPasswordError: hasConfirmPasswordError ?? this.hasConfirmPasswordError,
      hasConfirmPasswordErrorText: hasConfirmPasswordErrorText ?? this.hasConfirmPasswordErrorText,
      otp: otp ?? this.otp,
    );
  }
}
