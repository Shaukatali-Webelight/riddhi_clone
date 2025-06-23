import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String _selectedGender = 'Male';

  @override
  void dispose() {
    _usernameController.dispose();
    _dobController.dispose();
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF35A238),
              Color(0xFF0E5C49),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background decorative pattern - responsive
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                width: screenWidth,
                height: screenHeight * 0.55,
                child: Stack(
                  children: [
                    // Star pattern with exact opacity from Figma
                    Opacity(
                      opacity: 0.54,
                      child: SizedBox(
                        width: screenWidth,
                        height: screenHeight * 0.55,
                        child: CustomPaint(
                          painter: StarPatternPainter(),
                          size: Size(screenWidth, screenHeight * 0.55),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main Body Container - responsive
            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                children: [
                  // Body section with exact padding
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
                      child: Column(
                        children: [
                          // Title section - centered as per Figma
                          const Column(
                            children: [
                              Text(
                                'Complete Your Profile',
                                style: TextStyle(
                                  fontFamily: 'Overlock',
                                  fontFamilyFallback: ['Inter', 'Roboto', 'Arial'],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  height: 1.22,
                                  color: Color(0xFFFFFFFF),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Your mobile number +91 9287645367',
                                style: TextStyle(
                                  fontFamily: 'Overlock',
                                  fontFamilyFallback: ['Inter', 'Roboto', 'Arial'],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  height: 1.22,
                                  color: Color(0xFFFFFFFF),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),

                          const SizedBox(height: 40),

                          // Form section - fills remaining space
                          Expanded(
                            child: Column(
                              children: [
                                // Username field
                                _buildUsernameField(),

                                const SizedBox(height: 24),

                                // Date of Birth field
                                _buildDOBField(),

                                const SizedBox(height: 24),

                                // Gender selection
                                _buildGenderSelection(),

                                // Spacer to push buttons to bottom
                                const Spacer(),

                                // Button section with exact spacing
                                Column(
                                  children: [
                                    const SizedBox(height: 14),

                                    // Continue button - properly aligned
                                    SizedBox(
                                      width: double.infinity,
                                      height: 48,
                                      child: ElevatedButton(
                                        onPressed: _handleContinue,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFFFFFFFF),
                                          foregroundColor: const Color(0xFF35A238),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100),
                                            side: const BorderSide(
                                              color: Color(0xFFFFFFFF),
                                            ),
                                          ),
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: const Text(
                                          'Continue',
                                          style: TextStyle(
                                            fontFamily: 'Overlock',
                                            fontFamilyFallback: ['Inter', 'Roboto', 'Arial'],
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            height: 1.22,
                                            color: Color(0xFF35A238),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    // Back button - exact positioning from Figma
                                    InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Icon(
                                              Icons.arrow_back,
                                              color: Color(0xFFFFFFFF),
                                              size: 16,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Back',
                                            style: TextStyle(
                                              fontFamily: 'Overlock',
                                              fontFamilyFallback: ['Inter', 'Roboto', 'Arial'],
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              height: 1.22,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Username *',
          style: TextStyle(
            fontFamily: 'Overlock',
            fontFamilyFallback: ['Inter', 'Roboto', 'Arial'],
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.22,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          child: TextFormField(
            controller: _usernameController,
            style: const TextStyle(
              fontFamily: 'Overlock',
              fontFamilyFallback: ['Inter', 'Roboto', 'Arial'],
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.22,
              color: Color(0xFFFFFFFF),
            ),
            decoration: InputDecoration(
              hintText: 'Jonathan',
              hintStyle: TextStyle(
                fontFamily: 'Overlock',
                fontFamilyFallback: const ['Inter', 'Roboto', 'Arial'],
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.22,
                color: const Color(0xFFFFFFFF).withOpacity(0.7),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(bottom: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDOBField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'DOB',
          style: TextStyle(
            fontFamily: 'Overlock',
            fontFamilyFallback: ['Inter', 'Roboto', 'Arial'],
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.22,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _dobController,
                  readOnly: true,
                  onTap: _selectDate,
                  style: const TextStyle(
                    fontFamily: 'Overlock',
                    fontFamilyFallback: ['Inter', 'Roboto', 'Arial'],
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.22,
                    color: Color(0xFFFFFFFF),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Select',
                    hintStyle: TextStyle(
                      fontFamily: 'Overlock',
                      fontFamilyFallback: const ['Inter', 'Roboto', 'Arial'],
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.22,
                      color: const Color(0xFFFFFFFF).withOpacity(0.7),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(bottom: 16),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Calendar icon - exact size and positioning from Figma
              const SizedBox(
                width: 20,
                height: 20,
                child: Icon(
                  Icons.calendar_month,
                  color: Color(0xFFFFFFFF),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(
            fontFamily: 'Overlock',
            fontFamilyFallback: ['Inter', 'Roboto', 'Arial'],
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.22,
            color: Color(0xFFFFFFFF),
          ),
        ),

        const SizedBox(height: 12),

        // Options with exact spacing and wrapping as per Figma
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildGenderOption('Male'),
            _buildGenderOption('Female'),
            _buildGenderOption('Other'),
            _buildGenderOption('Prefer not to say'),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption(String gender) {
    final isSelected = _selectedGender == gender;

    return SizedBox(
      width: 158, // Exact width from Figma
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedGender = gender;
          });
        },
        child: Row(
          children: [
            // Radio button with exact size from Figma
            SizedBox(
              width: 18,
              height: 18,
              child: Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: const Color(0xFFFFFFFF),
                size: 18,
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                gender,
                style: const TextStyle(
                  fontFamily: 'Overlock',
                  fontFamilyFallback: ['Inter', 'Roboto', 'Arial'],
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.22,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF35A238),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dobController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  void _handleContinue() {
    // Add validation logic here
    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a username'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Navigate to next screen or handle form submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile completed successfully!'),
        backgroundColor: Color(0xFF35A238),
      ),
    );
  }
}

// Custom painter for the star pattern background
class StarPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Create various colored star elements based on the Figma design
    // Light white/transparent stars
    paint.color = const Color(0x00FFFFFF); // rgba(255, 255, 255, 0)
    _drawStars(
      canvas,
      size,
      paint,
      [
        const Offset(307.75, 354.59),
        const Offset(192.96, 129.64),
        const Offset(206.54, 230.87),
        const Offset(80.63, 113.07),
        const Offset(426.33, 493.11),
        const Offset(280.25, 377.09),
      ],
      1.4,
    );

    // Semi-transparent white stars
    paint.color = const Color(0x66FFFFFF); // rgba(255, 255, 255, 0.4)
    _drawStars(
      canvas,
      size,
      paint,
      [
        const Offset(781.79, 459.37),
        const Offset(551.91, 280),
        const Offset(618.66, 303.68),
        const Offset(799.48, 234.42),
        const Offset(622.84, 243.3),
        const Offset(617.21, 507.32),
      ],
      1.54,
    );

    // Medium opacity white stars
    paint.color = const Color(0x4DFFFFFF); // rgba(255, 255, 255, 0.3)
    _drawStars(
      canvas,
      size,
      paint,
      [
        const Offset(185.12, 459.37),
        const Offset(77.64, 75.18),
        const Offset(225.14, 11.84),
        const Offset(475.88, 414.97),
        const Offset(200.5, 415.57),
        const Offset(606.47, 458.78),
      ],
      1.49,
    );
  }

  void _drawStars(Canvas canvas, Size size, Paint paint, List<Offset> positions, double radius) {
    for (final position in positions) {
      // Only draw stars that are within the container bounds
      if (position.dx < size.width && position.dy < size.height && position.dx >= 0 && position.dy >= 0) {
        canvas.drawCircle(position, radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
