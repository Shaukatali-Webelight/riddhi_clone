import 'package:flutter/material.dart';

class CarIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDBD7D5).withOpacity(0.72)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw car outline - simplified version matching the screenshot
    final path = Path();

    // Left car outline
    const leftCarRect = Rect.fromLTWH(40, 20, 45, 100);
    canvas.drawRect(leftCarRect, paint);

    // Center car details
    const centerCarRect = Rect.fromLTWH(90, 50, 140, 40);
    canvas.drawRect(centerCarRect, paint);

    // Draw car details inside center
    final detailPaint = Paint()
      ..color = const Color(0xFFDBD7D5).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // Small car detail elements
    for (var i = 0; i < 4; i++) {
      canvas.drawCircle(
        Offset(110 + (i * 25), 70),
        3,
        detailPaint,
      );
    }

    // Right car outline
    const rightCarRect = Rect.fromLTWH(235, 20, 45, 100);
    canvas.drawRect(rightCarRect, paint);

    // Draw connecting lines
    canvas.drawLine(
      const Offset(0, 125),
      Offset(size.width, 125),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class FormCarIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF0ECE9)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = const Color(0xFFF0ECE9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw car body
    final carBody = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 40,
        height: 20,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(carBody, strokePaint);

    // Draw car roof
    final carRoof = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2 - 6),
        width: 24,
        height: 8,
      ),
      const Radius.circular(2),
    );
    canvas.drawRRect(carRoof, strokePaint);

    // Draw wheels
    canvas.drawCircle(
      Offset(size.width / 2 - 12, size.height / 2 + 8),
      3,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width / 2 + 12, size.height / 2 + 8),
      3,
      paint,
    );

    // Draw headlights
    canvas.drawCircle(
      Offset(size.width / 2 + 18, size.height / 2),
      2,
      paint,
    );

    // Draw small details
    for (var i = 0; i < 3; i++) {
      canvas.drawCircle(
        Offset(size.width / 2 - 8 + (i * 4), size.height / 2 - 10),
        1,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SafarrLoginScreen extends StatefulWidget {
  const SafarrLoginScreen({super.key});

  @override
  State<SafarrLoginScreen> createState() => _SafarrLoginScreenState();
}

class _SafarrLoginScreenState extends State<SafarrLoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  bool acceptTerms = false;
  bool isEnglish = true;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: SizedBox(
        width: 360,
        height: 800,
        child: Column(
          children: [
            // Top section with status bar and logo
            _buildTopSection(),

            // Car illustration
            _buildCarIllustration(),

            // Bottom section with form and button
            Expanded(
              child: _buildBottomSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 24),
      child: Center(
        child: _buildLogoWidget(),
      ),
    );
  }

  Widget _buildCarIllustration() {
    return Container(
      width: 320,
      height: 140,
      margin: const EdgeInsets.only(top: 32),
      child: CustomPaint(
        painter: CarIllustrationPainter(),
        child: Container(),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
      child: Column(
        children: [
          // Main glass container
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 0.75,
                      color: const Color(0xFFF0ECE9).withOpacity(0.7),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFF0ECE9).withOpacity(0.2),
                        const Color(0xFFF0ECE9).withOpacity(0),
                      ],
                      stops: const [0.0, 0.85],
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                    child: Column(
                      children: [
                        _buildFormHeader(),
                        const SizedBox(height: 24),
                        _buildFormContent(),
                      ],
                    ),
                  ),
                ),

                // Language switch
                _buildLanguageSwitch(),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Hit The Road button
          _buildHitTheRoadButton(),
        ],
      ),
    );
  }

  Widget _buildFormHeader() {
    return Column(
      children: [
        // Car icon
        SizedBox(
          width: 72,
          height: 72,
          child: CustomPaint(
            painter: FormCarIconPainter(),
            child: Container(),
          ),
        ),

        const SizedBox(height: 12),

        // Start your journey text
        const Text(
          'Start Your Journey',
          style: TextStyle(
            color: Color(0xFFF0ECE9),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Outfit',
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFormContent() {
    return SizedBox(
      width: 288,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enter phone number label
          const Text(
            'Enter your phone number',
            style: TextStyle(
              color: Color(0xFFF0ECE9),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Outfit',
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 8),

          // Phone input row
          Row(
            children: [
              // Country code container
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 20, 16),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFF0ECE9)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Indian flag placeholder
                    Container(
                      width: 18,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.125),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF9933), Color(0xFFFFFFFF), Color(0xFF138808)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),

                    const SizedBox(width: 4),

                    const Text(
                      '+91',
                      style: TextStyle(
                        color: Color(0xFFF0ECE9),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Phone number input
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFF0ECE9)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: phoneController,
                    style: const TextStyle(
                      color: Color(0xFFF0ECE9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Outfit',
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: '91919 91919',
                      hintStyle: TextStyle(
                        color: Color(0xFFF0ECE9),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Terms and checkbox row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox
              GestureDetector(
                onTap: () {
                  setState(() {
                    acceptTerms = !acceptTerms;
                  });
                },
                child: Container(
                  width: 12.5,
                  height: 12.5,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFF0ECE9).withOpacity(0.72),
                      width: 1.04,
                    ),
                    borderRadius: BorderRadius.circular(1.39),
                  ),
                  child: acceptTerms
                      ? const Icon(
                          Icons.check,
                          size: 8,
                          color: Color(0xFFF0ECE9),
                        )
                      : null,
                ),
              ),

              const SizedBox(width: 8),

              // Terms text
              const Expanded(
                child: Text(
                  'I accept the Terms & Conditions and Privacy Policy',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHitTheRoadButton() {
    return Container(
      width: 296,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFFAEB50),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            // Handle button tap
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 16, 8, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hit The Road',
                  style: TextStyle(
                    color: Color(0xFF292929),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Outfit',
                    letterSpacing: 0.1,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF292929),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.directions_car,
                    color: Color(0xFFFAEB50),
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

  Widget _buildLanguageSwitch() {
    return Positioned(
      right: 20,
      top: 16,
      child: Container(
        height: 24,
        padding: const EdgeInsets.fromLTRB(2, 2, 4, 2),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFF0ECE9)),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFFF0ECE9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: CircleAvatar(
                  radius: 1.27,
                  backgroundColor: Color(0xFF292929),
                ),
              ),
            ),
            const SizedBox(width: 2),
            const SizedBox(
              width: 20,
              child: Text(
                'EN',
                style: TextStyle(
                  color: Color(0xFFF0ECE9),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Outfit',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widgets

  Widget _buildLogoWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo icon
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFF0ECE9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Icon(
              Icons.directions_car,
              color: Color(0xFF292929),
              size: 18,
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Safarr text
        const Text(
          'safarr',
          style: TextStyle(
            color: Color(0xFFF0ECE9),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildCarDetailIcon() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: const Color(0xFFDBD7D5).withOpacity(0.72),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}
