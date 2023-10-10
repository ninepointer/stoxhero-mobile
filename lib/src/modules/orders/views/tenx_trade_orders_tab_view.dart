import 'package:dropdown_button2/dropdown_button2.dart';
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
    print(controller.populateDropdownItems(controller.tenXSubscription));
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField2<String>(
                value: controller.selectedItem1.value,
                onChanged: (value) => controller.selectedItem1(value),
                items: controller.dropdownItems1.map((String title) {
                  return DropdownMenuItem<String>(
                    value: title,
                    child: Text(title.toString()),
                  );
                }).toList(),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16).copyWith(left: 0),
                  filled: true,
                  fillColor: AppColors.grey.withOpacity(.1),
                  hintText: 'Tenx Plan',
                  hintStyle: AppStyles.tsGreyRegular14,
                  errorStyle: AppStyles.tsGreyRegular12.copyWith(
                    color: AppColors.danger.shade700,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.grey.withOpacity(.25),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            // // Second Dropdown
            // DropdownButtonFormField<String>(
            //   value: controller.selectedItem2.value,
            //   onChanged: (value) => controller.selectedItem2(value),
            //   items: controller.dropdownItems2.map((String item) {
            //     return DropdownMenuItem<String>(
            //       value: item,
            //       child: Text(item),
            //     );
            //   }).toList(),
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
