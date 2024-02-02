import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class CompletedMarginXOrdersListView extends GetView<MarginXController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${controller.completedMarginX.value.marginxName} \n Order Book',
          style: Theme.of(context).textTheme.tsRegular16,
          textAlign: TextAlign.center,
        ),
      ),
      body: Obx(
        () => Visibility(
          visible: controller.isOrdersLoadingStatus,
          child: ListViewShimmer(
            shimmerCard: LargeCardShimmer(),
          ),
          replacement: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.completedMarginXOrdersList.length,
            itemBuilder: (context, index) {
              var order = controller.completedMarginXOrdersList[index];
              return CommonCard(
                margin: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 4),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OrderCardTile(
                        label: 'Symbol',
                        value: order.symbol,
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
                        label: 'Quantity',
                        value: order.quantity.toString(),
                        valueColor: order.quantity! < 0
                            ? AppColors.danger
                            : AppColors.success,
                      ),
                      OrderCardTile(
                        isRightAlign: true,
                        label: 'Price',
                        value: FormatHelper.formatNumbers(order.averagePrice),
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
                      OrderCardTile(
                        label: 'Order ID',
                        value: order.orderId,
                      ),
                      OrderCardTile(
                        isRightAlign: true,
                        label: 'Timestamp',
                        value: FormatHelper.formatDateTime(order.tradeTime),
                      ),
                      //ijj
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
