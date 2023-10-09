import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenxTradeOrdersTabView extends GetView<OrdersController> {
  final String? tenxSub;

  const TenxTradeOrdersTabView({
    Key? key,
    this.tenxSub,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var ordersList = controller.segmentedControlValue.value == 0
            ? controller.tenxTradeTodaysOrdersList
            : controller.tenxTradeAllOrdersList;
        return Column(
          children: [
            CommonSegmentedControl(
              segments: {
                0: 'Today\'s Orders',
                1: 'All Orders',
              },
              selectedSegment: controller.segmentedControlValue.value,
              onValueChanged: controller.handleSegmentChange,
            ),
            if (ordersList.isEmpty)
              NoDataFound()
            else
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ordersList.length,
                  itemBuilder: (context, index) {
                    var order = ordersList[index];
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
                              value: order.quantity.toString(),
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
                              valueColor: order.buyOrSell == AppConstants.buy ? AppColors.success : AppColors.danger,
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
                              valueColor: order.status == AppConstants.complete ? AppColors.success : AppColors.danger,
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OrderCardTile(
                              label: 'Timestamp',
                              value: FormatHelper.formatDateTime(order.tradeTimeUtc),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              )
          ],
        );
      },
    );
  }
}
