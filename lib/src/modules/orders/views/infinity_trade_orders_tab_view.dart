import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

class InfinityTradeOrdersTabView extends StatefulWidget {
  const InfinityTradeOrdersTabView({Key? key}) : super(key: key);

  @override
  State<InfinityTradeOrdersTabView> createState() => _InfinityTradeOrdersTabViewState();
}

class _InfinityTradeOrdersTabViewState extends State<InfinityTradeOrdersTabView> {
  late OrdersController controller;

  int? grouValue;

  @override
  void initState() {
    controller = Get.find<OrdersController>();
    super.initState();
  }

  void updateSelecteBuySell(int? value) {
    if (grouValue == value) {
      grouValue = null;
    } else {
      grouValue = value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var ordersList = controller.segmentedControlValue.value == 0
            ? controller.infinityTradeTodaysOrdersList
            : controller.infinityTradeAllOrdersList;
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

            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 16),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //     border: Border.all(
            //       color: AppColors.grey.shade400,
            //     ),
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: RadioListTile(
            //           visualDensity: VisualDensity.compact,
            //           contentPadding: EdgeInsets.zero,
            //           activeColor: AppColors.secondary,
            //           title: Text(
            //             'Buy',
            //             style: Theme.of(context).textTheme.tsMedium16,
            //           ),
            //           value: 0,
            //           groupValue: grouValue,
            //           onChanged: updateSelecteBuySell,
            //         ),
            //       ),
            //       Expanded(
            //         child: RadioListTile(
            //           visualDensity: VisualDensity.compact,
            //           contentPadding: EdgeInsets.zero,
            //           activeColor: AppColors.secondary,
            //           title: Text(
            //             'Sell',
            //             style: Theme.of(context).textTheme.tsMedium16,
            //           ),
            //           value: 1,
            //           groupValue: grouValue,
            //           onChanged: updateSelecteBuySell,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
              )
          ],
        );
      },
    );
  }
}
