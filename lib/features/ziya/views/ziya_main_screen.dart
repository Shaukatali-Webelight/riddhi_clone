// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Project imports:
import 'package:riddhi_clone/features/ziya/controllers/ziya_state_notifier.dart';
import 'package:riddhi_clone/features/ziya/views/widgets/ziya_bottom_nav_widget.dart';
import 'package:riddhi_clone/features/ziya/views/ziya_home_screen.dart';

class ZiyaMainScreen extends ConsumerWidget {
  const ZiyaMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ziyaStateNotifierProvider);
    final notifier = ref.read(ziyaStateNotifierProvider.notifier);

    return Scaffold(
      body: IndexedStack(
        index: state.currentBottomNavIndex,
        children: const [
          ZiyaHomeScreen(),
          Placeholder(), // MindCare Screen
          Placeholder(), // Chat Bot Screen
          Placeholder(), // Sleep Care Screen
          Placeholder(), // Life Stage Screen
        ],
      ),
      bottomNavigationBar: ZiyaBottomNavWidget(
        currentIndex: state.currentBottomNavIndex,
        onTap: notifier.updateBottomNavIndex,
      ),
    );
  }
}
