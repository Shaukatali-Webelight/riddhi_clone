import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';
import 'package:riddhi_clone/constants/app_enums.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/constants/app_styles.dart';
import 'package:riddhi_clone/resources/app_utils.dart';
import 'package:riddhi_clone/widgets/common/app_divider.dart';
import 'package:riddhi_clone/widgets/common/order_status_chip.dart';

class UserTotalProductsWidget extends StatelessWidget {
  const UserTotalProductsWidget({
    required this.username,
    required this.orderPlacedOn,
    required this.productsCount,
    required this.amount,
    required this.orderStatus,
    required this.orderId, // Default value for orderId, can be replaced with actual data source
    super.key,
  });

  final String username;
  final String orderPlacedOn;
  final String productsCount;
  final String amount;
  final OrderStatus orderStatus;
  final String orderId; // Placeholder for order ID, replace with actual data source

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConst.width,
      padding: const EdgeInsets.all(AppConst.k12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConst.k8),
        border: Border.all(
          color: AppColors.divider,
        ),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: AppConst.width * 0.63,
                    child: Text(
                      username,
                      style: AppStyles.getBoldStyle(),
                      maxLines: AppConst.k1.toInt(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${AppStrings.order} $orderId ${AppStrings.placedOn} $orderPlacedOn',
                    style: AppStyles.getLightStyle(
                      color: AppColors.secondaryText,
                      fontSize: AppConst.k14,
                    ),
                  ),
                ],
              ),
              OrderStatusChip(
                title: orderStatus.value,
                chipColor: AppUtils.getOrderStatusColor(orderStatus),
              ),
            ],
          ),
          const AppDivider(),
          //! Products and amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '$productsCount ${int.parse(productsCount) <= 1 ? AppStrings.product : AppStrings.products}',
                  style: AppStyles.getRegularStyle(),
                ),
              ),
              Text(
                amount,
                style: AppStyles.getRegularStyle(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
