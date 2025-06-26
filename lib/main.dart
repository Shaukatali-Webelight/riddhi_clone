// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
// Project imports:
import 'package:riddhi_clone/constants/theme.dart';
import 'package:riddhi_clone/features/splash/views/splash_screen.dart';
import 'package:riddhi_clone/features/theme/presentation/theme_notifier.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final signedCookies = ValueNotifier<Map<String, String>>({});

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.white, // Color for Android
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.scaffoldBg,
        systemNavigationBarDividerColor: AppColors.scaffoldBg,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light, // light == black status bar for IOS.
      ),
      child: ProviderScope(
        child: Consumer(
          builder: (context, ref, child) {
            final themeState = ref.watch(themeStateNotifierProvider);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.noScaling,
              ),
              child: MasterUtilityMaterialApp(
                //!TODO Enable this to use device preview
                // useInheritedMediaQuery: true,
                // locale: DevicePreview.locale(context),
                // builder: (context, child) => FToastBuilder()(
                //   context,
                //   DevicePreview.appBuilder(context, child),
                // ),
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    alwaysUse24HourFormat: true,
                  ),
                  child: DismissKeyboard(
                    child: child ?? const SplashScreen(),
                  ),
                ),
                scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
                theme: themeState ? AppTheme.darkTheme : AppTheme.lightTheme,
                home: const SplashScreen(),
                navigatorObservers: [
                  SentryNavigatorObserver(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
