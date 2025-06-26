import 'package:flutter/material.dart';
import 'package:riddhi_clone/features/checklist/views/check_list_screen.dart';
import 'package:riddhi_clone/features/customer/models/get_all_customer_data_response_model.dart';

class CustomerDetailsScreen extends StatefulWidget {
  const CustomerDetailsScreen({
    required this.customer,
    super.key,
  });
  final GetAllCustomerDataItem customer;

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  bool _isNoteExpanded = false;
  bool _isMeetingsExpanded = false;
  bool _isProductsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Column(
            children: [
              // Header
              _buildHeader(),
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildBasicInfoSection(),
                      const SizedBox(height: 12), // Gap to show background
                      _buildOtherSection(),
                      const SizedBox(height: 80), // Bottom spacing for floating button
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Floating Action Button
          _buildFloatingActionButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return ColoredBox(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFBCBCBC),
                width: 0.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.14),
                blurRadius: 4,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4).copyWith(bottom: 12),
          child: Row(
            children: [
              // Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF242424),
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Title
              Expanded(
                child: Text(
                  widget.customer.customerName ?? 'A. R. ENTERPRICES',
                  style: const TextStyle(
                    fontFamily: 'Heebo',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    height: 1.46875,
                    color: Color(0xFF242424),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 36), // Space for visual balance
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFBCBCBC),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ID & Date Row
          Row(
            children: [
              Text(
                widget.customer.id ?? '12345678',
                style: const TextStyle(
                  fontFamily: 'Heebo',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.46875,
                  color: Color(0xFF242424),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _formatDate(widget.customer.createdAt) ?? '01/01/2015',
                style: const TextStyle(
                  fontFamily: 'Heebo',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.46875,
                  color: Color(0xFF242424),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Address
          Text(
            widget.customer.address ?? '21 MG Road, Near City Mall, Andheri East, Mumbai, Maharashtra, 400069, India',
            style: const TextStyle(
              fontFamily: 'Heebo',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.46875,
              color: Color(0xFF242424),
            ),
          ),
          const SizedBox(height: 12),

          // Call & Contact Icons
          Row(
            children: [
              _buildContactIcon(
                Icons.call,
                const Color(0xFF39B26F),
                () => _makePhoneCall(widget.customer.mobileNo),
              ),
              const SizedBox(width: 12),
              _buildContactIcon(
                Icons.mail,
                const Color(0xFF797979),
                () => _sendEmail(widget.customer.email),
              ),
              const SizedBox(width: 12),
              _buildContactIcon(
                Icons.chat,
                const Color(0xFF39B26F),
                () => _sendWhatsApp(widget.customer.whatsappNo ?? widget.customer.mobileNo),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactIcon(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildOtherSection() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Chart Section
          _buildChartSection(),
          const SizedBox(height: 12),
          // Stats Section
          _buildStatsSection(),
          const SizedBox(height: 12),
          // Expandable Sections
          _buildExpandableSection(
            'Note',
            _isNoteExpanded,
            () => setState(() => _isNoteExpanded = !_isNoteExpanded),
            _isNoteExpanded ? _buildNoteContent() : null,
          ),
          const SizedBox(height: 12),
          _buildExpandableSection(
            'Last 5 Meetings',
            _isMeetingsExpanded,
            () => setState(() => _isMeetingsExpanded = !_isMeetingsExpanded),
            _isMeetingsExpanded ? _buildMeetingsContent() : null,
          ),
          const SizedBox(height: 12),
          _buildExpandableSection(
            'Products',
            _isProductsExpanded,
            () => setState(() => _isProductsExpanded = !_isProductsExpanded),
            _isProductsExpanded ? _buildProductsContent() : null,
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.14),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Chart Area
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circle Chart
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    children: [
                      // Background Circle
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFBCBCBC),
                            width: 6,
                          ),
                        ),
                      ),
                      // Progress Circle (35% filled)
                      const SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: 0.35,
                          strokeWidth: 6,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF39B26F)),
                        ),
                      ),
                      // Center Content
                      const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '35%',
                              style: TextStyle(
                                fontFamily: 'Heebo',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color(0xFF39B26F),
                              ),
                            ),
                            Text(
                              '65%',
                              style: TextStyle(
                                fontFamily: 'Heebo',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xFF797979),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6.67),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(const Color(0xFF39B26F), 'RSP'),
              const SizedBox(width: 12),
              _buildLegendItem(const Color(0xFFBCBCBC), 'ABP'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Heebo',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 1.46875,
            color: Color(0xFF797979),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFBCBCBC),
          width: 0.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.14),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          // Row 1: Sales CY | Sales Return CY | Credit Limit
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Sales CY',
                  '₹1,00,000',
                  hasRightBorder: true,
                ),
              ),
              Expanded(
                child: _buildStatCard(
                  'Sales Return CY',
                  '₹1,00,000',
                  hasRightBorder: true,
                ),
              ),
              Expanded(
                child: _buildStatCard(
                  'Credit Limit',
                  '₹50,00,000',
                ),
              ),
            ],
          ),
          // Border between rows
          Container(
            height: 0.5,
            color: const Color(0xFFBCBCBC),
          ),
          // Row 2: Collection | Outstanding | Risk Category
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Collection',
                  '₹1,00,000',
                  hasRightBorder: true,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const CheckListScreen(),
                    ),
                  ),
                  child: _buildStatCard(
                    'Outstanding',
                    '₹1,00,000',
                    hasRightBorder: true,
                  ),
                ),
              ),
              Expanded(
                child: _buildStatCard(
                  'Risk Category',
                  'New',
                  valueColor: const Color(0xFF39B26F),
                ),
              ),
            ],
          ),
          // Border between rows
          Container(
            height: 0.5,
            color: const Color(0xFFBCBCBC),
          ),
          // Row 3: Sales | Last Year Same Month Sales | Empty
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Sales',
                  '₹1,00,000',
                  hasRightBorder: true,
                ),
              ),
              Expanded(
                child: _buildStatCard(
                  'Last Year Same Month Sales',
                  '₹1,00,000',
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value, {
    bool hasRightBorder = false,
    Color valueColor = const Color(0xFF242424),
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: hasRightBorder
            ? const Border(
                right: BorderSide(
                  color: Color(0xFFBCBCBC),
                  width: 0.5,
                ),
              )
            : null,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Heebo',
              fontWeight: FontWeight.w400,
              fontSize: 11,
              height: 1.46875,
              color: Color(0xFF797979),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Heebo',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              height: 1.46875,
              color: valueColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(String title, bool isExpanded, VoidCallback onTap, Widget? content) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFBCBCBC),
          width: 0.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.14),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Heebo',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 1.46875,
                      color: Color(0xFF242424),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: const Color(0xFF39B26F),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (content != null) content,
        ],
      ),
    );
  }

  Widget _buildNoteContent() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: const Text(
        'No notes available for this customer.',
        style: TextStyle(
          fontFamily: 'Heebo',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xFF797979),
        ),
      ),
    );
  }

  Widget _buildMeetingsContent() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: const Text(
        'No recent meetings found.',
        style: TextStyle(
          fontFamily: 'Heebo',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xFF797979),
        ),
      ),
    );
  }

  Widget _buildProductsContent() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: const Text(
        'No products assigned to this customer.',
        style: TextStyle(
          fontFamily: 'Heebo',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xFF797979),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Positioned(
      right: 14,
      bottom: 48,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: const Color(0xFF39B26F),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 21,
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  void _makePhoneCall(String? phoneNumber) {
    if (phoneNumber != null) {
      // TODO: Implement phone call functionality
      print('Calling: $phoneNumber');
    }
  }

  void _sendEmail(String? email) {
    if (email != null && email.isNotEmpty) {
      // TODO: Implement email functionality
      print('Sending email to: $email');
    }
  }

  void _sendWhatsApp(String? phoneNumber) {
    if (phoneNumber != null) {
      // TODO: Implement WhatsApp functionality
      print('WhatsApp: $phoneNumber');
    }
  }
}
