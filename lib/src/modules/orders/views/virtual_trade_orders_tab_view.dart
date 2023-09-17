import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

class VirtualTradeOrdersTabView extends GetView<OrdersController> {
  const VirtualTradeOrdersTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var ordersList = controller.segmentedControlValue.value == 0
            ? controller.virtualTradeTodaysOrdersList
            : controller.virtualTradeAllOrdersList;
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
              ),
          ],
        );
      },
    );
  }
}
