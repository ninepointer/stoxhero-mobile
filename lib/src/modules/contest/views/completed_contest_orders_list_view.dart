import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class CompletedContestOrdersListView extends GetView<ContestController> {
  const CompletedContestOrdersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contest Orders'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: controller.contestTodaysOrdersList.isEmpty
              ? NoDataFound()
              : ListView.builder(
                  itemCount: controller.contestTodaysOrdersList.length,
                  itemBuilder: (context, index) {
                    var order = controller.contestTodaysOrdersList[index];
                    return CommonCard(
                      children: [
                        CommonCardTile(
                          label: 'Contract',
                          value: order.symbol,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonCardTile(
                              label: 'Quantity',
                              value: FormatHelper.formatNumbers(order.quantity),
                            ),
                            CommonCardTile(
                              isRightAlign: true,
                              label: 'Price',
                              value: FormatHelper.formatNumbers(order.averagePrice),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonCardTile(
                              label: 'Amount',
                              value: FormatHelper.formatNumbers(
                                order.amount,
                                isNegative: true,
                              ),
                            ),
                            CommonCardTile(
                              isRightAlign: true,
                              label: 'Type',
                              value: order.buyOrSell,
                              valueColor: order.buyOrSell == AppConstants.buy ? AppColors.success : AppColors.danger,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonCardTile(
                              label: 'Order ID',
                              value: order.orderId,
                            ),
                            CommonCardTile(
                              isRightAlign: true,
                              label: 'Status',
                              value: order.status,
                              valueColor: order.status == AppConstants.complete ? AppColors.success : AppColors.danger,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonCardTile(
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
      ),
    );
  }
}
