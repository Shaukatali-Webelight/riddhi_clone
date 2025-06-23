// Flutter imports:
import 'package:flutter/material.dart';

class WillPopScopeWidget extends StatelessWidget {
  const WillPopScopeWidget({
    required this.child,
    this.canPop = true,
    this.onPopInvokedWithResult,
    super.key,
  });
  final Widget child;
  final bool canPop;

  final void Function(bool, dynamic)? onPopInvokedWithResult;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: onPopInvokedWithResult,
      canPop: canPop,
      child: child,
    );
  }
}
