import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../../../core/core.dart';

class OrdersCard extends StatelessWidget {
  const OrdersCard({
    Key? key,
    // required this.quantity,
    // required this.price,
    // required this.totalamount,
    // required this.timestamp,
    // required this.orderid,
    // required this.status,
    // required this.symbol,
    // required this.type,
    required this.order,
  }) : super(key: key);

  // final String quantity;
  // final String price;
  // final String totalamount;
  // final String timestamp;
  // final String orderid;
  // final String status;
  // final String symbol;
  // final String type;
  final StockTodayTradeOrder order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 170,
        width: double.infinity,
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Color(0xFF1B2937) : Colors.white,
          borderRadius:
              BorderRadius.circular(25.0), // Adjust the radius as needed
          boxShadow: [
            BoxShadow(
              color: Get.isDarkMode
                  ? Color(0xFF151F2B).withOpacity(0.8)
                  : Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //status,
                    order.status ?? '',
                    style: AppStyles.tsBlackSemiBold16.copyWith(
                      color: order.status == "COMPLETE"
                          ? AppColors.success
                          : AppColors.danger,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    order.symbol ?? '',
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black
                        ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Price ",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    //  "₹$price",
                    FormatHelper.formatNumbers(
                      order.averagePrice,
                    ),
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Order ID",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    order.orderId ?? '',
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  )
                ],
              ),

              // Right side
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      //type,
                      order.buyOrSell ?? '',
                      style: AppStyles.tsBlackSemiBold16.copyWith(
                        color: order.buyOrSell == "SELL"
                            ? AppColors.danger
                            : AppColors.success,
                      )),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        order.quantity.toString(),
                        style: AppStyles.tsBlackMedium12.copyWith(
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      ),
                      Text(
                        " Quantity",
                        style: AppStyles.tsGreyRegular12,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Amount",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    // "₹$totalamount",
                    FormatHelper.formatNumbers(
                      order.amount,
                    ),
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Timestamp",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    //timestamp,
                    FormatHelper.formatDateTimeToIST(order.tradeTime),
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
