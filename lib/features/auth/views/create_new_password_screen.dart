import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:riddhi_clone/config/assets/assets.gen.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/constants/app_validations.dart';
import 'package:riddhi_clone/features/auth/controllers/auth_state_notifier.dart';
import 'package:riddhi_clone/features/auth/models/create_new_password_request_model.dart';
import 'package:riddhi_clone/features/auth/views/widgets/back_to_login_button.dart';
import 'package:riddhi_clone/resources/app_utils.dart';
import 'package:riddhi_clone/resources/toast_helper.dart';
import 'package:riddhi_clone/widgets/common/app_button.dart';
import 'package:riddhi_clone/widgets/common/common_container_widget.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({
    required this.phone,
    required this.otp,
    super.key,
  });

  final String phone;
  final String otp;

  @override
  State<StatefulWidget> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final newPasswordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();
  final newPasswordController = ValueNotifier<TextEditingController>(TextEditingController());
  final confirmPasswordController = ValueNotifier<TextEditingController>(TextEditingController());
  ScrollController? scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    newPasswordFocus.addListener(() => AppUtils.checkKeyboardVisibility(scrollController));
    confirmPasswordFocus.addListener(() => AppUtils.checkKeyboardVisibility(scrollController));
  }

  @override
  void dispose() {
    newPasswordFocus.removeListener(() => AppUtils.checkKeyboardVisibility(scrollController));
    confirmPasswordFocus.removeListener(() => AppUtils.checkKeyboardVisibility(scrollController));
    newPasswordController.dispose();
    newPasswordFocus.dispose();
    confirmPasswordController.dispose();
    confirmPasswordFocus.dispose();
    scrollController?.dispose();
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
            child: Consumer(
              builder: (context, ref, child) {
                final authState = ref.watch(authStateNotifierProvider);
                final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
                return IgnorePointer(
                  ignoring: authState.isLoading,
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
                          child: IgnorePointer(
                            ignoring: authState.isLoading,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  child: Text(
                                    AppStrings.createNewPassword,
                                    style: AppStyles.getBoldStyle(
                                      fontSize: AppConst.k28,
                                    ),
                                  ),
                                ),
                                AppConst.gap24,
                                Text(
                                  AppStrings.newPassword,
                                  style: AppStyles.getLightStyle(
                                    fontSize: AppConst.k14,
                                  ),
                                ),
                                AppConst.gap4,
                                PinCodeTextField(
                                  cursorColor: AppColors.primaryText,
                                  appContext: context,
                                  controller: newPasswordController.value,
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
                                      ? (newPasswordFocus
                                        ..addListener(
                                          () {
                                            final hasFocus = newPasswordFocus.hasFocus;
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
                                      : newPasswordFocus,
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
                                  textInputAction: TextInputAction.next,
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
                                Text(
                                  AppStrings.confirmNewPassword,
                                  style: AppStyles.getLightStyle(
                                    fontSize: AppConst.k14,
                                  ),
                                ),
                                AppConst.gap4,
                                PinCodeTextField(
                                  cursorColor: AppColors.primaryText,
                                  appContext: context,
                                  controller: confirmPasswordController.value,
                                  textStyle: AppStyles.getLightStyle(
                                    color: AppColors.primaryText,
                                    fontSize: AppConst.k14,
                                  ),
                                  hintCharacter: AppStrings.passwordHintChar,
                                  animationType: AnimationType.fade,
                                  autoDisposeControllers: false,
                                  length: 4,
                                  onChanged: authStateNotifier.onConfirmPasswordFieldChange,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  beforeTextPaste: (text) => text != null && AppValidation.instance.isNumeric(text),
                                  focusNode: (Platform.isIOS)
                                      ? (confirmPasswordFocus
                                        ..addListener(
                                          () {
                                            final hasFocus = confirmPasswordFocus.hasFocus;
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
                                      : confirmPasswordFocus,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  errorTextSpace: 25,
                                  pinTheme: PinTheme(
                                    activeFillColor: AppColors.primary,
                                    inactiveFillColor: AppColors.primary,
                                    selectedFillColor: AppColors.primary,
                                    activeColor: authState.hasConfirmPasswordError ? AppColors.red : AppColors.divider,
                                    inactiveColor:
                                        authState.hasConfirmPasswordError ? AppColors.red : AppColors.divider,
                                    selectedColor:
                                        authState.hasConfirmPasswordError ? AppColors.red : AppColors.divider,
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
                                if (authState.hasConfirmPasswordError) ...[
                                  AppConst.gap8,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: AppConst.k10),
                                    child: Text(
                                      authState.hasConfirmPasswordErrorText,
                                      style: AppStyles.getLightStyle(
                                        fontSize: AppConst.k12,
                                        color: AppColors.red,
                                      ),
                                    ),
                                  ),
                                ],
                                AppConst.gap24,
                                AppButton(
                                  title: AppStrings.save,
                                  isLoading: authState.isLoading,
                                  disabledBackgroundColor: AppColors.primary,
                                  backgroundColor: AppColors.primary,
                                  onPressed: () {
                                    authStateNotifier
                                      ..setIsLoginSubmitted(value: true)
                                      ..onPasswordFieldChange(newPasswordController.value.text)
                                      ..onConfirmPasswordFieldChange(confirmPasswordController.value.text);
                                    final validate = formKey.currentState?.validate() ?? false;
                                    if (validate &&
                                        (newPasswordController.value.text.length == 4 &&
                                            confirmPasswordController.value.text.length == 4)) {
                                      if (newPasswordController.value.text != confirmPasswordController.value.text) {
                                        AppToastHelper.showError(AppStrings.passwordNotMatched);
                                      } else {
                                        authStateNotifier.createNewPassword(
                                          requestModel: CreateNewPasswordRequestModel(
                                            phone: widget.phone,
                                            otp: widget.otp,
                                            password: newPasswordController.value.text,
                                            confirmPassword: confirmPasswordController.value.text,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppConst.k20),
                        child: BackButtonWidget(
                          phoneNumber: widget.phone,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
