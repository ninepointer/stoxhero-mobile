import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class OrderCard extends GetView<ContestController> {
  final String? orderId;
  final String? status;
  final double? averagePrice;
  final int? quantity;
  final String? product;
  final String? buyOrSell;
  final String? symbol;
  final double? amount;
  final String? tradeTime;
  const OrderCard(
      {Key? key,
      this.orderId,
      this.status,
      this.averagePrice,
      this.quantity,
      this.product,
      this.buyOrSell,
      this.symbol,
      this.amount,
      this.tradeTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: Obx(
        () {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: controller.contestTodaysOrdersList.length,
                itemBuilder: (context, index) {
                  var order = controller.contestTodaysOrdersList[index];
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OrderCardTile(
                            label: 'Time',
                            value: FormatHelper.formatDateTime(order.tradeTime),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
