// Package imports:
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:master_utility/master_utility.dart';
// Project imports:
import 'package:riddhi_clone/config/env/app_env.dart';
import 'package:riddhi_clone/config/sentry/sentry.dart';
import 'package:riddhi_clone/constants/pref_keys.dart';
import 'package:riddhi_clone/helpers/device_info_helper.dart';
import 'package:riddhi_clone/main.dart';
import 'package:riddhi_clone/services/notification/firebase_notification_service.dart';
import 'package:riddhi_clone/services/notification/local_notification_service.dart';

enum Environment { dev, uat, prod }

class AppConfig {
  AppConfig._();
  static AppConfig instance = AppConfig._();
  Environment? appEnvironment;

  Future<void> setAppConfig({required Environment environment}) async {
    appEnvironment = environment;
    await _initializeApp(environment: environment);
    await PreferenceHelper.setStringPrefValue(
      key: PreferenceKeys.environment,
      value: environment.name,
    );
    await InitSentry().runAppWithSentry(
      const AppWidget(),
      environment: environment,
    );
  }

  Future<String> getEnvironment() async {
    final environment = PreferenceHelper.getStringPrefValue(key: PreferenceKeys.environment);
    return environment;
  }

  Future<void> _initializeApp({required Environment environment}) async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await Firebase.initializeApp();
    NavigationHelper().setNavigationType(NavigationType.CUPERTINO);
    await FirebaseMessagingService.instance.init();
    await LocalNotificationService.instance.init();
    await PreferenceHelper.init(
      encryptionKey: AppEnv.preferenceHelperEncryptionKey,
    );
    unawaited(
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      ),
    );
    //* Flutter native splash screen will be remove once all the initialization is complete
    FlutterNativeSplash.remove();
    await DeviceInfoHelper.instance.initPlatformState();
  }
}
