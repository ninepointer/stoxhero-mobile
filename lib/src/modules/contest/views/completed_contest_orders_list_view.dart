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
        title: Text(
          '${controller.completedContest.value.contestName}\n Order Book',
          style: Theme.of(context).textTheme.tsRegular16,
          textAlign: TextAlign.center,
        ),
      ),
      body: Obx(
        () => Visibility(
          visible: controller.isCompletedOrdersLoadingStatus,
          child: ListViewShimmer(
            itemCount: 10,
            shimmerCard: LargeCardShimmer(),
          ),
          replacement: controller.contestOrdersList.isEmpty
              ? NoDataFound()
              : ListView.builder(
                  itemCount: controller.contestOrdersList.length,
                  itemBuilder: (context, index) {
                    var order = controller.contestOrdersList[index];
                    return CommonCard(
                      margin:
                          EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
                      children: [
                        OrderCardTile(
                          label: 'Contract',
                          value: order.symbol,
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OrderCardTile(
                              label: 'Quantity',
                              value: order.quantity?.toString(),
                            ),
                            OrderCardTile(
                              isRightAlign: true,
                              label: 'Price',
                              value: FormatHelper.formatNumbers(
                                  order.averagePrice),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
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
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: OrderCardTile(
                                label: 'Order ID',
                                value: order.orderId,
                              ),
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
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OrderCardTile(
                              label: 'Timestamp',
                              value:
                                  FormatHelper.formatDateTime(order.tradeTime),
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
