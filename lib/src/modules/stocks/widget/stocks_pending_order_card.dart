import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../../../core/core.dart';

class StocksPendingOrderCard extends StatefulWidget {
  final StocksPendingOrderData stopLoss;
  const StocksPendingOrderCard({
    Key? key,
    required this.stopLoss,
    required this.holding,
    required this.position,
  }) : super(key: key);
  final StockTradingHolding holding;
  final StockTradingPosition position;

  @override
  State<StocksPendingOrderCard> createState() => _StocksPendingOrderCardState();
}

class _StocksPendingOrderCardState extends State<StocksPendingOrderCard> {
  late StocksTradingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
    controller.getStockHoldingsList();
    controller.getStockPositionsList();
  }

  //posiiton

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 195,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 9, right: 9),
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
                    widget.stopLoss.status ?? '',
                    style: AppStyles.tsBlackSemiBold16.copyWith(
                      color: widget.stopLoss.status == "COMPLETE"
                          ? AppColors.success
                          : AppColors.danger,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.stopLoss.symbol ?? '',
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Price ",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    //  "₹$price",
                    FormatHelper.formatNumbers(
                      widget.stopLoss.price,
                    ),
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Timestamp",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    //timestamp,
                    FormatHelper.formatDateTimeToIST(
                        widget.stopLoss.executionTime),
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 7),
                  InkWell(
                    onTap: () {
                      // Your onTap logic goes here
                      // For example, you can show a dialog or navigate to another screen
                      print('InkWell tapped!');
                    },
                    child: Container(
                      width: 163.35,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.danger.withOpacity(.7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        'CANCEL',
                        style: AppStyles.tsWhiteSemiBold16
                        // .copyWith(color: AppColors.danger)
                        ,
                      ),
                    ),
                  ),
                ],
              ),

              // Right side
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      //type,
                      widget.stopLoss.buyOrSell ?? '',
                      style: AppStyles.tsBlackSemiBold16.copyWith(
                        color: widget.stopLoss.buyOrSell == "SELL"
                            ? AppColors.danger
                            : AppColors.success,
                      )),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        widget.stopLoss.quantity.toString(),
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
                      widget.stopLoss.amount,
                    ),
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Type",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    // "₹$totalamount",

                    widget.stopLoss.type.toString(),
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 7),
                  InkWell(
                    onTap: () {
                      // Your onTap logic goes here
                      // For example, you can show a dialog or navigate to another screen
                      print('InkWell tapped!');
                    },
                    child: Container(
                      width: 163.35,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.yellow[600],
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Text('MODIFY', style: AppStyles.tsWhiteSemiBold16),
                    ),
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
