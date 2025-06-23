import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riddhi_clone/features/customer/controllers/customer_state_notifier.dart';
import 'package:riddhi_clone/features/customer/models/get_all_customer_data_response_model.dart';
import 'package:riddhi_clone/features/customer/models/get_customer_outstanding_response_model.dart';
import 'package:riddhi_clone/widgets/loaders/app_loader.dart';

class OutstandingDetailsScreen extends ConsumerStatefulWidget {
  const OutstandingDetailsScreen({
    required this.customer,
    super.key,
  });
  final GetAllCustomerDataItem customer;

  @override
  ConsumerState<OutstandingDetailsScreen> createState() => _OutstandingDetailsScreenState();
}

class _OutstandingDetailsScreenState extends ConsumerState<OutstandingDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadOutstandingData();
    });
  }

  void _loadOutstandingData() {
    final customerId = widget.customer.id ?? '';
    if (customerId.isNotEmpty) {
      ref.read(customerStateNotifierProvider.notifier).getCustomerOutstanding(
            customerId: customerId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final customerState = ref.watch(customerStateNotifierProvider);
    final isLoading = customerState.isLoadingOutstanding;
    final hasError = customerState.hasOutstandingError;
    final outstandingData = customerState.customerOutstandingData;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.14),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF242424),
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Outstanding',
          style: TextStyle(
            fontFamily: 'Heebo',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            height: 1.46875,
            color: Color(0xFF242424),
          ),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Divider(
            height: 0.5,
            thickness: 0.5,
            color: Color(0xFFBCBCBC),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: AppLoader())
          : hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        customerState.outstandingErrorMessage ?? 'Failed to load outstanding data',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Heebo',
                          fontSize: 16,
                          color: Color(0xFF797979),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadOutstandingData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      // State Section
                      _buildStateSection(outstandingData),
                      const SizedBox(height: 12),

                      // Not Due Section
                      _buildNotDueSection(outstandingData),
                      const SizedBox(height: 12),

                      // Due Section
                      _buildDueSection(outstandingData),
                      const SizedBox(height: 20), // Bottom spacing
                    ],
                  ),
                ),
    );
  }

  Widget _buildStateSection(GetCustomerOutstandingData? data) {
    final unadjustedAmount = data?.unadjustedAmount ?? 0.0;
    final totalOutstanding = data?.totalOutstanding ?? 0.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFBCBCBC),
          width: 0.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: _buildStateCard(
              'Unadjusted Amount',
              '₹${_formatAmount(unadjustedAmount)}',
              hasRightBorder: true,
            ),
          ),
          Expanded(
            child: _buildStateCard(
              'Total Outstanding',
              '₹${_formatAmount(totalOutstanding)}',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateCard(String title, String value, {bool hasRightBorder = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
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
            style: const TextStyle(
              fontFamily: 'Heebo',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              height: 1.46875,
              color: Color(0xFF242424),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotDueSection(GetCustomerOutstandingData? data) {
    final outstandingDetail = data?.outstandingData;
    final totalNonDue = outstandingDetail?.totalNonDue ?? 0.0;

    // Calculate max value for proper chart scaling
    final values = [
      outstandingDetail?.nonDue0To30 ?? 0.0,
      outstandingDetail?.nonDue31To60 ?? 0.0,
      outstandingDetail?.nonDue61To90 ?? 0.0,
      outstandingDetail?.nonDue91To120 ?? 0.0,
      outstandingDetail?.nonDue121To150 ?? 0.0,
      outstandingDetail?.nonDue151To180 ?? 0.0,
      outstandingDetail?.nonDue181To360 ?? 0.0,
      outstandingDetail?.nonDue361To999 ?? 0.0,
    ];
    final maxValue = values.fold<double>(0, (a, b) => a > b ? a : b);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFBCBCBC),
          width: 0.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Not Due',
                style: TextStyle(
                  fontFamily: 'Heebo',
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  height: 1.46875,
                  color: Color(0xFF797979),
                ),
              ),
              Text(
                '₹${_formatAmount(totalNonDue)}',
                style: const TextStyle(
                  fontFamily: 'Heebo',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 1.46875,
                  color: Color(0xFF242424),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Chart Section
          _buildBarChart(
            [
              BarData(
                '0-30',
                '₹${_formatAmount(outstandingDetail?.nonDue0To30 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.nonDue0To30 ?? 0.0, maxValue),
              ),
              BarData(
                '31-60',
                '₹${_formatAmount(outstandingDetail?.nonDue31To60 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.nonDue31To60 ?? 0.0, maxValue),
              ),
              BarData(
                '61-90',
                '₹${_formatAmount(outstandingDetail?.nonDue61To90 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.nonDue61To90 ?? 0.0, maxValue),
              ),
              BarData(
                '90-120',
                '₹${_formatAmount(outstandingDetail?.nonDue91To120 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.nonDue91To120 ?? 0.0, maxValue),
              ),
              BarData(
                '121-150',
                '₹${_formatAmount(outstandingDetail?.nonDue121To150 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.nonDue121To150 ?? 0.0, maxValue),
              ),
              BarData(
                '151-180',
                '₹${_formatAmount(outstandingDetail?.nonDue151To180 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.nonDue151To180 ?? 0.0, maxValue),
              ),
              BarData(
                '181-360',
                '₹${_formatAmount(outstandingDetail?.nonDue181To360 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.nonDue181To360 ?? 0.0, maxValue),
              ),
              BarData(
                '360+',
                '₹${_formatAmount(outstandingDetail?.nonDue361To999 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.nonDue361To999 ?? 0.0, maxValue),
              ),
            ],
            const Color(0xFF39B26F),
          ),
        ],
      ),
    );
  }

  Widget _buildDueSection(GetCustomerOutstandingData? data) {
    final outstandingDetail = data?.outstandingData;
    final totalDue = outstandingDetail?.totalDue ?? 0.0;

    // Calculate max value for proper chart scaling
    final values = [
      outstandingDetail?.due0To30 ?? 0.0,
      outstandingDetail?.due31To60 ?? 0.0,
      outstandingDetail?.due61To90 ?? 0.0,
      outstandingDetail?.due91To120 ?? 0.0,
      outstandingDetail?.due121To150 ?? 0.0,
      outstandingDetail?.due151To180 ?? 0.0,
      outstandingDetail?.due181To360 ?? 0.0,
      outstandingDetail?.due361To999 ?? 0.0,
    ];
    final maxValue = values.fold<double>(0, (a, b) => a > b ? a : b);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFBCBCBC),
          width: 0.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Due',
                style: TextStyle(
                  fontFamily: 'Heebo',
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  height: 1.46875,
                  color: Color(0xFF797979),
                ),
              ),
              Text(
                '₹${_formatAmount(totalDue)}',
                style: const TextStyle(
                  fontFamily: 'Heebo',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 1.46875,
                  color: Color(0xFF242424),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Chart Section
          _buildBarChart(
            [
              BarData(
                '0-30',
                '₹${_formatAmount(outstandingDetail?.due0To30 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.due0To30 ?? 0.0, maxValue),
                textColor: const Color(0xFFFACA15),
              ),
              BarData(
                '31-60',
                '₹${_formatAmount(outstandingDetail?.due31To60 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.due31To60 ?? 0.0, maxValue),
                textColor: const Color(0xFFE02424),
              ),
              BarData(
                '61-90',
                '₹${_formatAmount(outstandingDetail?.due61To90 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.due61To90 ?? 0.0, maxValue),
                textColor: const Color(0xFFE02424),
              ),
              BarData(
                '90-120',
                '₹${_formatAmount(outstandingDetail?.due91To120 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.due91To120 ?? 0.0, maxValue),
                textColor: const Color(0xFFE02424),
              ),
              BarData(
                '121-150',
                '₹${_formatAmount(outstandingDetail?.due121To150 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.due121To150 ?? 0.0, maxValue),
                textColor: const Color(0xFFE02424),
              ),
              BarData(
                '151-180',
                '₹${_formatAmount(outstandingDetail?.due151To180 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.due151To180 ?? 0.0, maxValue),
                textColor: const Color(0xFFE02424),
              ),
              BarData(
                '181-360',
                '₹${_formatAmount(outstandingDetail?.due181To360 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.due181To360 ?? 0.0, maxValue),
                textColor: const Color(0xFFE02424),
              ),
              BarData(
                '360+',
                '₹${_formatAmount(outstandingDetail?.due361To999 ?? 0.0)}',
                _calculateBarHeight(outstandingDetail?.due361To999 ?? 0.0, maxValue),
                textColor: const Color(0xFFE02424),
              ),
            ],
            const Color(0xFFBCBCBC),
          ),

          const SizedBox(height: 4),

          // Range indicators
          _buildRangeIndicators(outstandingDetail),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<BarData> data, Color barColor) {
    return Column(
      children: [
        // Bars with values
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFBCBCBC),
              ),
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: index > 0 ? 6 : 0, // 12px gap divided by 2
                      right: index < data.length - 1 ? 6 : 0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Value text
                        Text(
                          item.value,
                          style: TextStyle(
                            fontFamily: 'Heebo',
                            fontWeight: FontWeight.w400,
                            fontSize: 8,
                            height: 1.46875,
                            color: item.textColor ?? (item.height > 0 ? const Color(0xFF242424) : barColor),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        // Bar
                        Container(
                          height: item.height,
                          decoration: BoxDecoration(
                            color: item.height > 0 ? barColor : const Color(0xFFBCBCBC),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 4),

        // Labels
        Row(
          children: data.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: index > 0 ? 6 : 0, // 12px gap divided by 2
                  right: index < data.length - 1 ? 6 : 0,
                ),
                child: Text(
                  item.label,
                  style: const TextStyle(
                    fontFamily: 'Heebo',
                    fontWeight: FontWeight.w400,
                    fontSize: 8,
                    height: 1.46875,
                    color: Color(0xFF242424),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRangeIndicators(OutstandingDataDetail? data) {
    final yellowAmount = data?.due0To30 ?? 0.0;
    final redAmounts = [
      data?.due31To60 ?? 0.0,
      data?.due61To90 ?? 0.0,
      data?.due91To120 ?? 0.0,
      data?.due121To150 ?? 0.0,
      data?.due151To180 ?? 0.0,
      data?.due181To360 ?? 0.0,
      data?.due361To999 ?? 0.0,
    ];
    final redTotal = redAmounts.fold<double>(0, (a, b) => a + b);

    return Row(
      children: [
        // Yellow range indicator with exact width 28.5
        SizedBox(
          width: 28.5,
          child: Column(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFFACA15),
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(1),
                    bottomLeft: Radius.circular(1),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 6,
                color: const Color(0xFFFACA15),
              ),
              const SizedBox(height: 2),
              Text(
                '₹${_formatAmount(yellowAmount)}',
                style: const TextStyle(
                  fontFamily: 'Heebo',
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  height: 1.46875,
                  color: Color(0xFF242424),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12), // 12px gap
        // Red range indicator - fills remaining space
        Expanded(
          child: Column(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFE02424),
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(1),
                    bottomLeft: Radius.circular(1),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 6,
                color: const Color(0xFFE02424),
              ),
              const SizedBox(height: 2),
              Text(
                '₹${_formatAmount(redTotal)}',
                style: const TextStyle(
                  fontFamily: 'Heebo',
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  height: 1.46875,
                  color: Color(0xFF242424),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatAmount(double amount) {
    if (amount == 0) return '0';
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(1)}Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }

  double _calculateBarHeight(double value, double maxValue) {
    if (maxValue == 0) return 0;
    const maxBarHeight = 100.0;
    const minBarHeight = 5.0;
    final ratio = value / maxValue;
    return value > 0 ? (ratio * maxBarHeight).clamp(minBarHeight, maxBarHeight) : 0;
  }
}

class BarData {
  BarData(this.label, this.value, this.height, {this.textColor});
  final String label;
  final String value;
  final double height;
  final Color? textColor;
}
