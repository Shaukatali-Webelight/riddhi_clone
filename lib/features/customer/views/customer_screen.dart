import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:riddhi_clone/features/customer/controllers/customer_state.dart';
import 'package:riddhi_clone/features/customer/controllers/customer_state_notifier.dart';
import 'package:riddhi_clone/features/customer/models/get_all_customer_data_response_model.dart';
import 'package:riddhi_clone/features/customer/views/customer_details_screen.dart';
import 'package:riddhi_clone/widgets/common/no_data_found_widget.dart';
import 'package:riddhi_clone/widgets/loaders/app_loader.dart';

class CustomerScreen extends ConsumerStatefulWidget {
  const CustomerScreen({super.key});

  @override
  ConsumerState<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends ConsumerState<CustomerScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(customerStateNotifierProvider.notifier).getAllCustomerData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customerState = ref.watch(customerStateNotifierProvider);
    final customerNotifier = ref.watch(customerStateNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Customers',
          style: TextStyle(
            color: Color(0xFF242424),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Heebo',
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchSection(customerState),
          Expanded(
            child: _buildBody(customerState, customerNotifier),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection(CustomerState customerState) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFBCBCBC), width: 0.5),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      Icons.search,
                      color: Color(0xFF39B26F),
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF242424),
                        fontFamily: 'Heebo',
                      ),
                      decoration: InputDecoration(
                        hintText: '${customerState.allCustomerDataItems.length} Customers',
                        hintStyle: const TextStyle(
                          color: Color(0xFF797979),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Heebo',
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) {
                        // TODO: Implement search functionality
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFBCBCBC), width: 0.5),
            ),
            child: const Center(
              child: Icon(
                Icons.tune,
                color: Color(0xFF39B26F),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(CustomerState customerState, CustomerStateNotifier customerNotifier) {
    if (customerState.isLoading && customerState.allCustomerDataItems.isEmpty) {
      return const AppLoader();
    }

    if (customerState.hasError && customerState.allCustomerDataItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              customerState.errorMessage ?? 'Something went wrong',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => customerNotifier.getAllCustomerData(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF39B26F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (customerState.allCustomerDataItems.isEmpty) {
      return const NoDataFoundWidget(message: 'No customers found');
    }

    return SmartRefresher(
      controller: customerNotifier.getAllCustomerDataRefreshController,
      enablePullUp: customerState.hasMoreData,
      onRefresh: () => customerNotifier.refreshAllCustomerData(),
      onLoading: () => customerNotifier.loadMoreAllCustomerData(),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
        itemCount: customerState.allCustomerDataItems.length,
        itemBuilder: (context, index) {
          final customer = customerState.allCustomerDataItems[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildCustomerCard(customer),
          );
        },
      ),
    );
  }

  Widget _buildCustomerCard(GetAllCustomerDataItem customer) {
    return Container(
      width: 336,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFBCBCBC), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFBCBCBC),
                  width: 0.5,
                ),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                // ID and Date Section
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        customer.id ?? '12345678',
                        style: const TextStyle(
                          color: Color(0xFF242424),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Heebo',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Color(0xFFBCBCBC),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(customer.createdAt),
                        style: const TextStyle(
                          color: Color(0xFF242424),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Heebo',
                        ),
                      ),
                    ],
                  ),
                ),
                // Top Right Actions
                Row(
                  children: [
                    // User Icon - exact size from Figma (6.5 x 12)
                    SizedBox(
                      width: 6.5,
                      height: 12,
                      child: CustomPaint(
                        painter: UserIconPainter(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Refresh Icon - exact size from Figma (18 x 18)
                    const Icon(
                      Icons.refresh,
                      color: Color(0xFF39B26F),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    // License Icon - exact size from Figma (18 x 18)
                    const Icon(
                      Icons.badge_outlined,
                      color: Color(0xFF39B26F),
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Body Section - exact padding from Figma
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Customer Name - exact padding from Figma
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    customer.customerName ?? 'A. R. ENTERPRICES',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF242424),
                      fontFamily: 'Heebo',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Actions Row - exact padding from Figma
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      // Left Action Icons
                      Expanded(
                        child: Row(
                          children: [
                            _buildActionButton(Icons.call, () => _makePhoneCall(customer.mobileNo)),
                            const SizedBox(width: 8),
                            _buildActionButton(Icons.email, () => _sendEmail(customer.email)),
                            const SizedBox(width: 8),
                            _buildActionButton(
                              Icons.chat,
                              () => _sendWhatsApp(customer.whatsappNo ?? customer.mobileNo),
                            ),
                            const SizedBox(width: 8),
                            _buildActionButton(Icons.location_on, () => _openLocation(customer.lat, customer.long)),
                            const SizedBox(width: 8),
                            _buildActionButton(Icons.group, () => _viewCustomerDetails(customer)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Right Arrow Button - Fixed to point right with exact size
                      GestureDetector(
                        onTap: () => _viewCustomerDetails(customer),
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Color(0xFF39B26F),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
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
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Icon(
            icon,
            color: const Color(0xFF797979),
            size: 18,
          ),
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return '01/01/2015';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return '01/01/2015';
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

  void _openLocation(String? lat, String? lng) {
    if (lat != null && lng != null) {
      // TODO: Implement location functionality
      print('Opening location: $lat, $lng');
    }
  }

  void _viewCustomerDetails(GetAllCustomerDataItem customer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerDetailsScreen(customer: customer),
      ),
    );
  }
}

// Custom painter for the user icon to match exact Figma dimensions (6.5 x 12)
class UserIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF39B26F)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw user icon outline matching Figma design
    const width = 6.5;
    const height = 12;

    // Head (circle)
    canvas.drawCircle(
      const Offset(width / 2, height * 0.25),
      width * 0.15,
      paint,
    );

    // Body (arc)
    const rect = Rect.fromLTWH(0, height * 0.5, width, height * 0.5);
    canvas.drawArc(rect, -3.14159, 3.14159, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
