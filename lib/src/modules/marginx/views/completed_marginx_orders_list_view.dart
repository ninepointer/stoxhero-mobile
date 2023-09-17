import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class CompletedMarginXOrdersListView extends GetView<MarginXController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MarginX Orders'),
      ),
      body: Obx(
        () => ListView.builder(
          shrinkWrap: true,
          itemCount: controller.completedMarginXOrdersList.length,
          itemBuilder: (context, index) {
            var order = controller.completedMarginXOrdersList[index];
            return CommonCard(
              children: [
                OrderCardTile(
                  label: 'Contract',
                  value: order.symbol,
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OrderCardTile(
                      label: 'Quantity',
                      value: FormatHelper.formatNumbers(order.quantity),
                      valueColor: order.quantity! < 0 ? AppColors.danger : AppColors.success,
                    ),
                    OrderCardTile(
                      isRightAlign: true,
                      label: 'Price',
                      value: FormatHelper.formatNumbers(order.averagePrice),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OrderCardTile(
                      label: 'Amount',
                      value: FormatHelper.formatNumbers(
                        order.amount,
                        isNegative: true,
                      ),
                    ),
                    OrderCardTile(
                      isRightAlign: true,
                      label: 'Type',
                      value: order.buyOrSell,
                      valueColor: order.buyOrSell == AppConstants.buy
                          ? AppColors.success
                          : AppColors.danger,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OrderCardTile(
                      label: 'Order ID',
                      value: order.orderId,
                    ),
                    OrderCardTile(
                      isRightAlign: true,
                      label: 'Status',
                      value: order.status,
                      valueColor: order.status == AppConstants.complete
                          ? AppColors.success
                          : AppColors.danger,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                OrderCardTile(
                  label: 'Time',
                  value: FormatHelper.formatDateTime(order.tradeTime),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
