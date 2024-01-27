import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

class VirtualTradeOrdersTabView extends GetView<OrdersController> {
  final ScrollController _scrollController = ScrollController();
  VirtualTradeOrdersTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var ordersList = controller.segmentedControlValue.value == 0
            ? controller.virtualTradeTodaysOrdersList
            : controller.virtualTradeAllOrdersList;

        _scrollController.addListener(() {
          if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent) {
            controller.loadMoreOrders();
          }
        });
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
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: ordersList.length + 1,
                  itemBuilder: (context, index) {
                    if (index < ordersList.length) {
                      var order = ordersList[index];
                      return CommonCard(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OrderCardTile(
                                label: 'Symbol',
                                value: order.symbol,
                              ),
                              OrderCardTile(
                                label: 'Quantity',
                                value: order.quantity.toString(),
                                isRightAlign: true,
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
                              OrderCardTile(
                                label: 'Timestamp',
                                value: FormatHelper.formatDateTime(
                                    order.tradeTime),
                              ),
                              OrderCardTile(
                                isRightAlign: true,
                                label: 'Status',
                                value: order.status,
                                valueColor:
                                    order.status == AppConstants.complete
                                        ? AppColors.success
                                        : AppColors.danger,
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (!controller.isLoadingMore.value &&
                        ordersList.length > 20 &&
                        controller.itemsPerPage.value > 0) {
                      return Container(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
