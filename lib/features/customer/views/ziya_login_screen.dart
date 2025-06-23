import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ZiyaLoginScreen extends StatefulWidget {
  const ZiyaLoginScreen({super.key});

  @override
  State<ZiyaLoginScreen> createState() => _ZiyaLoginScreenState();
}

class _ZiyaLoginScreenState extends State<ZiyaLoginScreen> {
  final TextEditingController _mobileController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.5, 0),
            end: Alignment(0.5, 1),
            colors: [
              Color(0xFF35A238),
              Color(0xFF0E5C49),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background decorative pattern - positioned exactly as in Figma
            Positioned(
              left: 0,
              top: screenHeight * 0.13, // Responsive positioning
              child: SizedBox(
                width: screenWidth,
                height: screenHeight * 0.32, // Responsive height
                child: Stack(
                  children: [
                    // White gradient overlay
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.32,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.5, 0),
                          end: Alignment(0.5, 1),
                          stops: [0.8645, 0.9311, 1.0],
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0.95),
                            Color.fromRGBO(255, 255, 255, 0.2),
                            Color.fromRGBO(255, 255, 255, 0),
                          ],
                        ),
                      ),
                    ),
                    // Background pattern SVG with fallback
                    Positioned(
                      left: -3.37,
                      top: -24.65,
                      child: SvgPicture.asset(
                        'assets/images/background_pattern.svg',
                        width: screenWidth * 1.02,
                        height: screenHeight * 0.35,
                        fit: BoxFit.cover,
                        placeholderBuilder: (context) => SizedBox(
                          width: screenWidth * 1.02,
                          height: screenHeight * 0.35,
                          child: CustomPaint(
                            painter: FallbackPatternPainter(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main content with exact Figma layout
            Positioned(
              left: 16,
              top: 40,
              child: SizedBox(
                width: screenWidth - 32, // Screen width - 32 (16px padding on each side)
                height: screenHeight - 80, // Screen height - 80 (40px padding on each side)
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),

                    // Welcome section - exact positioning from Figma
                    const Column(
                      children: [
                        Text(
                          'Welcome to Ziya',
                          style: TextStyle(
                            fontFamily: 'Overlock',
                            fontWeight: FontWeight.w700,
                            fontSize: 32,
                            height: 1.22,
                            color: Color(0xFFFFFFFF),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Form container
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Sign in header section
                          Column(
                            children: [
                              const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontFamily: 'Overlock',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  height: 1.22,
                                  color: Color(0xFFFFFFFF),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),

                              // Mobile number input with exact Figma specs
                              _buildMobileNumberInput(),

                              const SizedBox(height: 24),

                              // Send OTP button with exact styling
                              _buildSendOTPButton(),
                            ],
                          ),

                          const SizedBox(height: 32),

                          // Or divider with exact gradient styling
                          _buildOrDivider(),

                          const SizedBox(height: 32),

                          // Social login options with exact spacing
                          _buildSocialLoginOptions(),

                          const Spacer(),

                          // Terms and conditions
                          _buildTermsAndConditions(),
                        ],
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

  Widget _buildMobileNumberInput() {
    return Row(
      children: [
        // Country code container - exact width from Figma
        SizedBox(
          width: 90,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    // Indian flag with exact dimensions
                    SizedBox(
                      width: 30,
                      height: 20,
                      child: SvgPicture.asset(
                        'assets/images/indian_flag.svg',
                        width: 30,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '+91',
                      style: TextStyle(
                        fontFamily: 'Overlock',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.22,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    const Spacer(),
                    // Dropdown icon
                    const SizedBox(
                      width: 8,
                      height: 4.93,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFFFFFFFF),
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom border
              Container(
                height: 1,
                color: const Color(0xFFFFFFFF),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // Mobile number field
        Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: _mobileController,
                  style: const TextStyle(
                    fontFamily: 'Overlock',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.22,
                    color: Color(0xFFFFFFFF),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Mobile Number',
                    hintStyle: TextStyle(
                      fontFamily: 'Overlock',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.22,
                      color: Color(0xFFFFFFFF),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              // Bottom border
              Container(
                height: 1,
                color: const Color(0xFFFFFFFF),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSendOTPButton() {
    return Container(
      height: 48, // Fixed height from Figma
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border.all(
          color: const Color(0xFFFFFFFF),
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Center(
        child: Text(
          'Send OTP',
          style: TextStyle(
            fontFamily: 'Overlock',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.22,
            color: Color(0xFF35A238), // Using primary gradient color
          ),
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        // Left line with gradient
        Expanded(
          child: Container(
            height: 0.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 255, 255, 0),
                  Color.fromRGBO(255, 255, 255, 1),
                ],
              ),
            ),
          ),
        ),

        // "Or" text with exact spacing
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Or',
            style: TextStyle(
              fontFamily: 'Overlock',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.22,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),

        // Right line with gradient
        Expanded(
          child: Container(
            height: 0.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(255, 255, 255, 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSocialButton('google'),
          const SizedBox(width: 24), // Exact spacing from Figma
          _buildSocialButton('facebook'),
          const SizedBox(width: 24), // Exact spacing from Figma
          _buildSocialButton('apple'),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String type) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border.all(
          color: const Color(0xFFFFFFFF),
          width: 0.857142857142857,
        ),
        borderRadius: BorderRadius.circular(42.857142857142857), // 85.714... / 2
      ),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: _getSocialIcon(type),
        ),
      ),
    );
  }

  Widget _getSocialIcon(String type) {
    switch (type) {
      case 'google':
        return SvgPicture.asset(
          'assets/images/google_icon.svg',
          width: 24,
          height: 24,
        );
      case 'facebook':
        return SvgPicture.asset(
          'assets/images/facebook_icon.svg',
          width: 24,
          height: 24,
        );
      case 'apple':
        return SvgPicture.asset(
          'assets/images/apple_icon.svg',
          width: 24,
          height: 24,
        );
      default:
        return Container();
    }
  }

  Widget _buildTermsAndConditions() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        'By logging in or signing up, you agree to our Terms and acknowledge our Privacy Policy, including opt-out details.',
        style: TextStyle(
          fontFamily: 'Overlock',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1.22,
          color: Color(0xFFFFFFFF),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// Fallback pattern painter for when SVG doesn't load
class FallbackPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Create various colored elements based on the Figma design colors
    // Green elements
    paint.color = const Color(0xFF6AD36A);
    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.25), 8, paint);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.65), 12, paint);
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.15), 6, paint);

    // Light green elements
    paint.color = const Color(0xFF78E178);
    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.45), 10, paint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.75), 14, paint);

    // Very light green elements
    paint.color = const Color(0xFFC1F6C1);
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.35), 7, paint);
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.55), 9, paint);

    // Darker green elements
    paint.color = const Color(0xFF269726);
    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.25), 5, paint);
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.45), 8, paint);

    // Add some abstract leaf-like shapes
    paint.color = const Color(0xFF97E397);
    final path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.6);
    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.55,
      size.width * 0.2,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.65,
      size.width * 0.1,
      size.height * 0.6,
    );
    canvas.drawPath(path, paint);

    // More decorative elements scattered around
    paint.color = const Color(0xFFC1E9C1);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.2), 4, paint);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.8), 6, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.1), 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
