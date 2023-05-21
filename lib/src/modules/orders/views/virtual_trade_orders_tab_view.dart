import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../widgets/order_card_tile.dart';

class VirtualTradeOrdersTabView extends StatefulWidget {
  const VirtualTradeOrdersTabView({Key? key}) : super(key: key);

  @override
  State<VirtualTradeOrdersTabView> createState() => _VirtualTradeOrdersTabViewState();
}

class _VirtualTradeOrdersTabViewState extends State<VirtualTradeOrdersTabView> {
  late OrdersController controller;

  @override
  void initState() {
    controller = Get.find<OrdersController>();
    super.initState();
  }

  int segmentedControlValue = 0;

  Widget _segmentedControl() => Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 16),
        child: CupertinoSegmentedControl<int>(
          selectedColor: AppColors.primary,
          borderColor: AppColors.primary,
          unselectedColor: Colors.transparent,
          children: {
            0: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Today\'s Order\'s',
                style: AppStyles.tsWhiteRegular16,
              ),
            ),
            1: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'All Order\'s',
                style: AppStyles.tsWhiteRegular16,
              ),
            ),
          },
          onValueChanged: (int val) {
            setState(() {
              segmentedControlValue = val;
            });
          },
          groupValue: segmentedControlValue,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var ordersList =
            segmentedControlValue == 0 ? controller.virtualTradeTodaysOrdersList : controller.virtualTradeAllOrdersList;
        return Column(
          children: [
            _segmentedControl(),
            ordersList.isEmpty
                ? NoDataFound()
                : Expanded(
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
                                  valueColor:
                                      order.buyOrSell == AppConstants.buy ? AppColors.success : AppColors.danger,
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
                                  valueColor:
                                      order.status == AppConstants.complete ? AppColors.success : AppColors.danger,
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
                  )
          ],
        );
      },
    );
  }
}
