// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/config/assets/assets.gen.dart';
// Project imports:
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/features/auth/controllers/auth_state_notifier.dart';
import 'package:riddhi_clone/features/auth/views/auth_screen.dart';
import 'package:riddhi_clone/features/bottom_nav/bottom_nav_screen.dart';
import 'package:riddhi_clone/features/common/controllers/master_data.dart';
import 'package:riddhi_clone/features/common/repository/master_api_repo.dart';
import 'package:riddhi_clone/features/master_utility_demo_screen.dart';
import 'package:riddhi_clone/features/splash/presentation/splash_future_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showTestButton = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final ref = ProviderScope.containerOf(context);
      final splashStateNotifier = ref.read(splashStateNotifierProvider.notifier);
      final auth = ref.read(authStateNotifierProvider.notifier);
      await splashStateNotifier.init(context);
      unawaited(auth.getSignedCookies());
      if (auth.isUserLoggedIn) {
        final response = await ref.read(masterDataRepo).getMastersData();
        response.fold((_) => null, MasterDataController.instance.setMastersData);
      }

      // Show test button after 2 seconds
      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showTestButton = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Center(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1500),
              tween: Tween<double>(begin: 0, end: 1),
              onEnd: () {
                // Removed automatic navigation for testing
              },
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Image.asset(AppAssets.images.gsp.path),
                );
              },
            ),
          ),

          // Test buttons
          if (_showTestButton)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BottomNavScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Test Match Screen'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MasterUtilityDemoScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('🚀 Master Utility Demo'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      final ref = ProviderScope.containerOf(context);
                      final auth = ref.read(authStateNotifierProvider.notifier);
                      NavigationHelper.navigatePushRemoveUntil(
                        route: auth.isUserLoggedIn ? const BottomNavScreen() : const AuthScreen(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Continue Normal Flow'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
