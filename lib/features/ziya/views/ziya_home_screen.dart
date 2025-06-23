// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Project imports:
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/features/ziya/controllers/ziya_state_notifier.dart';
import 'package:riddhi_clone/features/ziya/views/widgets/ziya_background_elements_widget.dart';
import 'package:riddhi_clone/features/ziya/views/widgets/ziya_content_section_widget.dart';
import 'package:riddhi_clone/features/ziya/views/widgets/ziya_header_widget.dart';
import 'package:riddhi_clone/features/ziya/views/widgets/ziya_selected_mood_widget.dart';

class ZiyaHomeScreen extends ConsumerStatefulWidget {
  const ZiyaHomeScreen({super.key});

  @override
  ConsumerState<ZiyaHomeScreen> createState() => _ZiyaHomeScreenState();
}

class _ZiyaHomeScreenState extends ConsumerState<ZiyaHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ziyaStateNotifierProvider.notifier).loadAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ziyaStateNotifierProvider);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            // Header section with background image
            const ZiyaHeaderWidget(),

            // Body section with content
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF51ADE8),
                      Color(0xFF2076B0),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background decorative elements
                    const ZiyaBackgroundElementsWidget(),

                    // Main content
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: AppConst.k16,
                          right: AppConst.k16,
                          bottom: AppConst.k40,
                        ),
                        child: Column(
                          children: [
                            // Selected Mood Section
                            const ZiyaSelectedMoodWidget(),

                            const SizedBox(height: AppConst.k24),

                            // Today's on Zora Section
                            ZiyaContentSectionWidget(
                              title: "Today's on Zora",
                              items: state.todaysRecommendations,
                              isLoading: state.isLoading,
                            ),

                            const SizedBox(height: AppConst.k24),

                            // Recommended for you Section
                            ZiyaContentSectionWidget(
                              title: 'Recommended for you',
                              items: state.personalRecommendations,
                              isLoading: state.isLoading,
                            ),

                            const SizedBox(height: AppConst.k24),

                            // Trending On Zora Section
                            ZiyaContentSectionWidget(
                              title: 'Trending On Zora',
                              items: state.trendingContent,
                              isLoading: state.isLoading,
                            ),

                            const SizedBox(height: AppConst.k24),

                            // New on Zora Section
                            ZiyaContentSectionWidget(
                              title: 'New on Zora',
                              items: state.newContent,
                              isLoading: state.isLoading,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
