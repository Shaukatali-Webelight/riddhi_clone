import 'package:flutter/material.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main video background - using a gradient since we don't have the video image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1a1a1a),
                  Color(0xFF2d2d2d),
                  Color(0xFF1a1a1a),
                ],
              ),
            ),
            // Add a sample user image overlay
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
                bottom: MediaQuery.of(context).size.height * 0.25,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24, width: 2),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Color(0xFF444444),
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Connected User',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Top overlay with logo and controls
          _buildTopOverlay(),

          // Right side controls
          _buildRightControls(),

          // Bottom overlay with small videos and controls
          _buildBottomOverlay(),
        ],
      ),
    );
  }

  Widget _buildTopOverlay() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x80000000),
              Color(0x40000000),
              Colors.transparent,
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Safarr logo - using existing asset
                Image.asset(
                  'assets/images/match_screen/safarr_logo.png',
                  height: 24,
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
                const Spacer(),
                // Search icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                // Menu icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRightControls() {
    return Positioned(
      right: 16,
      top: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        children: [
          // User profile section
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Text(
                  'SAFARR05658',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00FF00),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Red control button (likely disconnect/end call)
          _buildControlButton(
            color: const Color(0xFFFF3B30),
            icon: Icons.call_end,
            size: 56,
          ),
          const SizedBox(height: 16),
          // Yellow control button
          _buildControlButton(
            color: const Color(0xFFFFCC02),
            icon: Icons.star,
            size: 48,
          ),
          const SizedBox(height: 16),
          // Green control button (likely accept/connect)
          _buildControlButton(
            color: const Color(0xFF34C759),
            icon: Icons.check,
            size: 48,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required Color color,
    required IconData icon,
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: size * 0.4,
      ),
    );
  }

  Widget _buildBottomOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0x80000000),
              Color(0x40000000),
              Colors.transparent,
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Small video thumbnails row
              _buildVideoThumbnailsRow(),
              const SizedBox(height: 16),
              // Bottom navigation
              _buildBottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoThumbnailsRow() {
    return Row(
      children: [
        // Record button
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFF292929),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.fiber_manual_record,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        // Small video thumbnails
        Expanded(
          child: SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) => _buildVideoThumbnail(index),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Stickers indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                '18 Stickers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVideoThumbnail(int index) {
    return Container(
      width: 60,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: index == 0 ? Colors.white : Colors.transparent,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          color: Colors.grey[700],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[600],
                child: const Icon(
                  Icons.person,
                  color: Colors.white54,
                  size: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'User ${index + 1}',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.color_lens, 'Crossroad', true),
          _buildNavItem(Icons.group, 'DriveBy', false),
          _buildCenterNavItem(),
          _buildNavItem(Icons.chat, 'MyKind', false),
          _buildNavItem(Icons.person, 'Me', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.white : Colors.white54,
            size: 20,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white54,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterNavItem() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white54, width: 1),
      ),
      child: const Icon(
        Icons.radio_button_unchecked,
        color: Colors.white54,
        size: 24,
      ),
    );
  }
}
