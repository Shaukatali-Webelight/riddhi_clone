// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Project imports:
import 'package:riddhi_clone/features/ziya/views/ziya_main_screen.dart';

class ZiyaDemo extends StatelessWidget {
  const ZiyaDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        title: 'Ziya Demo',
        home: ZiyaMainScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

void main() {
  runApp(const ZiyaDemo());
}
