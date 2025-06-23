import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:riddhi_clone/config/assets/assets.gen.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/config/flavours/app.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/constants/app_validations.dart';
import 'package:riddhi_clone/features/auth/controllers/auth_state_notifier.dart';
import 'package:riddhi_clone/features/auth/models/send_otp_request_model.dart';
import 'package:riddhi_clone/features/auth/models/verify_otp_request_model.dart';
import 'package:riddhi_clone/features/auth/views/widgets/back_to_login_button.dart';
import 'package:riddhi_clone/widgets/common/app_button.dart';
import 'package:riddhi_clone/widgets/common/common_container_widget.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({required this.phoneNo, super.key});

  final String phoneNo;

  @override
  State<StatefulWidget> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final formKey = GlobalKey<FormState>();
  final otpFocus = FocusNode();
  final appEnv = ValueNotifier<String>('');
  final otpController = ValueNotifier<TextEditingController>(TextEditingController());

  final ValueNotifier<int> _timer = ValueNotifier<int>(0);
  Timer? _countdownTimer;

  void startTimer(int time) {
    _timer.value = time;
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _timer.value = _timer.value - 1;

        if (_timer.value == 0) {
          timer.cancel();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer(AppConst.k60.toInt());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getEnv();
    });
  }

  void getEnv() {
    appEnv.value = AppConfig.instance.appEnvironment?.name ?? '';
  }

  void cancelTimer() {
    _countdownTimer?.cancel();
  }

  void onResendOTP(WidgetRef ref) {
    otpController.value.clear();
    ref.read(authStateNotifierProvider.notifier)
      ..clearOtp()
      ..sendOtp(
        requestModel: SendOtpRequestModel(
          phone: widget.phoneNo,
        ),
      );
    startTimer(60);
  }

  @override
  void dispose() {
    otpController.dispose();
    otpFocus.dispose();
    _timer.dispose();
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.scaffoldBg,
        systemNavigationBarDividerColor: AppColors.scaffoldBg,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light, // light == black status bar for IOS.
      ),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              final authState = ref.watch(authStateNotifierProvider);
              final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
              return IgnorePointer(
                ignoring: authState.isLoading,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppConst.gap90,
                      AppAssets.icons.gspLogoWhite.svg(
                        width: AppConst.k100,
                        height: AppConst.k100,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      AppConst.gap90,
                      CommonContainerWidget(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppConst.k24),
                        margin: const EdgeInsets.symmetric(horizontal: AppConst.k16),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppConst.k8),
                          bottomLeft: Radius.circular(AppConst.k8),
                          bottomRight: Radius.circular(AppConst.k8),
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                child: Text(
                                  AppStrings.verifyPhone,
                                  style: AppStyles.getBoldStyle(
                                    fontSize: AppConst.k28,
                                  ),
                                ),
                              ),
                              AppConst.gap16,
                              Align(
                                child: Text(
                                  '${AppStrings.codeIsSentTo} ${widget.phoneNo}',
                                  style: AppStyles.getLightStyle(
                                    fontSize: AppConst.k14,
                                    color: AppColors.secondaryText,
                                  ),
                                ),
                              ),
                              AppConst.gap24,
                              PinCodeTextField(
                                cursorColor: AppColors.primaryText,
                                appContext: context,
                                controller: otpController.value,
                                textStyle: AppStyles.getLightStyle(
                                  color: AppColors.primaryText,
                                  fontSize: AppConst.k14,
                                ),
                                hintCharacter: AppStrings.passwordHintChar,
                                animationType: AnimationType.fade,
                                autoDisposeControllers: false,
                                length: 6,
                                onChanged: authStateNotifier.onOTPFieldChange,
                                autovalidateMode: AutovalidateMode.disabled,
                                beforeTextPaste: (text) => text != null && AppValidation.instance.isNumeric(text),
                                focusNode: (Platform.isIOS)
                                    ? (otpFocus
                                      ..addListener(
                                        () {
                                          final hasFocus = otpFocus.hasFocus;
                                          if (hasFocus) {
                                            authStateNotifier.setPasswordFieldFocus(
                                              isFocused: true,
                                            );
                                          } else {
                                            authStateNotifier.setPasswordFieldFocus(
                                              isFocused: false,
                                            );
                                          }
                                        },
                                      ))
                                    : otpFocus,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                errorTextSpace: 25,
                                pinTheme: PinTheme(
                                  activeFillColor: AppColors.primary,
                                  inactiveFillColor: AppColors.primary,
                                  selectedFillColor: AppColors.primary,
                                  activeColor: authState.hasOTPError ? AppColors.red : AppColors.divider,
                                  inactiveColor: authState.hasOTPError ? AppColors.red : AppColors.divider,
                                  selectedColor: authState.hasOTPError ? AppColors.red : AppColors.divider,
                                  borderWidth: 0.5,
                                  disabledBorderWidth: 0.5,
                                  errorBorderWidth: 0.5,
                                  activeBorderWidth: 0.5,
                                  inactiveBorderWidth: 0.5,
                                  selectedBorderWidth: 0.5,
                                  fieldWidth: (AppConst.width - 120) / 6,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(AppConst.k8),
                                ),
                              ),
                              if (authState.hasOTPError) ...[
                                AppConst.gap8,
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: AppConst.k10),
                                  child: Text(
                                    authState.otpErrorText,
                                    style: AppStyles.getLightStyle(
                                      fontSize: AppConst.k12,
                                      color: AppColors.red,
                                    ),
                                  ),
                                ),
                              ],
                              AppConst.gap24,
                              Align(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: _timer,
                                      builder: (context, value, child) {
                                        if (value > 0) {
                                          return Text.rich(
                                            TextSpan(
                                              style: AppStyles.getLightStyle(
                                                fontSize: AppConst.k14,
                                                color: AppColors.secondaryText,
                                              ),
                                              children: [
                                                const TextSpan(text: AppStrings.resendCodeIn),
                                                TextSpan(
                                                  text:
                                                      '${(value ~/ 60).toString().padLeft(2, "0")}:${(value % 60).toString().padLeft(2, "0")}',
                                                  style: AppStyles.getBoldStyle(
                                                    fontSize: AppConst.k14,
                                                    color: AppColors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return GestureDetector(
                                            onTap: authState.isLoading ? null : () => onResendOTP(ref),
                                            child: Text(
                                              AppStrings.resendOTP,
                                              style: AppStyles.getRegularStyle(
                                                fontSize: AppConst.k14,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              AppConst.gap24,
                              AppButton(
                                title: AppStrings.verify,
                                isLoading: authState.isLoading,
                                disabledBackgroundColor: AppColors.primary,
                                backgroundColor: AppColors.primary,
                                onPressed: () {
                                  authStateNotifier
                                    ..setIsLoginSubmitted(value: true)
                                    ..onOTPFieldChange(otpController.value.text);
                                  final validate = formKey.currentState?.validate() ?? false;
                                  if (validate && (otpController.value.text.length == 6)) {
                                    authStateNotifier
                                      ..resetPasswordError()
                                      ..verifyOtp(
                                        requestModel: VerifyOtpRequestModel(
                                          phone: widget.phoneNo,
                                          otp: otpController.value.text,
                                        ),
                                      );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppConst.k20),
                        child: BackButtonWidget(
                          phoneNumber: widget.phoneNo,
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: appEnv,
                        builder: (context, value, child) {
                          return value == Environment.dev.name || value == Environment.uat.name
                              ? Text(
                                  '${AppStrings.otp} : ${authState.otp}',
                                  style: AppStyles.getRegularStyle(
                                    color: AppColors.white,
                                  ),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
