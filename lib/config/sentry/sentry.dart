// Dart imports:
// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:master_utility/master_utility.dart';
// Project imports:
import 'package:riddhi_clone/config/env/app_env.dart';
import 'package:riddhi_clone/config/flavours/app.dart';
// Package imports:
import 'package:sentry_flutter/sentry_flutter.dart';

class InitSentry {
  Future<void> runAppWithSentry(
    Widget widget, {
    required Environment environment,
  }) async {
    final sentryDSN = AppEnv.sentryUrl;

    try {
      kReleaseMode
          ? runZonedGuarded(() async {
              await SentryFlutter.init(
                (options) {
                  options
                    ..dsn = sentryDSN
                    ..attachScreenshot = true
                    ..environment = environment.name
                    ..attachThreads = true
                    ..attachStacktrace = true
                    ..reportPackages = true
                    ..attachThreads = true;
                },
              );

              runApp(SentryScreenshotWidget(child: widget));
            }, (exception, stackTrace) async {
              await Sentry.captureException(exception, stackTrace: stackTrace);
            })
          : runApp(
              //!TODO: Enable this for device preview
              // DevicePreview(builder: (context) => widget),
              widget,
            );
    } catch (e) {
      LogHelper.logError(e, stackTrace: StackTrace.current);
    }
  }
}
