import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:master_utility/master_utility.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:riddhi_clone/config/assets/assets.gen.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/constants/app_validations.dart';
import 'package:riddhi_clone/features/auth/controllers/auth_state_notifier.dart';
import 'package:riddhi_clone/features/auth/models/send_otp_request_model.dart';
import 'package:riddhi_clone/resources/app_utils.dart';
import 'package:riddhi_clone/resources/toast_helper.dart';
import 'package:riddhi_clone/services/notification/firebase_notification_service.dart';
import 'package:riddhi_clone/widgets/common/app_button.dart';
import 'package:riddhi_clone/widgets/common/app_text_field.dart';
import 'package:riddhi_clone/widgets/common/common_container_widget.dart';
import 'package:riddhi_clone/widgets/common/status_dot_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.phoneNumber});

  final String? phoneNumber;

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final phoneFocus = FocusNode();
  final passwordFocus = FocusNode();
  final passwordController = ValueNotifier<TextEditingController>(TextEditingController());
  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseMessagingService.instance.deleteFCMToken();
      final ref = ProviderScope.containerOf(context);
      ref.read(authStateNotifierProvider.notifier).getPublicKeyAndSetToLocal();
      if (widget.phoneNumber != null) {
        phoneController.text = widget.phoneNumber!;
      }
      phoneFocus.addListener(() => AppUtils.checkKeyboardVisibility(scrollController));
      passwordFocus.addListener(() => AppUtils.checkKeyboardVisibility(scrollController));
    });
  }

  @override
  void dispose() {
    phoneFocus.removeListener(() => AppUtils.checkKeyboardVisibility(scrollController));
    passwordFocus.removeListener(() => AppUtils.checkKeyboardVisibility(scrollController));
    scrollController?.dispose();
    phoneController.dispose();
    passwordController.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
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
          child: SingleChildScrollView(
            controller: scrollController,
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
                  child: Consumer(
                    builder: (context, ref, child) {
                      final authState = ref.watch(authStateNotifierProvider);
                      final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
                      return Form(
                        key: formKey,
                        child: IgnorePointer(
                          ignoring: authState.isLoading || authState.isGeneratePasswordLoading,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppStrings.mobileNumber,
                                style: AppStyles.getLightStyle(
                                  fontSize: AppConst.k14,
                                ),
                              ),
                              AppConst.gap4,
                              AppTextField(
                                focusNode: phoneFocus,
                                controller: phoneController,
                                hintText: AppStrings.enterPhoneNumber,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(AppConst.k10.toInt()),
                                  FilteringTextInputFormatter.digitsOnly,
                                  AppValidation.instance.indianPhoneNumberFormatter,
                                ],
                                validator: ValidationHelper.validateMobile,
                                onFieldSubmitted: (_) {
                                  phoneFocus.unfocus();
                                  FocusScope.of(context).requestFocus(passwordFocus);
                                },
                                onChanged: (value) {
                                  if (value.length == AppConst.k10) {
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                                isSubmitted: authState.isLoginSubmitted,
                              ),
                              AppConst.gap24,
                              Text(
                                AppStrings.password,
                                style: AppStyles.getLightStyle(
                                  fontSize: AppConst.k14,
                                ),
                              ),
                              AppConst.gap4,
                              PinCodeTextField(
                                cursorColor: AppColors.primaryText,
                                appContext: context,
                                controller: passwordController.value,
                                textStyle: AppStyles.getLightStyle(
                                  color: AppColors.primaryText,
                                  fontSize: AppConst.k14,
                                ),
                                hintCharacter: AppStrings.passwordHintChar,
                                animationType: AnimationType.fade,
                                autoDisposeControllers: false,
                                length: 4,
                                onChanged: authStateNotifier.onPasswordFieldChange,
                                autovalidateMode: AutovalidateMode.disabled,
                                beforeTextPaste: (text) => text != null && AppValidation.instance.isNumeric(text),
                                focusNode: (Platform.isIOS)
                                    ? (passwordFocus
                                      ..addListener(
                                        () {
                                          final hasFocus = passwordFocus.hasFocus;
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
                                    : passwordFocus,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                errorTextSpace: 25,
                                pinTheme: PinTheme(
                                  activeFillColor: AppColors.primary,
                                  inactiveFillColor: AppColors.primary,
                                  selectedFillColor: AppColors.primary,
                                  activeColor: authState.hasPasswordError ? AppColors.red : AppColors.divider,
                                  inactiveColor: authState.hasPasswordError ? AppColors.red : AppColors.divider,
                                  selectedColor: authState.hasPasswordError ? AppColors.red : AppColors.divider,
                                  borderWidth: 0.5,
                                  disabledBorderWidth: 0.5,
                                  errorBorderWidth: 0.5,
                                  activeBorderWidth: 0.5,
                                  inactiveBorderWidth: 0.5,
                                  selectedBorderWidth: 0.5,
                                  fieldWidth: (AppConst.width - 120) / 4,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(AppConst.k8),
                                ),
                              ),
                              if (authState.hasPasswordError) ...[
                                AppConst.gap8,
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: AppConst.k10),
                                  child: Text(
                                    authState.passwordErrorText,
                                    style: AppStyles.getLightStyle(
                                      fontSize: AppConst.k12,
                                      color: AppColors.red,
                                    ),
                                  ),
                                ),
                              ],
                              AppConst.gap24,
                              Align(
                                child: GestureDetector(
                                  onTap: () async {
                                    if (ValidationHelper.validateMobile(phoneController.text) != null ||
                                        phoneController.text.length != AppConst.k10) {
                                      AppToastHelper.showError(AppStrings.pleaseEnterValidPhoneNumber);
                                    } else {
                                      authStateNotifier.resetPasswordError();
                                      await authStateNotifier.sendOtp(
                                        requestModel: SendOtpRequestModel(
                                          phone: phoneController.text,
                                        ),
                                      );
                                    }
                                  },
                                  child: authState.isGeneratePasswordLoading
                                      ? const SizedBox(
                                          width: AppConst.k20,
                                          height: AppConst.k20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: AppConst.k2,
                                            color: AppColors.primary,
                                          ),
                                        )
                                      : Text(
                                          AppStrings.generatePassword,
                                          style: AppStyles.getRegularStyle(
                                            fontSize: AppConst.k14,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                ),
                              ),
                              AppConst.gap24,
                              AppButton(
                                title: AppStrings.login,
                                isLoading: authState.isLoading,
                                disabledBackgroundColor: AppColors.primary,
                                backgroundColor: AppColors.primary,
                                onPressed: () {
                                  authStateNotifier
                                    ..setIsLoginSubmitted(value: true)
                                    ..onPasswordFieldChange(passwordController.value.text);
                                  final validate = formKey.currentState?.validate() ?? false;
                                  if (validate && (passwordController.value.text.length == 4)) {
                                    authStateNotifier.login(
                                      phone: phoneController.text,
                                      password: passwordController.value.text,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AppConst.gap16,
                CommonContainerWidget(
                  padding: const EdgeInsets.symmetric(vertical: AppConst.k8, horizontal: AppConst.k24),
                  margin: const EdgeInsets.symmetric(horizontal: AppConst.k16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.helpDocument,
                        style: AppStyles.getBoldStyle(
                          fontSize: AppConst.k14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      AppConst.gap10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            AppStrings.firstTimeLogin,
                            style: AppStyles.getRegularStyle(
                              fontSize: AppConst.k12,
                              color: AppColors.secondaryText,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const StatusDotWidget(
                            color: AppColors.secondaryText,
                          ),
                          Text(
                            AppStrings.login,
                            style: AppStyles.getRegularStyle(
                              fontSize: AppConst.k12,
                              color: AppColors.secondaryText,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const StatusDotWidget(
                            color: AppColors.secondaryText,
                          ),
                          Text(
                            AppStrings.forgotPassword,
                            style: AppStyles.getRegularStyle(
                              fontSize: AppConst.k12,
                              color: AppColors.secondaryText,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppConst.gap16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
