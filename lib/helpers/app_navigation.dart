import 'package:flutter/material.dart';
import 'package:master_utility/master_utility.dart';

BuildContext get globalContext => NavigationService.context;

class AppNavigation {
  static void back([Object? result]) {
    final canPop = Navigator.of(globalContext).canPop();
    if (!canPop) return;
    NavigationHelper.navigatePop(result);
  }

  static Future<dynamic> push({
    required Widget page,
    bool fullScreenDialog = false,
  }) {
    return NavigationHelper.navigatePush(
      route: page,
      fullscreenDialog: fullScreenDialog,
    );
  }

  static Future<dynamic> pushRemoveUntil({
    required Widget page,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return NavigationHelper.navigatePushRemoveUntil(
      route: page,
      predicate: predicate,
    );
  }

  static Future<dynamic> pushReplacement({required Widget page}) {
    return NavigationHelper.navigatePushReplacement(
      route: page,
    );
  }

  static int _count = 0;

  //* Pop until wil used for poping the screen until the count
  static void popUntil({required int count}) {
    Navigator.of(globalContext).popUntil((route) => ++_count == count);
    if (_count == count) _count = 0;
  }

  static bool isCurrentRouteSameAs(Widget page) {
    var isSamePage = false;
    final pageType = page.runtimeType.toString();

    Navigator.of(globalContext).popUntil((route) {
      //* Check if current route is the top-most route and has the same type
      if (route.isActive && route.isCurrent) {
        final routeType = route.settings.name ?? route.settings.arguments?.runtimeType.toString() ?? '';
        isSamePage = routeType == pageType || route.toString().contains(pageType);
      }
      return true;
    });

    return isSamePage;
  }
}
